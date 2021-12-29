USE [master]

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'ONLINE_SHOP')
BEGIN
	DROP DATABASE ONLINE_SHOP
END;

CREATE DATABASE ONLINE_SHOP;

USE ONLINE_SHOP;


CREATE TABLE TAIKHOAN
(
	MATAIKHOAN		CHAR(15) NOT NULL,
	EMAIL		CHAR(50)	NOT NULL,
	PASSWORD		VARCHAR(50)		NOT NULL,
	LOAITAIKHOAN	CHAR(15)		NOT NULL

	CONSTRAINT PK_TK PRIMARY KEY (MATAIKHOAN)
)
GO

CREATE TABLE KHACHHANG
(
	MAKHACHHANG		CHAR(15) NOT NULL,
	TENKHACHHANG		NVARCHAR(50),
	GIOITINH			BIT,
	NGAYSINH			DATE,
	EMAIL		CHAR(50),
	SDT			CHAR(10),
	DIACHI		NVARCHAR(100)

	CONSTRAINT PK_KH PRIMARY KEY (MAKHACHHANG)
)
GO

CREATE TABLE HINHTHUCTHANHTOAN
(
	MAHTTT	CHAR(15),
	TENHTTT		NVARCHAR(100),
	
	CONSTRAINT PK_HTTT PRIMARY KEY (MAHTTT)
)
GO
CREATE TABLE CTTHANHTOAN
(
	MAKHACHHANG	CHAR(15),
	MADONHANG	CHAR(15),
	MAHTTT	CHAR(15),
	SOTIENTHANHTOAN		NVARCHAR(100)
	
	CONSTRAINT PK_CTTT PRIMARY KEY (MAKHACHHANG,MADONHANG,MAHTTT)
)
GO

CREATE TABLE NHANVIEN
(
	MANHANVIEN		CHAR(15) NOT NULL,
	TENNHANVIEN		NVARCHAR(50),
	GIOITINH			BIT,
	NGAYSINH			DATE,
	EMAIL		CHAR(50),
	SDT			CHAR(10),
	DIACHI		NVARCHAR(100),
	LOAINHANVIEN CHAR(15),
	MACUAHANG	CHAR(15)

	CONSTRAINT PK_NV PRIMARY KEY (MANHANVIEN)
)

CREATE TABLE LOAINHANVIEN
(
	MALOAINHANVIEN	CHAR(15),
	CHUCVU		NVARCHAR(100),
	
	CONSTRAINT PK_LNV PRIMARY KEY (MALOAINHANVIEN)
)
GO


CREATE TABLE CUAHANG
(
	MACUAHANG		CHAR(15),
	TENCUAHANG	NVARCHAR(100),
	SDT			CHAR(10),
	DIACHI		NVARCHAR(100)

	CONSTRAINT PK_CH PRIMARY KEY (MACUAHANG)
)
GO


CREATE TABLE DONHANG 
(
	MADONHANG		CHAR(15),
	NGAYLAP		DATE			NOT NULL,
	TONGTIEN		MONEY			NOT NULL,
	MAKHACHHANG	CHAR(15)		NOT NULL,
	MANHANVIEN	CHAR(15)		NOT NULL,
	MACUAHANG	CHAR(15)		NOT NULL,

	CONSTRAINT PK_DH PRIMARY KEY (MADONHANG)
)
GO


CREATE TABLE CTDONHANG
(
	MADONHANG			CHAR(15),
	MASANPHAM		CHAR(15),
	SOLUONG		INT			NOT NULL,
	GIABAN		INT			NOT NULL,
	GIAGIAM		INT			NOT NULL,
	THANHTIEN	INT


	CONSTRAINT PK_CTDH PRIMARY KEY (MADONHANG, MASANPHAM)
)
GO

CREATE TABLE SANPHAM
(
	MASANPHAM		CHAR(15),
	MANHACUNGCAP	CHAR(15)		NOT NULL,
	TENSANPHAM	NVARCHAR(100)	NOT NULL,
	LOAISANPHAM		CHAR(15)		NOT NULL,
	MOTA		NVARCHAR(1000)	NOT NULL,
	GIASANPHAM		INT				NOT NULL,
	SOLUONGTON		INT				NOT NULL,
	NGANHHANG		CHAR(15)

	CONSTRAINT PK_SP PRIMARY KEY (MASANPHAM)
)
GO

CREATE TABLE NHACUNGCAP
(
	MANHACUNGCAP		CHAR(15),
	TENNHACUNGCAP	NVARCHAR(100)		NOT NULL,
	LOAISANPHAMCUNGCAP	NVARCHAR(100)	NOT NULL,
	GIACUNGCAP		INT				NOT NULL,
	SDT			CHAR(10),
	DIACHI		NVARCHAR(100)

	CONSTRAINT PK_NCC PRIMARY KEY (MANHACUNGCAP)
)
GO

CREATE TABLE LOAISANPHAM
(
	MALOAISANPHAM		CHAR(15),
	TENLOAISANPHAM	NVARCHAR(100)		NOT NULL,
	MANGANHHANG		CHAR(15),

	CONSTRAINT PK_LSP PRIMARY KEY (MALOAISANPHAM)
)
GO

CREATE TABLE NGANHHANG
(
	MANGANHHANG		CHAR(15),
	TENNGANHHANG	NVARCHAR(100)		NOT NULL,

	CONSTRAINT PK_NH PRIMARY KEY (MANGANHHANG)
)
GO

ALTER TABLE	TAIKHOAN ADD CONSTRAINT FK_TK_KH FOREIGN KEY (LOAITAIKHOAN) REFERENCES KHACHHANG(MAKHACHHANG);
ALTER TABLE	TAIKHOAN ADD CONSTRAINT FK_TK_NV FOREIGN KEY (LOAITAIKHOAN) REFERENCES NHANVIEN(MANHANVIEN);

ALTER TABLE	NHANVIEN ADD CONSTRAINT FK_NV_LNV FOREIGN KEY (LOAINHANVIEN) REFERENCES LOAINHANVIEN(MALOAINHANVIEN);
ALTER TABLE	NHANVIEN ADD CONSTRAINT FK_NV_CH FOREIGN KEY (MACUAHANG) REFERENCES CUAHANG(MACUAHANG);

ALTER TABLE	DONHANG ADD CONSTRAINT FK_DH_CH FOREIGN KEY (MACUAHANG) REFERENCES CUAHANG(MACUAHANG);
ALTER TABLE	DONHANG ADD CONSTRAINT FK_DH_NV FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);
ALTER TABLE	DONHANG ADD CONSTRAINT FK_DH_KH FOREIGN KEY (MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG);

ALTER TABLE	CTTHANHTOAN ADD CONSTRAINT FK_CTTT_KH FOREIGN KEY (MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG);
ALTER TABLE	CTTHANHTOAN ADD CONSTRAINT FK_CTTT_DH FOREIGN KEY (MADONHANG) REFERENCES DONHANG(MADONHANG);
ALTER TABLE	CTTHANHTOAN ADD CONSTRAINT FK_CTTT_HTTT FOREIGN KEY (MAHTTT) REFERENCES HINHTHUCTHANHTOAN(MAHTTT);

ALTER TABLE	CTDONHANG ADD CONSTRAINT FK_CTDH_DH FOREIGN KEY (MADONHANG) REFERENCES DONHANG(MADONHANG);
ALTER TABLE	CTDONHANG ADD CONSTRAINT FK_CTDH_SP FOREIGN KEY (MASANPHAM) REFERENCES SANPHAM(MASANPHAM);


ALTER TABLE	SANPHAM ADD CONSTRAINT FK_SP_NCC FOREIGN KEY (MANHACUNGCAP) REFERENCES NHACUNGCAP(MANHACUNGCAP);
ALTER TABLE	SANPHAM ADD CONSTRAINT FK_SP_LSP FOREIGN KEY (LOAISANPHAM) REFERENCES LOAISANPHAM(MALOAISANPHAM);
ALTER TABLE	SANPHAM ADD CONSTRAINT FK_SP_NH FOREIGN KEY (NGANHHANG) REFERENCES NGANHHANG(MANGANHHANG);

ALTER TABLE	LOAISANPHAM ADD CONSTRAINT FK_LSP_NH FOREIGN KEY (MANGANHHANG) REFERENCES NGANHHANG(MANGANHHANG);

