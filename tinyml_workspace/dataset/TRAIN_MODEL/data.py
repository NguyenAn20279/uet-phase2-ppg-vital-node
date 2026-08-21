import numpy as np
import pandas as pd
import os

# ============================================================
# 1. Cấu hình tham số
# ============================================================
FS = 25                     # 25 Hz (40ms một mẫu)
DURATION = 5                # 5 giây
N_POINTS = FS * DURATION    # 125 điểm
N_SAMPLES = 5000            # Số mẫu
CSV_SAMPLES = 500           # Số mẫu lưu vào CSV để xem
np.random.seed(42)

# ============================================================
# 2. Hàm tạo tín hiệu PPG giả lập (đã qua lọc và chuẩn hóa Z-score)
# ============================================================
def generate_ppg_sequence(hr, ac, dc, fs=FS, n_points=N_POINTS):
    """
    Tạo một chuỗi tín hiệu PPG dài n_points, mô phỏng dạng sóng tim
    với nhịp tim hr (BPM), biên độ xoay chiều ac, thành phần một chiều dc.
    Trả về chuỗi đã chuẩn hóa Z-score (mean=0, std=1).
    """
    t = np.linspace(0, n_points/fs, n_points, endpoint=False)
    period = 60 / hr
    phase = (t % period) / period
    pulse = np.exp(-6 * phase) * (1 - phase) * 3.0
    pulse += 0.3 * np.sin(2 * np.pi * phase * 2)
    signal = pulse * ac / 0.3 + dc
    signal += np.random.normal(0, 0.02 * ac, n_points)
    mean = np.mean(signal)
    std = np.std(signal)
    if std < 1e-6:
        std = 1.0
    return (signal - mean) / std

# ============================================================
# 3. Sinh các thông số sinh lý (chỉ để tạo ra tín hiệu và nhãn)
# ============================================================
hr = np.random.uniform(55, 110, N_SAMPLES)
spo2 = np.random.normal(97, 2, N_SAMPLES)
spo2 = np.clip(spo2, 94, 100)

dc_red = np.random.uniform(15000, 25000, N_SAMPLES)
dc_ir  = np.random.uniform(20000, 30000, N_SAMPLES)
ac_red = np.random.uniform(200, 800, N_SAMPLES)
ac_ir  = ac_red * np.random.uniform(0.8, 1.2, N_SAMPLES) + np.random.normal(0, 20, N_SAMPLES)
ac_ir  = np.clip(ac_ir, 150, 700)

# ============================================================
# 4. Tạo nhãn huyết áp (SBP, DBP) từ các thông số
# ============================================================
sbp = (110
       + 0.5 * (hr - 75)
       - 1.2 * (spo2 - 97)
       + 0.015 * (ac_red - 500)
       + 0.008 * (dc_red - 20000)
       + np.random.normal(0, 6, N_SAMPLES))
dbp = (70
       + 0.35 * (hr - 75)
       - 0.8 * (spo2 - 97)
       + 0.008 * (ac_ir - 400)
       + 0.005 * (dc_ir - 25000)
       + np.random.normal(0, 5, N_SAMPLES))
sbp = np.clip(sbp, 90, 180)
dbp = np.clip(dbp, 55, 120)

# ============================================================
# 5. Tạo ma trận chuỗi tín hiệu
# ============================================================
print("Đang tạo chuỗi tín hiệu...")
X_red = np.zeros((N_SAMPLES, N_POINTS))
X_ir = np.zeros((N_SAMPLES, N_POINTS))
for i in range(N_SAMPLES):
    X_red[i, :] = generate_ppg_sequence(hr[i], ac_red[i], dc_red[i])
    X_ir[i, :] = generate_ppg_sequence(hr[i], ac_ir[i], dc_ir[i])

# ============================================================
# 6. Lưu dữ liệu: file .npz cho training, file CSV để xem
# ============================================================
output_dir = './data_seq'
os.makedirs(output_dir, exist_ok=True)

# Lưu .npz (đầy đủ)
np.savez(os.path.join(output_dir, 'ppg_sequence_data.npz'),
         X_red=X_red,
         X_ir=X_ir,
         y_sbp=sbp,
         y_dbp=dbp)

# Tạo CSV cho một số mẫu đầu để xem
csv_samples = min(CSV_SAMPLES, N_SAMPLES)
# Tạo DataFrame với các cột nhãn và chuỗi
data_for_csv = {
    'sbp': sbp[:csv_samples],
    'dbp': dbp[:csv_samples]
}
# Thêm các cột cho Red
for i in range(N_POINTS):
    data_for_csv[f'red_{i}'] = X_red[:csv_samples, i]
# Thêm các cột cho IR
for i in range(N_POINTS):
    data_for_csv[f'ir_{i}'] = X_ir[:csv_samples, i]

df = pd.DataFrame(data_for_csv)
csv_path = os.path.join(output_dir, 'sample_data.csv')
df.to_csv(csv_path, index=False)

print(f"Đã lưu {N_SAMPLES} mẫu vào {os.path.join(output_dir, 'ppg_sequence_data.npz')}")
print(f"Đã lưu {csv_samples} mẫu vào {csv_path} để xem")
print(f"X_red shape: {X_red.shape}, X_ir shape: {X_ir.shape}")
print(f"y_sbp shape: {sbp.shape}, y_dbp shape: {dbp.shape}")
print("\nVí dụ 3 mẫu đầu tiên (từ CSV):")
print(df.head(3))