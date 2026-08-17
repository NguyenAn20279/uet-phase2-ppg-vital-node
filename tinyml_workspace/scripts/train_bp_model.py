# ============================================================
# train_bp_model.py
# Huan luyen mo hinh du doan huyet ap tu PPG (Red & IR) + HR + SpO2
#
# Dinh dang du lieu vao (tu ppg_sequence_data.npz):
#   red_z, ir_z : (N, 125)  - waveform da qua EMA+bandpass+z-score
#   hr, spo2    : (N,)      - tinh bang cong thuc (calc_hr/calc_spo2), KHONG phai AI
# Dau ra:
#   sbp, dbp    : (N,)      - nhan that (do bang cuff, hoac gia lap de test pipeline)
#
# Kien truc: multi-input
#   Nhanh A (CNN)   : waveform [125, 2] -> dac trung hinh dang song
#   Nhanh B (Dense) : [hr, spo2]        -> dac trung sinh ly
#   concat 2 nhanh -> Dense -> [sbp, dbp]
#
# LUU Y QUAN TRONG (khong sua trong file nay):
# red_z/ir_z phai duoc tao ra bang dung thuat toan z-score RUNNING-WINDOW
# (200 mau, chay lien tuc, khong reset) y het filter.c, tu buoc tien xu ly
# RIENG truoc khi tao file .npz nay. File train nay chi doc du lieu da co san,
# khong co quyen truy cap chuoi tin hieu tho phia truoc nen KHONG THE va
# KHONG NEN sua van de do o day.
# ============================================================

import numpy as np
import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
import tensorflow as tf
from tensorflow.keras import layers, models, callbacks

# -------------------- 1. Cau hinh --------------------
DATA_PATH = './data_seq/ppg_sequence_data.npz'
MODEL_DIR = './models'
os.makedirs(MODEL_DIR, exist_ok=True)

N_POINTS = 125
RANDOM_SEED = 42
TEST_SIZE = 0.15
VAL_SIZE = 0.15   # tinh tren phan con lai sau khi tach test

# -------------------- 2. Tai du lieu --------------------
print("Loading data...")
data = np.load(DATA_PATH)
red_z = data['red_z']    # (N, 125)
ir_z  = data['ir_z']     # (N, 125)
hr    = data['hr']       # (N,)
spo2  = data['spo2']     # (N,)
y_sbp = data['y_sbp']    # (N,)
y_dbp = data['y_dbp']    # (N,)

N = red_z.shape[0]
print(f"Total samples: {N}")

# Nhanh waveform: ghep 2 kenh -> (N, 125, 2)
X_wave = np.stack([red_z, ir_z], axis=-1).astype(np.float32)
# Nhanh scalar: ghep hr + spo2 -> (N, 2)
X_meta = np.stack([hr, spo2], axis=-1).astype(np.float32)
# Nhan
y = np.stack([y_sbp, y_dbp], axis=-1).astype(np.float32)  # (N, 2)

# -------------------- 3. Chia train/val/test --------------------
# LUU Y VOI DU LIEU THAT: phai chia theo subject_id (tach hoan toan nguoi
# o tap train khoi tap test), KHONG duoc chia random theo tung cua so nhu
# duoi day - vi cac cua so lien tiep cua cung 1 nguoi rat giong nhau, chia
# random se lam ro ri thong tin (data leakage) va danh gia sai lech ket qua.
# Voi du lieu gia lap (moi sample doc lap) thi chia random nhu duoi la on.
idx = np.arange(N)
idx_temp, idx_test = train_test_split(idx, test_size=TEST_SIZE, random_state=RANDOM_SEED)
idx_train, idx_val = train_test_split(idx_temp, test_size=VAL_SIZE / (1 - TEST_SIZE),
                                       random_state=RANDOM_SEED)

Xw_train, Xm_train, y_train = X_wave[idx_train], X_meta[idx_train], y[idx_train]
Xw_val,   Xm_val,   y_val   = X_wave[idx_val],   X_meta[idx_val],   y[idx_val]
Xw_test,  Xm_test,  y_test  = X_wave[idx_test],  X_meta[idx_test],  y[idx_test]

print(f"Train: {len(idx_train)}, Val: {len(idx_val)}, Test: {len(idx_test)}")

# -------------------- 4. Chuan hoa nhanh scalar (hr, spo2) --------------------
# hr/spo2 co thang do rat khac waveform da z-score (mean~0,std~1) - can
# chuan hoa rieng de khong lam mat can bang gradient giua 2 nhanh.
# Fit CHI tren tap train, ap dung lai cho val/test (tranh ro ri thong tin).
meta_mean = Xm_train.mean(axis=0)
meta_std  = Xm_train.std(axis=0)
meta_std[meta_std < 1e-6] = 1.0

def norm_meta(x):
    return (x - meta_mean) / meta_std

Xm_train_n = norm_meta(Xm_train)
Xm_val_n   = norm_meta(Xm_val)
Xm_test_n  = norm_meta(Xm_test)

np.save(os.path.join(MODEL_DIR, 'meta_mean.npy'), meta_mean)
np.save(os.path.join(MODEL_DIR, 'meta_std.npy'), meta_std)

# -------------------- 5. Xay dung mo hinh multi-input --------------------
def build_model(wave_shape=(N_POINTS, 2), meta_shape=(2,)):
    # Nhanh A: waveform
    wave_in = layers.Input(shape=wave_shape, name='waveform')
    x = layers.Conv1D(8, 3, activation='relu', padding='same')(wave_in)
    x = layers.MaxPooling1D(2)(x)
    x = layers.Conv1D(16, 3, activation='relu', padding='same')(x)
    x = layers.MaxPooling1D(2)(x)
    x = layers.Conv1D(32, 3, activation='relu', padding='same')(x)
    x = layers.GlobalAveragePooling1D()(x)

    # Nhanh B: hr, spo2 (da chuan hoa)
    meta_in = layers.Input(shape=meta_shape, name='meta')
    m = layers.Dense(16, activation='relu')(meta_in)

    concat = layers.Concatenate()([x, m])
    out = layers.Dense(16, activation='relu')(concat)
    out = layers.Dense(2, name='sbp_dbp')(out)  # [sbp, dbp]

    return models.Model(inputs=[wave_in, meta_in], outputs=out)

model = build_model()
model.summary()

model.compile(optimizer=tf.keras.optimizers.Adam(learning_rate=1e-3),
              loss='mse',
              metrics=['mae'])

# -------------------- 6. Callbacks --------------------
callbacks_list = [
    callbacks.EarlyStopping(monitor='val_loss', patience=20, restore_best_weights=True),
    callbacks.ModelCheckpoint(filepath=os.path.join(MODEL_DIR, 'best_model.keras'),
                               monitor='val_loss', save_best_only=True),
    callbacks.ReduceLROnPlateau(monitor='val_loss', factor=0.5, patience=10, min_lr=1e-6)
]

# -------------------- 7. Huan luyen --------------------
history = model.fit(
    [Xw_train, Xm_train_n], y_train,
    validation_data=([Xw_val, Xm_val_n], y_val),
    epochs=100,
    batch_size=32,
    callbacks=callbacks_list,
    verbose=1
)

# -------------------- 8. Danh gia tren tap test --------------------
best_model = tf.keras.models.load_model(os.path.join(MODEL_DIR, 'best_model.keras'))
y_pred = best_model.predict([Xw_test, Xm_test_n])

mae_sbp = mean_absolute_error(y_test[:, 0], y_pred[:, 0])
mae_dbp = mean_absolute_error(y_test[:, 1], y_pred[:, 1])
rmse_sbp = np.sqrt(mean_squared_error(y_test[:, 0], y_pred[:, 0]))
rmse_dbp = np.sqrt(mean_squared_error(y_test[:, 1], y_pred[:, 1]))
r2_sbp = r2_score(y_test[:, 0], y_pred[:, 0])
r2_dbp = r2_score(y_test[:, 1], y_pred[:, 1])

print("\n======= Test Evaluation =======")
print(f"SBP - MAE: {mae_sbp:.2f} mmHg, RMSE: {rmse_sbp:.2f} mmHg, R2: {r2_sbp:.3f}")
print(f"DBP - MAE: {mae_dbp:.2f} mmHg, RMSE: {rmse_dbp:.2f} mmHg, R2: {r2_dbp:.3f}")

# Ve loss
plt.figure(figsize=(10, 4))
plt.plot(history.history['loss'], label='Train Loss')
plt.plot(history.history['val_loss'], label='Val Loss')
plt.xlabel('Epoch')
plt.ylabel('MSE Loss')
plt.legend()
plt.title('Training History')
plt.savefig(os.path.join(MODEL_DIR, 'training_loss.png'))
plt.close()

# -------------------- 9. Xuat TFLite (int8, 2 input) --------------------
# QUAN TRONG: voi model nhieu input, TFLiteConverter doi representative_dataset
# tra ve du lieu theo dung THU TU ALPHABET cua ten input ('meta' < 'waveform'),
# KHONG PHAI thu tu khai bao trong Model(inputs=[wave_in, meta_in]). Neu sai
# thu tu, calibration se dua nham du lieu vao nhanh Conv1D va bao loi dang
# "input->dims->size != 4" luc convert (da kiem chung thuc te). Lay dong theo
# model.input_names de luon dung, ke ca sau nay doi ten input.
_array_by_name = {
    'waveform': Xw_train,
    'meta': Xm_train_n,
}
_sorted_input_names = sorted(inp.name for inp in model.inputs)
print(f"Thu tu input luc quantize (alphabet): {_sorted_input_names}")

def representative_dataset():
    num_samples = min(100, len(Xw_train))
    indices = np.random.choice(len(Xw_train), num_samples, replace=False)
    for i in indices:
        yield [_array_by_name[name][i:i+1].astype(np.float32) for name in _sorted_input_names]

converter = tf.lite.TFLiteConverter.from_keras_model(best_model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
converter.representative_dataset = representative_dataset
converter.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
converter.inference_input_type = tf.int8
converter.inference_output_type = tf.int8

try:
    tflite_model = converter.convert()
    tflite_path = os.path.join(MODEL_DIR, 'bp_model_int8.tflite')
    with open(tflite_path, 'wb') as f:
        f.write(tflite_model)
    print(f"Da xuat TFLite int8: {tflite_path}")
except Exception as e:
    print(f"Loi khi luong tu hoa int8 ({e}), thu float16...")
    converter = tf.lite.TFLiteConverter.from_keras_model(best_model)
    converter.optimizations = [tf.lite.Optimize.DEFAULT]
    converter.target_spec.supported_types = [tf.float16]
    tflite_model = converter.convert()
    tflite_path = os.path.join(MODEL_DIR, 'bp_model_float16.tflite')
    with open(tflite_path, 'wb') as f:
        f.write(tflite_model)
    print(f"Da xuat TFLite float16: {tflite_path}")

# Ban float32 (khong luong tu hoa) - de doi chieu debug
converter = tf.lite.TFLiteConverter.from_keras_model(best_model)
tflite_fp32 = converter.convert()
tflite_fp32_path = os.path.join(MODEL_DIR, 'bp_model_fp32.tflite')
with open(tflite_fp32_path, 'wb') as f:
    f.write(tflite_fp32)
print(f"Da xuat TFLite float32: {tflite_fp32_path}")

for fname in ['bp_model_int8.tflite', 'bp_model_float16.tflite', 'bp_model_fp32.tflite']:
    path = os.path.join(MODEL_DIR, fname)
    if os.path.exists(path):
        size = os.path.getsize(path) / 1024
        print(f"{fname}: {size:.2f} KB")

# In lai quantization params cua input/output - can de viet dung
# quantize_i8()/dequantize_i8() ben firmware (app.c) cho khop.
int8_path = os.path.join(MODEL_DIR, 'bp_model_int8.tflite')
if os.path.exists(int8_path):
    interp = tf.lite.Interpreter(model_path=int8_path)
    interp.allocate_tensors()
    print("\n======= Quantization params (dung cho app.c) =======")
    for t in interp.get_input_details():
        print(f"INPUT  '{t['name']}': shape={t['shape']}, scale={t['quantization'][0]:.8f}, "
              f"zero_point={t['quantization'][1]}")
    for t in interp.get_output_details():
        print(f"OUTPUT '{t['name']}': shape={t['shape']}, scale={t['quantization'][0]:.8f}, "
              f"zero_point={t['quantization'][1]}")
else:
    print("\n(Khong co ban int8 - xem log loi ben tren)")

print("\nHoan tat huan luyen va xuat mo hinh.")