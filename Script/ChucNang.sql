﻿USE ONLINE_SHOP
GO
--I. CHỨC NĂNG CỦA KHÁCH HÀNG
--CHỨC NĂNG 1: Khách hàng đăng kí
CREATE PROC SP_DANGKIKHACHHANG 
	@TENKH		NVARCHAR(50),
	@GIOITINH			BIT,
	@NGAYSINH			DATE,
	@EMAIL		CHAR(50),
	@SDT			CHAR(10),
	@DIACHI		NVARCHAR(100),
	@PASSWORD		NVARCHAR(100)
AS
BEGIN
IF EXISTS (SELECT * FROM KHACHHANG WHERE EMAIL =
@EMAIL AND PASSWORD = @PASSWORD)
	BEGIN
		PRINT N'ĐÃ TỒN TẠI TÀI KHOẢN NÀY'
		PRINT N'ĐĂNG KÍ THẤT BẠI'
	END
ELSE
	BEGIN
	declare @MaKH int
	SET @MaKH= (SELECT Max(KHACHHANG.MAKHACHHANG) FROM KHACHHANG)
			set @MaKH = @MaKH + 1
	INSERT INTO KHACHHANG VALUES(@MaKH, @TENKH, @GIOITINH, @NGAYSINH, @EMAIL, @SDT, @DIACHI, @PASSWORD)
		PRINT N'ĐĂNG KÍ THÀNH CÔNG'
	END
END
GO
--CHỨC NĂNG 2: Khách hàng đăng nhập
CREATE PROC SP_DANGNHAPKHACHHANG 
	@EMAIL CHAR(50),
	@PASSWORD VARCHAR(50)
AS
BEGIN
IF EXISTS (SELECT * FROM KHACHHANG WHERE EMAIL =
@EMAIL AND PASSWORD = @PASSWORD)
	BEGIN
		PRINT N'ĐĂNG NHẬP THÀNH CÔNG'
		RETURN 0;
	END
ELSE
	BEGIN
		PRINT N'ĐĂNG NHẬP THẤT BẠI'
		RETURN 1;
	END
END
GO
--CHỨC NĂNG 3: Tìm kiếm sản phẩm theo tên
CREATE PROC sp_TimKiemSP
@sp nvarchar(50) 
AS
BEGIN
	SELECT *
	FROM SANPHAM
	WHERE SANPHAM.TENSANPHAM LIKE @sp --de like cho nguoi dung nhap gan dung ten cung ra
END
GO
--CHỨC NĂNG 4: Tìm kiếm sản phẩm bán chạy nhất
CREATE PROC sp_TimKiemSP_BanChayNhat
--@sp nvarchar(50) 
AS
BEGIN
	SELECT SANPHAM.MASANPHAM, SANPHAM.TENSANPHAM, sum(CTDONHANG.SOLUONG) AS SoLuong
	FROM SANPHAM inner join CTDONHANG ON SANPHAM.MASANPHAM=CTDONHANG.MASANPHAM
	GROUP BY SANPHAM.MASANPHAM, SANPHAM.TENSANPHAM
	HAVING (sum(CTDONHANG.SOLUONG))>=ALL(select SUM(CTDONHANG.SOLUONG) From CTDONHANG Group by CTDONHANG.MASANPHAM)
END
GO
--CHỨC NĂNG 5: Tìm kiếm sản phẩm có loại hàng bán chạy nhất.
CREATE PROC sp_TimKiemSP_BanChayNhat_TheoLoai
@Loai nvarchar(50) 
AS
BEGIN
	SELECT SANPHAM.MaSANPHAM, SANPHAM.TENSANPHAM, LOAISANPHAM.TENLOAISANPHAM
	FROM SANPHAM inner join CTDONHANG ON SANPHAM.MASANPHAM=CTDONHANG.MASANPHAM inner join LOAISANPHAM ON LOAISANPHAM.MALOAISANPHAM=SANPHAM.LOAISANPHAM
	Where LOAISANPHAM.TENLOAISANPHAM like @Loai
	GROUP BY SANPHAM.MASANPHAM, SANPHAM.TENSANPHAM, LOAISANPHAM.TENLOAISANPHAM
	HAVING (sum(CTDONHANG.SOLUONG))>=ALL(select SUM(CTDONHANG.SOLUONG) From SANPHAM inner join CTDONHANG ON SANPHAM.MASANPHAM=CTDONHANG.MASANPHAM inner join LOAISANPHAM ON LOAISANPHAM.MALOAISANPHAM=SANPHAM.LOAISANPHAM  WHERE LOAISANPHAM.TENLOAISANPHAM like @Loai Group by CTDONHANG.MASANPHAM )
END
GO
--CHỨC NĂNG 6: Đặt hàng.
CREATE PROC sp_DatHang
@MaKH int,
@Masp int,
@SoLuong int,
@HTTT varchar(50),
@CuaHang CHAR(15),
@MaNV CHAR(15)
AS
BEGIN
	declare @MaHD int
	SET @MaHD= (SELECT Max(DONHANG.MADONHANG) FROM DONHANG)
			set @MaHD = @MaHD + 1
	DECLARE @MaHTTT INT
	SET @MaHTTT = (SELECT MaHTTT FROM dbo.HINHTHUCTHANHTOAN WHERE TenHTTT = @HTTT)
	DECLARE @GiamGia INT
	SET @GiamGia = 0
	IF @SoLuong >50 
	BEGIN
	SET @GiamGia=20000
	END
	declare @GiaBan INT
			set @GiaBan = (select GIASANPHAM from SANPHAM Where @Masp = MASANPHAM)
	declare @ThanhTien INT
			set @ThanhTien = @GiaBan * @SoLuong
	declare @TienDH INT
	SET @TienDH = (SELECT SUM(CTDONHANG.THANHTIEN) FROM CTDONHANG WHERE CTDONHANG.MADONHANG=@MaHD)+ @ThanhTien
	if Exists(SELECT MAKHACHHANG FROM KHACHHANG  WHERE MAKHACHHANG = @MaKH)
		Begin
			if @SoLuong <(SELECT SANPHAM.SOLUONGTON FROM SANPHAM  WHERE SANPHAM.MASANPHAM=@Masp)
			begin
			INSERT INTO DONHANG VALUES(@MaHD,GETDATE(), @TienDH, @MaKH, @MaNV, @CuaHang)
			INSERT INTO CTDONHANG VALUES(@MaHD, @Masp, @SoLuong, @GiaBan,@GiamGia, @ThanhTien)
			INSERT INTO CTTHANHTOAN VALUES(@MaKH, @MaHD, @MaHTTT, @TienDH)
			UPDATE SANPHAM set SOLUONGTON=SOLUONGTON-@SoLuong
			WHERE SANPHAM.MASANPHAM=@Masp
			end
			else 
			print(N'Số lượng không đủ đáp ứng')
		end
	else 
		print(N'Không tồn tại khách hàng')
END
GO
--CHỨC NĂNG 7: Hủy đơn hàng.
CREATE PROC sp_HuyDonHang
@MaHD int
AS
BEGIN
	DELETE FROM DONHANG 
	WHERE MADONHANG = @MaHD
	DELETE FROM CTDONHANG 
	WHERE MADONHANG = @MaHD
	PRINT('Bạn đã hủy thành công')
END
GO
--CHỨC NĂNG 8: Thông tin đơn hàng.
CREATE PROC sp_TheoDoiDonHang
@MaHD int
AS
BEGIN
	IF EXISTS(SELECT MADONHANG FROM DONHANG  WHERE MADONHANG = @MaHD)
	BEGIN
		SELECT * FROM DONHANG WHERE MADONHANG = @MaHD
	end
	else
		print('Không có đơn hàng nào tồn tại')
END
GO
--II. CHỨC NĂNG CỦA NHÂN VIÊN
--CHỨC NĂNG 9: Nhân viên đăng nhập
CREATE PROC SP_DANGNHAPNV 
	@EMAIL CHAR(50),
	@PASSWORD VARCHAR(50)
AS
BEGIN
IF EXISTS (SELECT * FROM NHANVIEN WHERE EMAIL =
@EMAIL AND PASSWORD = @PASSWORD)
	BEGIN
		PRINT N'ĐĂNG NHẬP THÀNH CÔNG'
		RETURN 0;
	END
ELSE
	BEGIN
		PRINT N'ĐĂNG NHẬP THẤT BẠI'
		RETURN 1;
	END
END
GO
--CHỨC NĂNG 10: Thống kê số lượng đơn hàng, doanh thu của mỗi nhà cung cấp.
CREATE PROC sp_ThongKeNhaCungCap
@MaNCC int
AS
BEGIN
	if Exists(SELECT MANHACUNGCAP FROM NHACUNGCAP WHERE MANHACUNGCAP = @MaNCC)
		begin
			SELECT NHACUNGCAP.MANHACUNGCAP, COUNT(CTDONHANG.MADONHANG) AS SoLuongDonHang, SUM(CTDONHANG.ThanhTien) AS DoanhThu
			FROM NHACUNGCAP INNER JOIN SANPHAM ON NHACUNGCAP.MANHACUNGCAP=SANPHAM.MANHACUNGCAP
				INNER JOIN CTDONHANG ON CTDONHANG.MASANPHAM=SANPHAM.MASANPHAM
			Where NHACUNGCAP.MANHACUNGCAP=@MaNCC
			GROUP BY NHACUNGCAP.MANHACUNGCAP
		end
	else
		print(N'Không tồn tại nhà cung cấp này.')
END
GO
--CHỨC NĂNG 11: Theo dõi tình hình tồn kho của mỗi sản phẩm.
CREATE PROC sp_TonKhoSP
@Masp int
AS
BEGIN
	if Exists(SELECT MASANPHAM FROM SANPHAM WHERE MASANPHAM = @Masp)
		begin
			SELECT MASANPHAM, TENSANPHAM, SOLUONGTON FROM SANPHAM Where MASANPHAM = @Masp
		end
	else
		print(N'Không tồn tại sản phẩm này.')

END
GO
--CHỨC NĂNG 12: Thống kê doanh thu trong một khoảng thời gian.
CREATE PROC sp_ThongKeDoanhThu
@ThoiGianDau date,
@ThoiGianCuoi date
AS
BEGIN
	SELECT sum(TongTien) AS TongDoanhThu From DONHANG Where NgayLap<=@ThoiGianCuoi and NgayLap>=@ThoiGianDau
END
GO
--CHỨC NĂNG 13: Cập nhật số lượng sản phẩm.
CREATE PROC sp_Nhapsp
@Masp int,
@SoLuongNhap int
AS
BEGIN
	IF NOT EXISTS (Select MASANPHAM FROM SANPHAM where MASANPHAM = @Masp)
		PRINT(N'Không tồn tại sản phẩm này')
	ELSE
	BEGIN
        UPDATE SANPHAM SET SOLUONGTON=SOLUONGTON + @SoLuongNhap
	END
END
GO
--CHỨC NĂNG 14: Thêm sản phẩm.
CREATE PROC sp_ThemSP @MaNCC CHAR(15),
@TenSP NVARCHAR(100),
@LoaiSP CHAR(15),
@MOTA NVARCHAR(1000),
@GiaBan INT,
@SoLuongTon INT
AS
BEGIN
	IF EXISTS (Select TENSANPHAM FROM SANPHAM where TENSANPHAM = @TenSP and MANHACUNGCAP=@MaNCC)
		PRINT(N'Sản phẩm này đã tồn tại')
	ELSE
	BEGIN
			declare @MaSP int
			SET @MaSP= (SELECT Max(SANPHAM.MASANPHAM) FROM SANPHAM)
				set @MaSP = @MaSP + 1
			INSERT INTO SANPHAM VALUES(@MaSP, @MaNCC, @LoaiSP, @MOTA, @GiaBan, @SoLuongTon)
			PRINT(N'Thêm sản phẩm thành công')
	END
END
GO