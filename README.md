# BÀI TẬP VỀ NHÀ 03 - HỆ QUẢN TRỊ CSDL
# ĐỀ TÀI: HỆ THỐNG QUẢN LÝ CẦM ĐỒ

---

## Thông tin sinh viên

- Họ tên: Trần Quang
- Lớp: K59KMT
- Môn: Hệ quản trị CSDL

---

# 1. Mô tả bài toán

Hệ thống quản lý cầm đồ dùng để quản lý:
- khách hàng
- hợp đồng vay tiền
- tài sản thế chấp
- thanh toán công nợ
- thanh lý tài sản

Mỗi khách hàng có thể có nhiều hợp đồng khác nhau. Một hợp đồng có thể cầm cố nhiều tài sản.

Hệ thống hỗ trợ:
- tính lãi đơn
- tính lãi kép
- trả góp
- quản lý nợ xấu
- lưu lịch sử giao dịch

---

# 2. Flow hoạt động hệ thống

Khách hàng  
↓  
Tạo hợp đồng  
↓  
Thêm tài sản  
↓  
Tính lãi theo ngày  
↓  
Khách trả tiền  
↓  
Ghi log thanh toán  
↓  
Cập nhật dư nợ  
↓  
Quá hạn hợp đồng  
↓  
Thanh lý tài sản  

---

# 3. Thiết kế cơ sở dữ liệu

## 3.1 Bảng KhachHang

Bảng dùng để lưu thông tin khách hàng.

| Tên cột | Ý nghĩa |
|---|---|
| CustomerID | Mã khách hàng |
| FullName | Họ tên |
| Phone | Số điện thoại |
| CCCD | CCCD |
| Address | Địa chỉ |

### Hình ảnh

![image](screenshots/khachhang.png)

---

## 3.2 Bảng HopDong

Bảng quản lý hợp đồng vay tiền.

| Tên cột | Ý nghĩa |
|---|---|
| ContractID | Mã hợp đồng |
| CustomerID | Mã khách |
| LoanAmount | Tiền vay |
| RemainingDebt | Dư nợ |
| Deadline1 | Hạn lãi đơn |
| Deadline2 | Hạn thanh lý |
| Status | Trạng thái |

### Hình ảnh

![image](screenshots/hopdong.png)

---

## 3.3 Bảng TaiSan

Bảng quản lý tài sản cầm cố.

| Tên cột | Ý nghĩa |
|---|---|
| AssetID | Mã tài sản |
| AssetName | Tên tài sản |
| AssetValue | Giá trị tài sản |
| AssetStatus | Trạng thái |
| IsSold | Đã thanh lý |

### Hình ảnh

![image](screenshots/taisan.png)

---

# 4. Quan hệ dữ liệu

- Một khách hàng có nhiều hợp đồng.
- Một hợp đồng có nhiều tài sản.
- Một hợp đồng có nhiều lần thanh toán.

### Sơ đồ logic

KhachHang 1 --- N HopDong  

HopDong 1 --- N ThanhToan  

HopDong N --- N TaiSan  

---

# 5. Logic tính lãi

## 5.1 Lãi đơn

Trước Deadline1 hệ thống tính lãi đơn.

:contentReference[oaicite:0]{index=0}

Trong đó:
- G là tiền gốc
- n là số ngày vay

---

## 5.2 Lãi kép

Sau Deadline1 hệ thống chuyển sang lãi kép.


::contentReference[oaicite:1]{index=1}


Trong đó:
- P là gốc + lãi đơn
- r là lãi suất
- n là số ngày quá hạn

### Hình ảnh

![image](screenshots/function_calc.png)

---

# 6. Event tạo hợp đồng

Procedure:
- sp_CreateContract

Procedure dùng để:
- thêm khách hàng
- tạo hợp đồng
- thêm tài sản
- liên kết tài sản với hợp đồng

### Hình ảnh

![image](screenshots/create_contract.png)

---

# 7. Event thanh toán

Procedure:
- sp_Payment

Hệ thống sẽ:
- tính tổng nợ
- trừ số tiền khách trả
- cập nhật dư nợ
- lưu log thanh toán

Nếu trả hết:
- cập nhật trạng thái “Đã thanh toán”

Nếu chưa trả hết:
- cập nhật trạng thái “Đang trả góp”

### Hình ảnh

![image](screenshots/payment.png)

---

# 8. Audit Log

Bảng ThanhToan dùng để lưu:
- ngày thanh toán
- số tiền trả
- người thu tiền

Hệ thống giúp tránh mất dữ liệu giao dịch.

### Hình ảnh

![image](screenshots/log_thanhtoan.png)

---

# 9. Query nợ xấu

Query dùng để hiển thị:
- tên khách hàng
- số ngày quá hạn
- tổng nợ hiện tại

Điều kiện:
- quá Deadline1
- chưa thanh toán

### Hình ảnh

![image](screenshots/no_xau.png)

---

# 10. Trigger tự động

## Trigger quá hạn

Tự động chuyển:
- Đang vay
→ Quá hạn

### Hình ảnh

![image](screenshots/trigger_quahan.png)

---

## Trigger thanh lý

Tự động chuyển:
- Đã thanh lý
→ Đã bán thanh lý

### Hình ảnh

![image](screenshots/trigger_thanhly.png)

---

# 11. Gia hạn hợp đồng

Hệ thống hỗ trợ gia hạn hợp đồng khi khách thanh toán toàn bộ tiền lãi hiện tại.

Sau khi gia hạn:
- Deadline1
- Deadline2

sẽ được cập nhật lại để tránh lãi kép.

---

# 12. Kết luận

Hệ thống đã thực hiện:
- quản lý khách hàng
- quản lý hợp đồng
- quản lý tài sản
- tính lãi đơn và lãi kép
- thanh toán công nợ
- lưu lịch sử giao dịch
- quản lý nợ xấu
- thanh lý tài sản

Bài tập giúp hiểu rõ hơn về:
- thiết kế CSDL
- trigger
- function
- procedure
- quản lý nghiệp vụ trong SQL Server
