# UET Phase 2 - Team 7: Hệ Thống Node Thiết Bị Y Tế Đeo Tay Thông Minh

Hệ thống giám sát sinh hiệu thời gian thực sử dụng **FreeRTOS**, bộ tăng tốc phần cứng **TinyML (MVP)** và truyền thông **BLE 5.4** mã hóa **AES-CCM** trên nền tảng vi điều khiển Silicon Labs.

---

## Kiến Trúc Tổng Quan Dự Án

Dự án gồm 2 project chính được khởi tạo sẵn từ **Simplicity Studio v6 (Silicon Labs SDK)**:

* **`firmware/node_xg26/`**: Khối Node biên đeo tay.
  * Thu thập tín hiệu PPG từ **MAX30102** (I2C, FIFO 100Hz).
  * Tiền xử lý số: lọc **EMA** + bandpass **IIR SOS**, chuẩn hóa **Z-score** (cửa sổ 800 mẫu / 8s).
  * Chạy mô hình TinyML **1D CNN ResNet + SE** (PTQ INT8) trên bộ tăng tốc **MVP** (độ trễ &lt; 80ms).
  * Đóng gói kết quả sinh hiệu thành gói tin **8-byte**, mã hóa **AES-CCM** và phát **BLE 5.4 Encrypted Advertising**.
* **`firmware/gateway_bgm220p/`**: Khối Gateway nhận & Hiển thị.
  * Thu nhận và giải mã gói tin BLE 5.4 (AES-CCM) từ Node.
  * Kiểm tra Packet Counter chống **Replay Attack**.
  * Hiển thị HR / SpO2 / SBP / DBP lên màn hình **OLED (SH1106)**.

---

## Cấu Trúc Thư Mục Toàn Repo

```text
uet-phase2-ppg-vital-node/
├── .gitignore                            <-- Gitignore chung (chặn autogen, build, dataset thô lớn)
├── README.md                             <-- Giới thiệu dự án, hướng dẫn build & quy tắc
│
├── doc/                                  <-- Tài liệu thiết kế dự án
│   ├── Requirement_Team7.docx            <-- File yêu cầu kỹ thuật của nhóm
│   ├── Timeline_Team7.xlsx               <-- Kế hoạch & tiến độ thực hiện
│   ├── pin-mapping.md                    <-- Bảng ánh xạ chân GPIO cho Node và Gateway
│   └── [Nhóm 9]_Báo cáo cuối kỳ.pdf      <-- Báo cáo Phase 1 (nền tảng đề tài)
│
├── hardware/                             <-- Thiết kế phần cứng (sinh viên tự tổ chức)
│   ├── gateway/
│   └── node/
│
├── tinyml_workspace/                     <-- Workspace AI / TinyML (sinh viên tự tổ chức)
│   ├── dataset/
│   └── scripts/
│
└── firmware/                             <-- Mã nguồn nhúng (Silicon Labs SDK + FreeRTOS)
    ├── gateway_bgm220p/                  <-- Project Gateway (Simplicity Studio Init)
    │   ├── app.c
    │   ├── main.c
    │   └── gateway_bgm220p.slcp
    │
    └── node_xg26/                        <-- Project Node (Simplicity Studio Init)
        ├── app.c
        ├── main.c
        └── node_xg26.slcp
```

---

## Cấu Trúc Thư Mục Gợi Ý Chi Tiết Cho Firmware (Layered Architecture)

Khi phát triển thêm các tính năng mới, khuyến khích tổ chức code theo phân tầng (Layered Architecture) để tránh viết dồn vào `app.c` và giúp phân công công việc không bị giẫm chân lên nhau:

```text
firmware/
├── gateway_bgm220p/                      <-- [BOARD GATEWAY]
│   ├── inc/
│   │   ├── app/                          <-- [Layer 4: Application]
│   │   │   ├── app_gateway.h             (FreeRTOS Task management & Event Handling)
│   │   │   └── app_config.h              (Cấu hình Queue, Semaphore, Stack size)
│   │   ├── service/                      <-- [Layer 3: Service / Protocol & UI]
│   │   │   ├── ble_crypto_rx.h           (Thu nhận & giải mã AES-CCM BLE 5.4)
│   │   │   ├── replay_guard.h            (Kiểm tra Packet Counter chống Replay Attack)
│   │   │   ├── display_service.h         (Quản lý layout hiển thị trên OLED)
│   │   │   └── uart_display.h            (Gửi dữ liệu lên PC / Serial Log)
│   │   ├── bsp/                          <-- [Layer 2: Board Support Package]
│   │   │   ├── oled_sh1106.h             (Driver I2C vẽ pixel & char thô cho OLED SH1106)
│   │   │   └── indicator.h               (Driver điều khiển LED / Buzzer cảnh báo)
│   │   └── utils/                        <-- [System Utilities / Common Layer]
│   │       ├── debug_log.h               (Logger wrapper qua UART IO Stream)
│   │       ├── packet_format.h           (Định nghĩa gói tin plaintext 8-byte)
│   │       └── error_codes.h             (Định nghĩa mã lỗi chung)
│   │
│   ├── src/
│   │   ├── app/
│   │   │   └── app_gateway.c
│   │   ├── service/
│   │   │   ├── ble_crypto_rx.c
│   │   │   ├── replay_guard.c
│   │   │   ├── display_service.c
│   │   │   └── uart_display.c
│   │   ├── bsp/
│   │   │   ├── oled_sh1106.c
│   │   │   └── indicator.c
│   │   └── utils/
│   │
│   ├── config/                           (Cấu hình SDK)
│   ├── app.c                             (Entry point sinh bởi Silabs SDK)
│   ├── main.c
│   └── gateway_bgm220p.slcp
│
└── node_xg26/                            <-- [BOARD NODE SINH HIỆU]
    ├── inc/
    │   ├── app/                          <-- [Layer 4: Application]
    │   │   ├── app_node.h                (Quản lý các FreeRTOS Tasks: PPG, Filter, AI, BLE)
    │   │   └── app_config.h              (Cấu hình RTOS task stack & priority)
    │   ├── service/                      <-- [Layer 3: Service / AI & Network]
    │   │   ├── signal_filter.h           (EMA + IIR SOS + Z-score, cửa sổ 800 mẫu)
    │   │   ├── tinyml_mvp_runner.h       (Suy luận 1D CNN ResNet+SE trên MVP, latency < 80ms)
    │   │   └── ble_crypto_tx.h           (Đóng gói 8-byte, AES-CCM & Encrypted Advertising)
    │   ├── bsp/                          <-- [Layer 2: Board Support Package]
    │   │   └── max30102.h                (Driver I2C đọc FIFO PPG + GPIO INT)
    │   └── utils/                        <-- [System Utilities / Common Layer]
    │       ├── debug_log.h               (Logger wrapper qua UART IO Stream)
    │       ├── packet_format.h           (Định nghĩa gói tin plaintext 8-byte)
    │       └── error_codes.h             (Định nghĩa mã lỗi dự đoán)
    │
    ├── src/
    │   ├── app/
    │   │   └── app_node.c
    │   ├── service/
    │   │   ├── signal_filter.c
    │   │   ├── tinyml_mvp_runner.c
    │   │   └── ble_crypto_tx.c
    │   ├── bsp/
    │   │   └── max30102.c
    │   └── utils/
    │
    ├── config/                           (Cấu hình SDK, MVP Acceleration & FreeRTOSConfig.h)
    ├── app.c
    ├── main.c
    └── node_xg26.slcp
```

---

## Hướng Dẫn Khởi Chạy (Quickstart for Team Members)

### 1. Clone Repository về máy local

```bash
git clone https://github.com/NguyenAn20279/uet-phase2-ppg-vital-node.git
```

### 2. Import Project vào Simplicity Studio

1. Mở **Simplicity Studio v6**.
2. Chọn **File → OpenProject(s)...** → trỏ tới thư mục `firmware/node_xg26` (hoặc `firmware/gateway_bgm220p`).
3. Kiểm tra thông số SDK và Toolchain (GCC Embedded), nhấn **Finish**.

### 3. Force Generation (bắt buộc trước khi Build)

Repo Git **không** chứa `autogen/` và `simplicity_sdk_*/`. Sau khi open project lần đầu (hoặc sau khi clone máy mới), phải generate lại trước khi build — nếu bỏ qua sẽ lỗi build.

1. Mở file `.slcp` của project (`node_xg26.slcp` hoặc `gateway_bgm220p.slcp`) để vào trang **Overview / Project Details**.
2. Ở góc phải phần **Project Details**, bấm menu **⋯** (ba chấm).
3. Chọn **Force Generation**.
4. Chờ generate xong (SDK được link, thư mục `autogen/` được tạo) rồi mới sang bước Build.

> Làm lần lượt cho cả `node_xg26` và `gateway_bgm220p` nếu dùng cả hai board.

### 4. Build & Flash bằng Simplicity for VS Code

1. Kết nối board tương ứng (XG26 / BGM220P) qua USB.
2. Mở panel **Si** (Silicon Labs) trên Activity Bar bên trái của VS Code.
3. Trong danh sách project, hover vào `node_xg26` hoặc `gateway_bgm220p` rồi bấm **Build**.
4. Sau khi build thành công, bấm **Flash** trên cùng project (chọn file `.hex`/`.bin` nếu được hỏi) để nạp firmware lên board.
5. Kiểm tra project chạy bình thường trước khi thêm tính năng mới.

> Tip: Khi đang mở file thuộc project, có thể dùng shortcut **Build / Flash / Debug** ngay trên Status Bar phía dưới VS Code.

---

## Quy Tắc Phát Triển & Commit Code (Bắt Buộc)

Để tránh làm hỏng dự án của nhau và xung đột Git, tất cả thành viên phải tuân thủ các quy tắc sau:

### 1. Không viết dồn code vào `app.c`

- File `app.c` chỉ dùng để khởi tạo luồng chạy chính và quản lý Task của FreeRTOS.
- Khi viết tính năng mới (driver cảm biến, thuật toán AI, giao diện OLED), bắt buộc tạo file `.c` và `.h` riêng.
- Đặt tên file rõ ràng theo tính năng (ví dụ: `max30102.c`, `tinyml_mvp_runner.c`, `oled_sh1106.c`).

### 2. Thêm file mới đúng cách trên Simplicity Studio 6

Nên tạo file `.c`/`.h` bằng **New File/Folder trong Simplicity Studio 6** (không tạo tay trên VS Code) để IDE tự nhận diện và cập nhật đường dẫn vào file `.slcp` cho toolchain.

### 3. Xử lý file cấu hình `.slcp` khi Push/Pull code

File `.slcp` chứa thông tin cấu hình project do IDE quản lý. Khi nhiều người cùng thêm file mới, file này rất dễ bị Git conflict.

**Giải pháp:** Nếu gặp conflict ở file `.slcp`, mở file đó bằng VS Code hoặc Text Editor để giữ lại cả 2 đoạn đường dẫn `<source>` và `<include>` mới của các thành viên.

### 4. Quản lý Git Clean

- **KHÔNG** commit các thư mục sinh ra tự động khi build như: `build/`, `autogen/`, `simplicity_sdk_*/`, ... (đã được cấu hình sẵn trong `.gitignore`).
- Chỉ commit các file mã nguồn do người viết: `.c`, `.h`, `.slcp`, `config/`.

---

## Phân Công Nhiệm Vụ Tham Khảo

| Vai trò | Layer | Nhiệm vụ chính |
|---|---|---|
| Hardware & Sensor Driver | BSP | MAX30102 (I2C/INT), OLED SH1106, PCB Gateway |
| AI & Signal Processing | Service | EMA/IIR/Z-score, 1D CNN ResNet+SE trên MVP |
| Communication & Network | Service | BLE 5.4 AES-CCM, gói tin 8-byte, Replay Guard |
| System & RTOS Integration | App | FreeRTOS tasks, Stream Buffer/Queue/Semaphore |
