# BÀI TẬP VỀ NHÀ 03 - HỆ QUẢN TRỊ CSDL
# ĐỀ TÀI: HỆ THỐNG QUẢN LÝ CẦM ĐỒ

---

## Thông tin sinh viên

Họ và tên: Trần Đình Quang

Mã số sinh viên: K235480106057

Lớp: K59KMT.K01 - Kỹ thuật Máy tính

Trường: Đại học Kỹ thuật Công nghiệp Thái Nguyên (TNUT)

Giảng viên hướng dẫn: Thầy Đỗ Duy Cốp

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

# 2. Quy trình hoạt động của hệ thống

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
TẠO database
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/a91c8ab4-acf7-4873-9a21-a7bfb798c837" />


## Tạo bảng dữ liệu

Hệ thống sử dụng các bảng:
- KhachHang
- HopDong
- TaiSan
- ThanhToan
- HopDong_TaiSan

<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/b837a0a8-db1c-4fef-86b9-5259218bf5b2" />


tạo dữ liệu
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/9ce101d1-d09d-4f25-920d-f62f1a90d20e" />


## 3.1 Bảng KhachHang

Bảng dùng để lưu thông tin khách hàng.

| Tên cột | Ý nghĩa |
|---|---|
| CustomerID | Mã khách hàng |
| FullName | Họ tên |
| Phone | Số điện thoại |
| CCCD | CCCD |
| Address | Địa chỉ |



<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/42aea3b6-72e0-40d9-880a-74ebaead2d98" />




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

<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/ed7b8ccc-eef3-4d8a-8e7b-fccfef46748e" />



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


<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/06944b6c-331e-4f7e-a13b-214d2aebf1a1" />



---

# 4. Quan hệ dữ liệu

- Một khách hàng có nhiều hợp đồng.
- Một hợp đồng có nhiều tài sản.
- Một hợp đồng có nhiều lần thanh toán.

### Sơ đồ logic

KhachHang 1 --- N HopDong  

HopDong 1 --- N ThanhToan  

HopDong N --- N TaiSan  

<img width="1908" height="1078" alt="image" src="https://github.com/user-attachments/assets/d0ca19ce-7de7-444a-872f-d8707e71e029" />

---

# 5. Logic tính lãi

Trong hệ thống quản lý cầm đồ, việc tính lãi đóng vai trò rất quan trọng trong quản lý công nợ khách hàng.

Hệ thống sử dụng hai hình thức tính lãi gồm:
- lãi đơn
- lãi kép

---

## 5.1 Lãi đơn

Trước thời hạn Deadline1 hệ thống sử dụng lãi đơn để tính tiền lãi theo số ngày vay thực tế.

Công thức tính:

TienLai = (TienGoc / 1000000) * 5000 * SoNgayVay

Trong đó:

- TienGoc là số tiền khách vay
- SoNgayVay là số ngày vay thực tế

Ví dụ:

Nếu khách vay:
- 5.000.000 VNĐ
- trong 10 ngày

thì tiền lãi sẽ là:

(5.000.000 / 1.000.000) * 5000 * 10 = 250.000 VNĐ

Điều này giúp hệ thống dễ dàng tính công nợ theo ngày.

---


## 5.2 Lãi kép

Sau khi vượt quá Deadline1, hợp đồng được xem là quá hạn và hệ thống chuyển sang lãi kép nhằm tăng công nợ theo thời gian.

Công thức tính:

A = P(1 + r)^n

Trong đó:

- P là tổng tiền gốc và lãi đơn
- r là lãi suất quá hạn
- n là số ngày quá hạn

Lãi kép giúp:
- tăng công nợ theo thời gian
- hỗ trợ quản lý nợ xấu
- giảm tình trạng khách hàng chậm thanh toán

Hệ thống sử dụng Function:
- fn_CalcMoneyContract

để tự động tính tổng công nợ của khách hàng.
Sau Deadline1 hệ thống chuyển sang lãi kép.


<img width="1918" height="1077" alt="image" src="https://github.com/user-attachments/assets/7a361c00-29c5-4a23-9103-67bd79da8850" />



---

# 6. Event tạo hợp đồng

Procedure:
- sp_CreateContract

Procedure dùng để:
- thêm khách hàng
- tạo hợp đồng
- thêm tài sản
- liên kết tài sản với hợp đồng

<img width="1918" height="1075" alt="image" src="https://github.com/user-attachments/assets/e144c4c6-8910-42fd-8223-257efc8a1c9b" />

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


<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/1b43e222-8fd2-45eb-b75b-3215c2a5d3cf" />
*Hình ảnh minh họa quá trình thực thi procedure sp_Payment để xử lý thanh toán cho hợp đồng cầm đồ.*

Hệ thống thực hiện:
- tính tổng công nợ
- ghi nhận số tiền khách thanh toán
- cập nhật dư nợ còn lại

<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/f4fca3a4-dc53-4835-adc8-eb966cf25fd6" />
*Hình ảnh minh họa dữ liệu lịch sử thanh toán của khách hàng sau khi procedure được thực thi.*

Hệ thống lưu:
- mã thanh toán
- số tiền thanh toán
- ngày thanh toán
- người thu tiền

<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/9fb7fcf8-bb6f-437d-b0cb-98cfc4fcc285" />
*Hình ảnh minh họa quá trình cập nhật dư nợ và trạng thái hợp đồng sau khi khách hàng thanh toán.*

Sau khi thanh toán:
- RemainingDebt được giảm xuống
- Status được cập nhật phù hợp với trạng thái thanh toán thực tế

Nếu khách chưa trả hết:
- trạng thái sẽ là “Đang trả góp”

Nếu khách đã trả đủ:
- trạng thái sẽ là “Đã thanh toán”
Dữ liệu này giúp theo dõi lịch sử giao dịch và quản lý công nợ chính xác hơn.
---

# 8. Event quá hạn hợp đồng

Trigger:

TRG_QuaHan

Trigger được sử dụng để tự động cập nhật trạng thái hợp đồng khi khách hàng quá thời hạn thanh toán.

Hệ thống sẽ:

kiểm tra thời hạn thanh toán Deadline1
xác định hợp đồng quá hạn
tự động cập nhật trạng thái hợp đồng thành:
“Quá hạn”

Điều này giúp hệ thống:

quản lý công nợ chính xác
theo dõi khách hàng nợ xấu
hỗ trợ thanh lý tài sản khi cần thiết

<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/5f7e1320-28ee-4ad6-a865-6b4045786ac9" />
*Ghi chú : TẠO TRIGGER*
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/3249bb0c-e36e-412f-a6f9-64641940c474" />
*Hình ảnh minh họa quá trình cập nhật thời hạn thanh toán của hợp đồng để kiểm tra trigger quá hạn.*

Hệ thống sẽ kiểm tra:
- thời gian thanh toán
- trạng thái hợp đồng
- điều kiện quá hạn

<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/a363ac0d-a131-4107-845d-c069cf494d95" />
*Hình ảnh minh họa kết quả sau khi trigger TRG_QuaHan được kích hoạt.*

Khi hợp đồng vượt quá thời hạn thanh toán:
- trạng thái hợp đồng sẽ tự động chuyển thành “Quá hạn”

Điều này giúp hệ thống tự động quản lý các hợp đồng nợ xấu hiệu quả hơn.
---

# 9. Query nợ xấu

Query được sử dụng để hiển thị danh sách khách hàng đang có hợp đồng quá hạn.

Hệ thống sẽ hiển thị:

tên khách hàng
số điện thoại
số ngày quá hạn
tổng công nợ hiện tại

Điều kiện:

hợp đồng vượt quá Deadline1
khách hàng chưa hoàn tất thanh toán

Query này giúp:

quản lý khách hàng nợ xấu
theo dõi công nợ
hỗ trợ xử lý thanh toán và thanh lý tài sản

<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/ca94b576-11de-45be-b7d1-eca80144ab81" />
*Hình ảnh minh họa kết quả truy vấn danh sách khách hàng có hợp đồng quá hạn thanh toán.*

Hệ thống sẽ hiển thị:
- thông tin khách hàng
- số ngày quá hạn
- tổng công nợ hiện tại

Query này giúp theo dõi các hợp đồng nợ xấu và hỗ trợ quản lý công nợ hiệu quả hơn.

---

# 10. Trigger thanh lý



## Trigger thanh lý

Tự động chuyển:
- Đã thanh lý
→ Đã bán thanh lý
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/0f91dfbb-e85c-4b17-9438-f82bd28c6216" />


<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/c6429402-afba-4d22-8ebe-85d95c834413" />
Hình ảnh minh họa kết quả sau khi trigger TRG_QuaHan được kích hoạt.

Khi hợp đồng vượt quá thời hạn thanh toán:
- trạng thái hợp đồng sẽ tự động chuyển từ “Đang vay” sang “Quá hạn”

Điều này giúp hệ thống quản lý các hợp đồng nợ xấu hiệu quả hơn.

---

# 11. Event quản lý thanh lý tài sản

Hệ thống sử dụng Trigger để tự động quản lý trạng thái hợp đồng và tài sản cầm cố khi hợp đồng bị quá hạn hoặc thanh lý.

Các chức năng chính gồm:

- tự động chuyển trạng thái hợp đồng sang “Quá hạn”
- tự động chuyển trạng thái tài sản sang “Sẵn sàng thanh lý”
- tự động chuyển trạng thái tài sản sang “Đã bán thanh lý”

Điều này giúp:
- quản lý tài sản cầm cố hiệu quả hơn
- giảm thao tác thủ công
- hỗ trợ xử lý nợ xấu chính xác hơn

Ngoài ra hệ thống còn hỗ trợ theo dõi:
- tình trạng hợp đồng
- trạng thái tài sản
- quá trình thanh lý tài sản trong cửa hàng cầm đồ

---

# 12. Kết luận

Hệ thống quản lý cầm đồ được xây dựng bằng SQL Server nhằm hỗ trợ quản lý khách hàng, hợp đồng vay tiền, tài sản cầm cố và công nợ trong cửa hàng cầm đồ.

Trong quá trình thực hiện bài tập đã xây dựng được:

- cơ sở dữ liệu quan hệ
- Function tính lãi
- Procedure xử lý thanh toán
- Trigger quản lý trạng thái hợp đồng và tài sản
- Query theo dõi khách hàng nợ xấu

Thông qua bài tập này giúp:

- hiểu rõ hơn về thiết kế cơ sở dữ liệu
- sử dụng Function, Procedure, Trigger và Query trong SQL Server
- xây dựng được luồng xử lý dữ liệu theo mô hình thực tế

Hệ thống giúp:

- giảm thao tác thủ công
- quản lý dữ liệu hiệu quả hơn
- hỗ trợ theo dõi công nợ và tài sản chính xác hơn.
