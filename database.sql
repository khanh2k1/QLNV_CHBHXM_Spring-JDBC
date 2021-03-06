USE [master]
GO
/****** Object:  Database [QLNV_CHBHXM]    Script Date: 05/06/2022 1:43:17 CH ******/
CREATE DATABASE [QLNV_CHBHXM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLNV_CHBHXM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLNV_CHBHXM.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLNV_CHBHXM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLNV_CHBHXM_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLNV_CHBHXM] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLNV_CHBHXM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLNV_CHBHXM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLNV_CHBHXM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLNV_CHBHXM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLNV_CHBHXM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLNV_CHBHXM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET RECOVERY FULL 
GO
ALTER DATABASE [QLNV_CHBHXM] SET  MULTI_USER 
GO
ALTER DATABASE [QLNV_CHBHXM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLNV_CHBHXM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLNV_CHBHXM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLNV_CHBHXM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QLNV_CHBHXM] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLNV_CHBHXM', N'ON'
GO
USE [QLNV_CHBHXM]
GO
/****** Object:  FullTextCatalog [MaNV_ctlg]    Script Date: 05/06/2022 1:43:18 CH ******/
CREATE FULLTEXT CATALOG [MaNV_ctlg]WITH ACCENT_SENSITIVITY = OFF

GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToUnsign]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Hàm chuyển ký tự có dấu về không dấu
CREATE FUNCTION [dbo].[ConvertToUnsign]
( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) 
AS 
BEGIN
	IF @strInput IS NULL 
	RETURN @strInput 
	IF @strInput = '' 
	RETURN @strInput 
	
	DECLARE @RT NVARCHAR(4000) 
	DECLARE @SIGN_CHARS NCHAR(136) 
	DECLARE @UNSIGN_CHARS NCHAR (136) 
	SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) 
	SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' 
	
	DECLARE @COUNTER int 
	DECLARE @COUNTER1 int 
	SET @COUNTER = 1 
	WHILE (@COUNTER <=LEN(@strInput)) 
	BEGIN 
		SET @COUNTER1 = 1 
		WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
		BEGIN 
			IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
			BEGIN 
				IF @COUNTER=1 
					SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
				ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
				BREAK 
			END 
			SET @COUNTER1 = @COUNTER1 +1 
		END 
		SET @COUNTER = @COUNTER +1 
	END 
	SET @strInput = replace(@strInput,' ','-') 
	RETURN @strInput 
END

GO
/****** Object:  UserDefinedFunction [dbo].[FU_AUTO_MANV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FU_AUTO_MANV](@LOAINV INT)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @ID VARCHAR(10)
	IF(@LOAINV=1) 
	BEGIN
		IF (SELECT COUNT(MaNV) FROM NhanVien WHERE MaNV like 'N21NVQL%') = 0
		SET @ID = 'N21NVQL000'
		ELSE
			SELECT @ID = MAX(RIGHT(MaNV, 3)) FROM NhanVien WHERE MaNV like 'N21NVQL%'
			SELECT @ID = CASE
				WHEN @ID > 0 and @ID <= 9 THEN 'N21NVQL00' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
				WHEN @ID > 9 and @ID <= 10 THEN 'N21NVQL0' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
				WHEN @ID > 10 THEN 'N21NVQL' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
			END
	END

	ELSE
	BEGIN
		IF (SELECT COUNT(MaNV) FROM NhanVien WHERE MaNV like 'N21NVBT%') = 0
		SET @ID = 'N21NVBT000'

		ELSE
		
			SELECT @ID = MAX(RIGHT(MaNV, 3)) FROM NhanVien WHERE MaNV like 'N21NVBT%'
			SELECT @ID = CASE
				WHEN @ID > 0 and @ID <= 9 THEN 'N21NVBT00' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
				WHEN @ID > 9 and @ID <= 10 THEN 'N21NVBT0' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
				WHEN @ID > 10 THEN 'N21NVBT' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
			END
	END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[FU_CHECK_CONGVIEC_NHANVIEN_BY_MANV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FU_CHECK_CONGVIEC_NHANVIEN_BY_MANV](@MANV VARCHAR(10))
RETURNS BIT
AS
BEGIN
DECLARE @CHECK BIT
IF EXISTS (SELECT MaNV from CongViec where MaNV=@MANV) SET @CHECK=1;
ELSE set @CHECK=0;
RETURN @CHECK
END
GO
/****** Object:  UserDefinedFunction [dbo].[FU_CHECK_NANGLUC_NHANVIEN_BY_MANV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FU_CHECK_NANGLUC_NHANVIEN_BY_MANV](@MANV VARCHAR(10))
RETURNS BIT
AS
BEGIN
DECLARE @CHECK BIT
IF EXISTS (SELECT MaNV from NangLuc where MaNV=@MANV) SET @CHECK=1;
ELSE set @CHECK=0;
RETURN @CHECK
END
GO
/****** Object:  UserDefinedFunction [dbo].[fu_findID_maNV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fu_findID_maNV](@maNV nvarchar(10))
RETURNS @new_table TABLE ( 
MaNV nvarchar(10), HoTen nvarchar(100), GioiTinh nvarchar(5), NgaySinh DATE, DiaChi nvarchar(100), SoDT varchar(10),
Email nvarchar(100), LuongCoBan decimal(18,0), MaLoai int, TrangThai nvarchar(100)
)

as
begin
declare @HoTen nvarchar(100), @GioiTinh nvarchar(5), @NgaySinh DATE, @DiaChi nvarchar(100), @SoDT varchar(10),
@Email nvarchar(100), @LuongCoBan decimal(18,0), @MaLoai int, @TrangThai nvarchar(100)

select @HoTen=nv.HoTen, @GioiTinh=GioiTinh, @NgaySinh=NgaySinh, @DiaChi=DiaChi, 
@SoDT=SoDT, @Email=Email, @LuongCoBan=LuongCoBan, @MaLoai=MaLoai
,@TrangThai=TrangThai 
from NhanVien nv where MaNV=@maNV
insert into @new_table values(@maNV, @HoTen, @GioiTinh, @NgaySinh, @DiaChi, 
@SoDT, @Email, @LuongCoBan, @MaLoai,@TrangThai )
return 
end
GO
/****** Object:  UserDefinedFunction [dbo].[FU_GET_MAX_MALOAINV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FU_GET_MAX_MALOAINV]()
RETURNS INT
AS
BEGIN
DECLARE @MALOAINV_MAX INT
SELECT @MALOAINV_MAX= MAX(MaLoai) FROM LoaiNV
RETURN @MALOAINV_MAX
END
GO
/****** Object:  UserDefinedFunction [dbo].[FU_getTK]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FU_getTK](@maNV varchar(10))
returns @taikhoan table(taikhoan varchar(20), matkhau varchar(20))
as
begin
declare @tendangnhap varchar(20), @matkhau varchar(20)
select @tendangnhap=TenDangNhap, @matkhau=MatKhau 
from TaiKhoan where MaNV=@maNV
insert into @taikhoan values (@tendangnhap, @matkhau)
return 
end

GO
/****** Object:  UserDefinedFunction [dbo].[fu_max_getMaDICHVU]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fu_max_getMaDICHVU]()
returns int
as 
begin
declare @maDV int
select @maDV=MAX(MaDV) from DichVu

return @maDV
end
GO
/****** Object:  UserDefinedFunction [dbo].[fu_max_getMaLoaiXe]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fu_max_getMaLoaiXe] ()
returns int
as
BEGIN 
DECLARE @maLX int = 0
select @maLX = MAX(LoaiXe.MaLX) from LoaiXe 
return @maLX
end;
GO
/****** Object:  UserDefinedFunction [dbo].[UF_LayMaLoaiTheoTenLoai]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--=================================================== FUNCTION ===================================================
-- Lấy mã loại nhân viên theo tên loại
CREATE FUNCTION [dbo].[UF_LayMaLoaiTheoTenLoai](@tenLoai NVARCHAR(100))
RETURNS INT
AS
BEGIN
	DECLARE @maLoai INT = -1
	SELECT @maLoai = MaLoai
	FROM LoaiNV
	WHERE TenLoai = @tenLoai

	RETURN @maLoai
END

GO
/****** Object:  Table [dbo].[BangGia]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BangGia](
	[MaDG] [int] IDENTITY(1,1) NOT NULL,
	[MaDV] [int] NOT NULL,
	[MaLX] [int] NOT NULL,
	[DonGia] [int] NOT NULL,
	[TrangThai] [nvarchar](100) NOT NULL CONSTRAINT [DF__BangGia__TrangTh__2D27B809]  DEFAULT (N'Đang dùng'),
 CONSTRAINT [PK_BangGia] PRIMARY KEY CLUSTERED 
(
	[MaDV] ASC,
	[MaLX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietCV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietCV](
	[MaDG] [int] NOT NULL,
	[Soluong] [int] NOT NULL,
 CONSTRAINT [PK_ChiTietCV] PRIMARY KEY CLUSTERED 
(
	[MaDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CongViec]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CongViec](
	[MaDG] [nchar](10) NOT NULL,
	[MaNV] [varchar](10) NOT NULL,
	[NgayLam] [datetime] NOT NULL,
	[TongTien] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_CV] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC,
	[NgayLam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DichVu]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DichVu](
	[MaDV] [int] IDENTITY(1,1) NOT NULL,
	[TenDV] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiNV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiNV](
	[MaLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiXe]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiXe](
	[MaLX] [int] NOT NULL,
	[TenLX] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__LoaiXe__2725C74F9D980CD1] PRIMARY KEY CLUSTERED 
(
	[MaLX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LuongNV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LuongNV](
	[MaNV] [varchar](10) NOT NULL,
	[Thang] [int] NOT NULL,
	[Nam] [int] NOT NULL,
	[SoNgayThucLam] [int] NOT NULL,
	[TongDoanhThu] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_LuongNV] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC,
	[Thang] ASC,
	[Nam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NangLuc]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NangLuc](
	[MaNV] [varchar](10) NOT NULL,
	[MaDV] [int] NOT NULL,
 CONSTRAINT [PK_NangLuc] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC,
	[MaDV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [varchar](10) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[GioiTinh] [nvarchar](5) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[SoDT] [varchar](10) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[LuongCoBan] [decimal](18, 0) NOT NULL,
	[MaLoai] [int] NOT NULL,
	[TrangThai] [nvarchar](100) NOT NULL DEFAULT (N'Đang làm'),
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenDangNhap] [varchar](10) NOT NULL,
	[MatKhau] [text] NOT NULL CONSTRAINT [DF__TaiKhoan__MatKha__1BFD2C07]  DEFAULT ('741253021220717864511724120418410161155'),
	[MaNV] [varchar](10) NOT NULL,
	[Quyen] [bit] NOT NULL,
 CONSTRAINT [PK__TaiKhoan__55F68FC1C9BFD171] PRIMARY KEY CLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BangGia] ON 

INSERT [dbo].[BangGia] ([MaDG], [MaDV], [MaLX], [DonGia], [TrangThai]) VALUES (1, 1, 1, 1111, N'Đang dùng')
INSERT [dbo].[BangGia] ([MaDG], [MaDV], [MaLX], [DonGia], [TrangThai]) VALUES (2, 10, 2, 3333, N'Đang dùng')
INSERT [dbo].[BangGia] ([MaDG], [MaDV], [MaLX], [DonGia], [TrangThai]) VALUES (4, 10, 3, 2222, N'Đang dùng')
INSERT [dbo].[BangGia] ([MaDG], [MaDV], [MaLX], [DonGia], [TrangThai]) VALUES (5, 10, 4, 6666, N'Đang dùng')
INSERT [dbo].[BangGia] ([MaDG], [MaDV], [MaLX], [DonGia], [TrangThai]) VALUES (3, 10, 5, 3333, N'Đang dùng')
INSERT [dbo].[BangGia] ([MaDG], [MaDV], [MaLX], [DonGia], [TrangThai]) VALUES (7, 10, 12, 8888, N'Đang dùng')
INSERT [dbo].[BangGia] ([MaDG], [MaDV], [MaLX], [DonGia], [TrangThai]) VALUES (11, 10, 13, 8888, N'Đang dùng')
INSERT [dbo].[BangGia] ([MaDG], [MaDV], [MaLX], [DonGia], [TrangThai]) VALUES (6, 10, 14, 7777, N'Đang dùng')
SET IDENTITY_INSERT [dbo].[BangGia] OFF
INSERT [dbo].[ChiTietCV] ([MaDG], [Soluong]) VALUES (1, 0)
INSERT [dbo].[ChiTietCV] ([MaDG], [Soluong]) VALUES (2, 0)
INSERT [dbo].[ChiTietCV] ([MaDG], [Soluong]) VALUES (3, 0)
INSERT [dbo].[ChiTietCV] ([MaDG], [Soluong]) VALUES (4, 0)
INSERT [dbo].[ChiTietCV] ([MaDG], [Soluong]) VALUES (5, 0)
INSERT [dbo].[ChiTietCV] ([MaDG], [Soluong]) VALUES (6, 0)
INSERT [dbo].[ChiTietCV] ([MaDG], [Soluong]) VALUES (7, 0)
INSERT [dbo].[ChiTietCV] ([MaDG], [Soluong]) VALUES (11, 0)
SET IDENTITY_INSERT [dbo].[DichVu] ON 

INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (10, N'Bát phanh sau')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (9, N'Bát phanh trước')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (4, N'Bugi')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (3, N'Chế hòa khí, lọc gió')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (11, N'Công tắc đèn')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (7, N'Dây công tơ mét')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (6, N'Dây ga')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (8, N'Dây phanh')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (14, N'Độ pô')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (1, N'Giảm xóc trước')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (5, N'Motor đề')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (12, N'Súc nạp ắc quy')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (13, N'Thay dàn áo')
INSERT [dbo].[DichVu] ([MaDV], [TenDV]) VALUES (2, N'Thay nhớt')
SET IDENTITY_INSERT [dbo].[DichVu] OFF
SET IDENTITY_INSERT [dbo].[LoaiNV] ON 

INSERT [dbo].[LoaiNV] ([MaLoai], [TenLoai]) VALUES (1, N'Nhân viên quản lý')
INSERT [dbo].[LoaiNV] ([MaLoai], [TenLoai]) VALUES (2, N'Nhân viên sửa chữa')
SET IDENTITY_INSERT [dbo].[LoaiNV] OFF
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (2, N'cup 150 version 2022')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (6, N'Honda Air Blade 125')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (5, N'Honda Future 125 Fi')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (4, N'Honda Lead 125 Fi')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (3, N'Honda SH Mode 125')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (14, N'Honda Winner 2023')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (12, N'Honda Winner XYZ')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (7, N'SYM Attila 50')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (9, N'SYM Elite 50')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (8, N'SYM Passing 50')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (1, N'Winner XYZ')
INSERT [dbo].[LoaiXe] ([MaLX], [TenLX]) VALUES (13, N'YaZ 125i')
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 6, 2022, 18, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'ADMIN', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 6, 2022, 17, CAST(18887 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT000', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 6, 2022, 20, CAST(15554 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT001', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT002', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 6, 2022, 20, CAST(3333 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT003', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT004', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVBT005', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL000', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 6, 2022, 19, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL001', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL002', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL003', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL004', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL005', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 1, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 2, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 3, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 4, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 5, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 6, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 7, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 8, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 9, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 10, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 11, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[LuongNV] ([MaNV], [Thang], [Nam], [SoNgayThucLam], [TongDoanhThu]) VALUES (N'N21NVQL006', 12, 2022, 20, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 1)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 3)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 4)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 6)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 7)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 8)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 9)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 10)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 11)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT001', 14)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT003', 3)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT003', 4)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT003', 6)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT003', 7)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT003', 8)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT003', 9)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT003', 10)
INSERT [dbo].[NangLuc] ([MaNV], [MaDV]) VALUES (N'N21NVBT003', 11)
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'ADMIN', N'Administrator', N'Nam', CAST(N'2000-01-01' AS Date), N'Học viện công nghệ bưu chính viễn thông Hồ Chí Minh', N'0912012314', N'admin12345@gmail.com', CAST(99999999 AS Decimal(18, 0)), 1, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVBT000', N'Lê Đăng Khánh', N'Nam', CAST(N'2001-03-25' AS Date), N'khu phố 1, phường tân thuận đông, quận 7', N'0392181894', N'tanle6378@gmail.com', CAST(50000000 AS Decimal(18, 0)), 2, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVBT001', N'Trần Phi Hùng', N'Nam', CAST(N'2001-12-31' AS Date), N'2506 Hùng Vương, Ba Ngòi, Cam Ranh, Khánh Hòa', N'0902351379', N'hungdeptrai777@gmail.com', CAST(20000000 AS Decimal(18, 0)), 2, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVBT002', N'Nguyễn Dương Thành', N'Nam', CAST(N'1999-05-21' AS Date), N'Đồng Nai', N'0349031716', N'quang1978@gmail.com', CAST(8000000 AS Decimal(18, 0)), 2, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVBT003', N'Nguyễn Công Phượng Hoàng', N'Nam', CAST(N'1996-03-12' AS Date), N'Thành Phố Gia Lai', N'0344321122', N'cp10@gmail.com', CAST(7000000 AS Decimal(18, 0)), 2, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVBT004', N'Nguyễn Thị Hồng Nhi', N'Nữ', CAST(N'2022-05-21' AS Date), N'Thành phố Quãng Ngãi', N'0123456789', N'tanle6378@gmail.com', CAST(20000000 AS Decimal(18, 0)), 2, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVBT005', N'ddddd', N'Nam', CAST(N'2000-06-01' AS Date), N'Cần Đước, Long An', N'0123456789', N'tanle6378@gmail.com', CAST(15000000 AS Decimal(18, 0)), 2, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVQL000', N'Phạm Đức Phú Phúc', N'Nam', CAST(N'2000-05-07' AS Date), N'Thôn Cam Bình, xã Tân Phước, thị xã LaGi, tỉnh Bình Thuận', N'0923311124', N'phuphuc0705@gmail.com', CAST(10000000 AS Decimal(18, 0)), 1, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVQL001', N'Lê Thị Huyền Trân', N'Nữ', CAST(N'1999-10-02' AS Date), N'Làng Vạn Hạnh, TT. Phú Mỹ, Tân Thành, Bà Rịa - Vũng Tàu', N'0902011999', N'huyentran99@gmail.com', CAST(20000000 AS Decimal(18, 0)), 1, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVQL002', N'Nguyễn Văn Mạnh', N'Nam', CAST(N'2000-03-08' AS Date), N'Đồng Nai', N'0349031716', N'tanle6378@gmail.com', CAST(14000000 AS Decimal(18, 0)), 1, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVQL003', N'Nguyễn Thị Hồng Nhi', N'Nữ', CAST(N'2000-07-27' AS Date), N'Cần Đước, Long An', N'0123456789', N'tanle6378@gmail.com', CAST(20000000 AS Decimal(18, 0)), 1, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVQL004', N'Nguyễn Minh Quang', N'Nam', CAST(N'1998-10-11' AS Date), N'Thành phố Quãng Ngãi', N'0132457676', N'quang1998@gmail.com', CAST(6000000 AS Decimal(18, 0)), 1, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVQL005', N'Nguyễn Thị Hồng Nhi', N'Nữ', CAST(N'2000-06-01' AS Date), N'Cần Đước, Long An', N'0123456789', N'tanle6378@gmail.com', CAST(5000000 AS Decimal(18, 0)), 1, N'Đang làm')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SoDT], [Email], [LuongCoBan], [MaLoai], [TrangThai]) VALUES (N'N21NVQL006', N'Lê Đăng Khánh', N'Nam', CAST(N'2022-06-01' AS Date), N'Cần Đước, Long An', N'0349031716', N'tanle6378@gmail.com', CAST(15000000 AS Decimal(18, 0)), 1, N'Đang làm')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'ADMIN', N'123', N'ADMIN', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVBT000', N'123', N'N21NVBT000', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVBT001', N'123', N'N21NVBT001', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVBT002', N'123', N'N21NVBT002', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVBT003', N'123', N'N21NVBT003', 0)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVBT005', N'123', N'N21NVBT005', 0)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVQL000', N'123', N'N21NVQL000', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVQL001', N'123', N'N21NVQL001', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVQL003', N'123', N'N21NVQL003', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV], [Quyen]) VALUES (N'N21NVQL005', N'123', N'N21NVQL005', 1)
/****** Object:  Index [UQ__BangGia__27258661F5F0E716]    Script Date: 05/06/2022 1:43:18 CH ******/
ALTER TABLE [dbo].[BangGia] ADD  CONSTRAINT [UQ__BangGia__27258661F5F0E716] UNIQUE NONCLUSTERED 
(
	[MaDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__DichVu__4CF965609DCCD911]    Script Date: 05/06/2022 1:43:18 CH ******/
ALTER TABLE [dbo].[DichVu] ADD UNIQUE NONCLUSTERED 
(
	[TenDV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__LoaiNV__E29B10421FA98489]    Script Date: 05/06/2022 1:43:18 CH ******/
ALTER TABLE [dbo].[LoaiNV] ADD UNIQUE NONCLUSTERED 
(
	[TenLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__LoaiXe__4CF9A4644D49E133]    Script Date: 05/06/2022 1:43:18 CH ******/
ALTER TABLE [dbo].[LoaiXe] ADD  CONSTRAINT [UQ__LoaiXe__4CF9A4644D49E133] UNIQUE NONCLUSTERED 
(
	[TenLX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__TaiKhoan__2725D70BC1C1B84C]    Script Date: 05/06/2022 1:43:18 CH ******/
ALTER TABLE [dbo].[TaiKhoan] ADD  CONSTRAINT [UQ__TaiKhoan__2725D70BC1C1B84C] UNIQUE NONCLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BangGia]  WITH CHECK ADD  CONSTRAINT [FK__BangGia__MaDV__2A4B4B5E] FOREIGN KEY([MaDV])
REFERENCES [dbo].[DichVu] ([MaDV])
GO
ALTER TABLE [dbo].[BangGia] CHECK CONSTRAINT [FK__BangGia__MaDV__2A4B4B5E]
GO
ALTER TABLE [dbo].[BangGia]  WITH CHECK ADD  CONSTRAINT [FK__BangGia__MaLX__2B3F6F97] FOREIGN KEY([MaLX])
REFERENCES [dbo].[LoaiXe] ([MaLX])
GO
ALTER TABLE [dbo].[BangGia] CHECK CONSTRAINT [FK__BangGia__MaLX__2B3F6F97]
GO
ALTER TABLE [dbo].[ChiTietCV]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietCV_BangGia] FOREIGN KEY([MaDG])
REFERENCES [dbo].[BangGia] ([MaDG])
GO
ALTER TABLE [dbo].[ChiTietCV] CHECK CONSTRAINT [FK_ChiTietCV_BangGia]
GO
ALTER TABLE [dbo].[CongViec]  WITH CHECK ADD  CONSTRAINT [FK_CV_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[CongViec] CHECK CONSTRAINT [FK_CV_NhanVien]
GO
ALTER TABLE [dbo].[LuongNV]  WITH CHECK ADD  CONSTRAINT [FK_LuongNV_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[LuongNV] CHECK CONSTRAINT [FK_LuongNV_NhanVien]
GO
ALTER TABLE [dbo].[NangLuc]  WITH CHECK ADD  CONSTRAINT [FK_NangLuc_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[NangLuc] CHECK CONSTRAINT [FK_NangLuc_NhanVien]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([MaLoai])
REFERENCES [dbo].[LoaiNV] ([MaLoai])
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK__TaiKhoan__MaNV__1CF15040] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK__TaiKhoan__MaNV__1CF15040]
GO
ALTER TABLE [dbo].[BangGia]  WITH CHECK ADD  CONSTRAINT [CK__BangGia__DonGia__2C3393D0] CHECK  (([DonGia]>=(0)))
GO
ALTER TABLE [dbo].[BangGia] CHECK CONSTRAINT [CK__BangGia__DonGia__2C3393D0]
GO
ALTER TABLE [dbo].[BangGia]  WITH CHECK ADD  CONSTRAINT [CK__BangGia__TrangTh__2E1BDC42] CHECK  (([TrangThai]=N'Ngưng' OR [TrangThai]=N'Đang dùng'))
GO
ALTER TABLE [dbo].[BangGia] CHECK CONSTRAINT [CK__BangGia__TrangTh__2E1BDC42]
GO
ALTER TABLE [dbo].[ChiTietCV]  WITH CHECK ADD  CONSTRAINT [CK__ChiTietCV__Soluo__37A5467C] CHECK  (([SoLuong]>=(0)))
GO
ALTER TABLE [dbo].[ChiTietCV] CHECK CONSTRAINT [CK__ChiTietCV__Soluo__37A5467C]
GO
ALTER TABLE [dbo].[LuongNV]  WITH CHECK ADD  CONSTRAINT [CK_LuongNV_SoNgayThucLam] CHECK  (([SoNgayThucLam]>=(0)))
GO
ALTER TABLE [dbo].[LuongNV] CHECK CONSTRAINT [CK_LuongNV_SoNgayThucLam]
GO
ALTER TABLE [dbo].[LuongNV]  WITH CHECK ADD  CONSTRAINT [CK_LuongNV_TongDoanhThu] CHECK  (([TongDoanhThu]>=(0)))
GO
ALTER TABLE [dbo].[LuongNV] CHECK CONSTRAINT [CK_LuongNV_TongDoanhThu]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD CHECK  (([GioiTinh]=N'Nữ' OR [GioiTinh]=N'Nam'))
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD CHECK  (([LuongCoBan]>=(0)))
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD CHECK  ((isnumeric([SoDT])=(1)))
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD CHECK  (([TrangThai]=N'Nghỉ' OR [TrangThai]=N'Đang làm'))
GO
/****** Object:  StoredProcedure [dbo].[find_nhanvien_by_maNV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[find_nhanvien_by_maNV] (@maNV nchar(10))
as
begin

select*from NhanVien where NhanVien.MaNV = @maNV

return 

end
GO
/****** Object:  StoredProcedure [dbo].[sp_AUTO_MANVQL]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_AUTO_MANVQL]
AS
BEGIN
	DECLARE @ID VARCHAR(10)
	IF (SELECT COUNT(MaNV) FROM NhanVien) = 0
		SET @ID = 'N21NVQL000'
	ELSE
		SELECT @ID = MAX(RIGHT(MaNV, 3)) FROM NhanVien
		SELECT @ID = CASE
			WHEN @ID > 0 and @ID <= 9 THEN 'N21NVQL00' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID > 9 and @ID <= 10 THEN 'N21NVQL0' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID > 10 THEN 'N21NVQL' + CONVERT(VARCHAR, CONVERT(INT, @ID) + 1)
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_cong_viec_cua_1_nhan_vien_theo_manv]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_cong_viec_cua_1_nhan_vien_theo_manv] @Manv varchar(10)
as
begin
SELECT NhanVien.MaNV, HoTen, TenDV, TenLX,DonGia,NgayLam FROM CongViec, ChiTietCV, BangGia, NhanVien, DichVu, LoaiXe
where NhanVien.MaNV = CongViec.MaNV 
and ChiTietCV.MaDG = BangGia.MaDG
and CongViec.MaDG = ChiTietCV.MaDG
and BangGia.MaDV = DichVu.MaDV 
and BangGia.MaLX = LoaiXe.MaLX
and CongViec.MaNV = @Manv
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DANHSACHBANGGIA]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_DANHSACHBANGGIA]
AS
BEGIN
select MaDG, LoaiXe.TenLX, DichVu.TenDV, DonGia, TrangThai from BangGia, LoaiXe, DichVu
where BangGia.MaDV = DichVu.MaDV and LoaiXe.MaLX = BangGia.MaLX
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FIND_BANGGIA_BY_ID]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_FIND_BANGGIA_BY_ID] @MaDG int
as
begin
select * from BangGia where MaDG=@MaDG
end
GO
/****** Object:  StoredProcedure [dbo].[SP_get_1_thang_luong_cua_1_nhan_vien]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_get_1_thang_luong_cua_1_nhan_vien] @MaNV varchar(10), @Thang int, @Nam int
as
begin
select * from LuongNV where MaNV=@MaNV and Thang=@Thang and Nam =@Nam
end

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_BANG_LUONG_CUA_MOT_NHAN_VIEN]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_GET_BANG_LUONG_CUA_MOT_NHAN_VIEN] @MANV INT
AS
BEGIN
SELECT * FROM LuongNV WHERE MaNV=@MANV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DONGIA_TRANGTHAI]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_DONGIA_TRANGTHAI] @MaDV int, @MaLX int
AS
BEGIN
SELECT DonGia, TrangThai FROM BangGia bg where MaDV=@MaDV and MaLX=@MaLX
end

GO
/****** Object:  StoredProcedure [dbo].[SP_get_list_luong_theo_thang]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_get_list_luong_theo_thang] @thang int,@nam int
as
begin
select * from LuongNV where Thang=@thang and Nam=@nam
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_LIST_NANGLUC_BY_MANV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_LIST_NANGLUC_BY_MANV](@MaNV nvarchar(10))
as
begin
select * from NangLuc where MaNV = @MaNV
end
GO
/****** Object:  StoredProcedure [dbo].[SP_get_so_luong_cong_viec]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_get_so_luong_cong_viec]
as
begin
select TenDV, DonGia, Soluong 
from ChiTietCV, BangGia, DichVu 
where BangGia.MaDV=DichVu.MaDV and ChiTietCV.MaDG=BangGia.MaDG and BangGia.TrangThai=N'Đang dùng'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GETBANGBIA_BY_MADG]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_GETBANGBIA_BY_MADG](@MaDG int)
AS
BEGIN
select MaDG, LoaiXe.TenLX, DichVu.TenDV, DonGia, TrangThai from BangGia, LoaiXe, DichVu
where BangGia.MaDV = DichVu.MaDV and LoaiXe.MaLX = BangGia.MaLX and MaDG=@MaDG
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDonGia]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_getDonGia] (@MaDV int, @MaLX int)
as
begin
select bg.DonGia, bg.TrangThai  
from DichVu dv, LoaiXe lx, BangGia bg
where bg.MaDV=dv.MaDV and bg.MaLX=lx.MaLX
end
GO
/****** Object:  StoredProcedure [dbo].[SP_getListBangGia]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_getListBangGia]
as
begin
select bg.MaDG, dv.MaDV, dv.TenDV, lx.MaLX, lx.TenLX, bg.DonGia, bg.TrangThai 
from DichVu dv, LoaiXe lx, BangGia bg
where bg.MaDV=dv.MaDV and bg.MaLX=lx.MaLX
end
GO
/****** Object:  StoredProcedure [dbo].[sp_getTaiKhoan]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getTaiKhoan](@TenDangNhap VARCHAR(10))
AS
BEGIN
SELECT TenDangNhap, MatKhau, Quyen
FROM TaiKhoan
WHERE TenDangNhap=@TenDangNhap
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LAY_NHANVIEN_TU_TEN_TAIKHOAN]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_LAY_NHANVIEN_TU_TEN_TAIKHOAN](@TenDangNhap varchar(20))
as
begin
select NhanVien.* from TaiKhoan inner join NhanVien on TaiKhoan.MaNV = NhanVien.MaNV where TaiKhoan.MaNV = @TenDangNhap
end
GO
/****** Object:  StoredProcedure [dbo].[SP_LIST_CONG_VIEC_CUA_MOT_NHAN_VIEN]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LIST_CONG_VIEC_CUA_MOT_NHAN_VIEN]
AS
BEGIN
SELECT NhanVien.MaNV, HoTen, TenDV, TenLX,DonGia,NgayLam FROM CongViec, ChiTietCV, BangGia, NhanVien, DichVu, LoaiXe
where NhanVien.MaNV = CongViec.MaNV 
and ChiTietCV.MaDG = BangGia.MaDG
and CongViec.MaDG = ChiTietCV.MaDG
and BangGia.MaDV = DichVu.MaDV 
and BangGia.MaLX = LoaiXe.MaLX
END

GO
/****** Object:  StoredProcedure [dbo].[SP_LIST_CONG_VIEC_CUA_NHANVIEN]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LIST_CONG_VIEC_CUA_NHANVIEN]
AS
BEGIN
SELECT NhanVien.HoTen, NgayLam, MaLX, MaDV 
 FROM NhanVien, CongViec, BangGia, ChiTietCV
 WHERE NhanVien.MaNV=CongViec.MaNV 
 AND CongViec.MaCV=ChiTietCV.MaCV 
 AND BangGia.MaDG=ChiTietCV.MaDG
 END
GO
/****** Object:  StoredProcedure [dbo].[SP_List_Doanh_Thu_Cua_List_Nhan_Vien_Theo_Thang]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_List_Doanh_Thu_Cua_List_Nhan_Vien_Theo_Thang] @Thang int, @Nam int
as
begin
select NhanVien.MaNV, NhanVien.HoTen, LuongNV.SoNgayThucLam, NhanVien.LuongCoBan, LuongNV.TongDoanhThu,
LuongThucLanh=(NhanVien.LuongCoBan)*((LuongNV.SoNgayThucLam*100/20)*0.01)+(LuongNV.TongDoanhThu*0.05)
from LuongNV, NhanVien 
where Thang=6 and Nam=2022
and NhanVien.MaNV = LuongNV.MaNV
end
GO
/****** Object:  StoredProcedure [dbo].[SP_List_Doanh_Thu_Cua_List_Nhan_Vien_Theo_Thang_Theo_MaNV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_List_Doanh_Thu_Cua_List_Nhan_Vien_Theo_Thang_Theo_MaNV] @Thang int, @Nam int, @MaNV varchar(10)
as
begin
select NhanVien.MaNV, NhanVien.HoTen, LuongNV.SoNgayThucLam, NhanVien.LuongCoBan, LuongNV.TongDoanhThu,
LuongThucLanh=(NhanVien.LuongCoBan)*((LuongNV.SoNgayThucLam*100/20)*0.01)+(LuongNV.TongDoanhThu*0.05)
from LuongNV, NhanVien 
where Thang=@Thang and Nam=@Nam
and NhanVien.MaNV = LuongNV.MaNV and NhanVien.MaNV = @MaNV
end
GO
/****** Object:  StoredProcedure [dbo].[SP_LIST_NANGLUC_BY_MADV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_LIST_NANGLUC_BY_MADV] @MADV INT
AS
BEGIN
SELECT * FROM NangLuc where MaDV=@MADV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LIST_NHANVIEN_CO_NANGLUC_CAN_TIM]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LIST_NHANVIEN_CO_NANGLUC_CAN_TIM] @MADV INT
AS
BEGIN
select NhanVien.* from NhanVien, NangLuc where NhanVien.MaNV = NangLuc.MaNV AND NangLuc.MaDV=@MADV and TrangThai=N'Đang làm'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SAPXEPTANGDAN_NHANVIEN_THEO_LUONGCOBAN]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SAPXEPTANGDAN_NHANVIEN_THEO_LUONGCOBAN]
AS
BEGIN
SELECT * FROM NhanVien ORDER BY LuongCoBan
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SAPXEPTANGDAN_NHANVIEN_THEO_MANV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SAPXEPTANGDAN_NHANVIEN_THEO_MANV]
AS
BEGIN
SELECT * FROM NhanVien ORDER BY MaNV 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SAPXEPTANGDAN_NHANVIEN_THEO_NGAYSINH]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SAPXEPTANGDAN_NHANVIEN_THEO_NGAYSINH]
AS
BEGIN
SELECT * FROM NhanVien ORDER BY NgaySinh DESC
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SAPXEPTANGDAN_NHANVIEN_THEO_TENNV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SAPXEPTANGDAN_NHANVIEN_THEO_TENNV]
AS
BEGIN
SELECT * FROM NhanVien ORDER BY HoTen
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SHOW_DANHSACHCONGVIEC]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SHOW_DANHSACHCONGVIEC]
AS
BEGIN
SELECT BangGia.MaDG, TenLX, TenDV ,DonGia, Soluong
FROM BangGia, ChiTietCV, DichVu, LoaiXe 
WHERE BangGia.MaDG = ChiTietCV.MaDG 
AND BangGia.MaLX=LoaiXe.MaLX 
AND BangGia.MaDV = DichVu.MaDV
END

SELECT TenDV, Soluong
FROM BangGia, ChiTietCV, DichVu, LoaiXe 
WHERE BangGia.MaDG = ChiTietCV.MaDG 
AND BangGia.MaLX=LoaiXe.MaLX 
AND BangGia.MaDV = DichVu.MaDV


GO
/****** Object:  StoredProcedure [dbo].[SP_TIM_BANGGIA_BY_MADG]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TIM_BANGGIA_BY_MADG](@MaDG int)
AS
BEGIN
SELECT LoaiXe.MaLX, TenLX, DichVu.MaDV, TenDV, DonGia, TrangThai FROM BangGia, DichVu, LoaiXe where DichVu.MaDV=BangGia.MaDV and LoaiXe.MaLX=BangGia.MaLX and MaDG=@MaDG
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TIM_NANGLUC_BY_MANV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_TIM_NANGLUC_BY_MANV](@MaNV varchar(10))
AS
BEGIN
SELECT DichVu.MaDV, DichVu.TenDV FROM DichVu, NangLuc WHERE DichVu.MaDV = NangLuc.MaDV and NangLuc.MaNV = @MaNV
end
GO
/****** Object:  StoredProcedure [dbo].[SP_TONG_TIEN_CUA_DICH_VU]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_TONG_TIEN_CUA_DICH_VU] @MaCV int
AS
BEGIN
SELECT DonGia FROM BangGia, CongViec, ChiTietCV
WHERE BangGia.MaDG = ChiTietCV.MaDG and CongViec.MaCV = ChiTietCV.MaCV and TrangThai=N'Đang dùng' and CongViec.MaCV=@MaCV
end
GO
/****** Object:  StoredProcedure [dbo].[SP_update_so_ngay_thuc_lam]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_update_so_ngay_thuc_lam] @SoNgayThucLam int, @MaNV varchar(10), @Thang int, @Nam int
as
begin
update LuongNV set LuongNV.SoNgayThucLam=@SoNgayThucLam where MaNV=@MaNV and Thang=@Thang and Nam=@Nam
end
GO
/****** Object:  StoredProcedure [dbo].[SP_update_tong_doanh_thu]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_update_tong_doanh_thu] @MANV VARCHAR(10), @THANG INT, @NAM INT, @TONGTIEN decimal(18,0)
as
begin
update LuongNV 
set TongDoanhThu = TongDoanhThu + @TONGTIEN where LuongNV.Thang=@THANG and LuongNV.Nam=@NAM and LuongNV.MaNV=@MANV
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LayMaTiepTheo]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--=================================================== STORED PROCEDURE ===================================================
-- Lấy mã tự tăng tiếp theo
CREATE PROC [dbo].[USP_LayMaTiepTheo]
@table_name VARCHAR(100)
AS
BEGIN
	SELECT IDENT_CURRENT(@table_name) + IDENT_INCR(@table_name)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemDichVuChuaPhanCong]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemNhanVienRutGon '', ''
--===========================================================================================================================
-- Tìm kiếm dịch vụ chưa phân công cho nhân viên
CREATE PROC [dbo].[USP_TimKiemDichVuChuaPhanCong]
@maNV VARCHAR(10),
@tenDV NVARCHAR(100)
AS
BEGIN
	IF(@maNV = '')
	BEGIN
		SELECT MaDV,TenDV
		FROM DichVu
		WHERE 1 = 2
		RETURN
	END

	SELECT MaDV,TenDV
	FROM DichVu
	WHERE dbo.ConvertToUnsign(TenDV) LIKE '%' + dbo.ConvertToUnsign(@tenDV) + '%'
	AND MaDV NOT IN (SELECT MaDV
				FROM NangLuc
				WHERE MaNV = @maNV)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemNhanVienRutGon]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemVaSapXepNangLuc '', '', '', 'MaNV', 'ASC'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp nhân viên rút gọn
CREATE PROC [dbo].[USP_TimKiemNhanVienRutGon]
@maNV VARCHAR(10),
@hoTen NVARCHAR(100)
AS
BEGIN
	SELECT MaNV, HoTen
	FROM NhanVien
	WHERE MaNV LIKE '%' + @maNV + '%'
	AND dbo.ConvertToUnsign(HoTen) LIKE '%' + dbo.ConvertToUnsign(@hoTen) + '%'
	AND TrangThai LIKE N'Đang làm'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepChiTietCV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemVaSapXepCongViec '', '', '2021-04-27', 'MaCV', 'ASC'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp chi tiết công việc
CREATE PROC [dbo].[USP_TimKiemVaSapXepChiTietCV]
@maCV INT,
@tenDV NVARCHAR(100),
@tenLX NVARCHAR(100),
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaDG INT, TenDV NVARCHAR(100), TenLX NVARCHAR(100), DonGia INT, SoLuong INT, Tong INT)

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT CV.MaDG, TenDV, TenLX, DonGia, SoLuong, (DonGia * SoLuong) AS [Tong]
	FROM ChiTietCV AS CV
	INNER JOIN BangGia AS BG ON CV.MaDG = BG.MaDG
	INNER JOIN DichVu AS DV ON BG.MaDV = DV.MaDV
	INNER JOIN LoaiXe AS LX ON BG.MaLX = LX.MaLX
	WHERE MaCV = @maCV
	AND dbo.ConvertToUnsign(TenDV) LIKE ''%'' + dbo.ConvertToUnsign(@tenDV) + ''%''
	AND dbo.ConvertToUnsign(TenLX) LIKE ''%'' + dbo.ConvertToUnsign(@tenLX) + ''%''
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaDG, TenDV, TenLX, DonGia, SoLuong, Tong)
	EXEC sp_executesql @query,
	N'@maCV INT,
	@tenDV NVARCHAR(100),
	@tenLX NVARCHAR(100),
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@maCV,
	@tenDV,
	@tenLX,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepCongViec]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemVaSapXepDonGia '', '', N'Đang dùng', 'MaDG', 'ASC'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp các công việc trong ngày
CREATE PROC [dbo].[USP_TimKiemVaSapXepCongViec]
@maNV VARCHAR(10),
@hoTen NVARCHAR(100),
@ngayLam DATE,
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaCV INT, MaNV VARCHAR(10), HoTen NVARCHAR(100), TongTien DECIMAL)

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT MaCV, CV.MaNV, HoTen, TongTien
	FROM CongViec AS CV
	INNER JOIN NhanVien AS NV ON CV.MaNV = NV.MaNV
	WHERE CV.MaNV LIKE ''%'' + @maNV + ''%''
	AND dbo.ConvertToUnsign(HoTen) LIKE ''%'' + dbo.ConvertToUnsign(@hoTen) + ''%''
	AND NgayLam = @ngayLam
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaCV, MaNV, HoTen, TongTien)
	EXEC sp_executesql @query,
	N'@maNV VARCHAR(10),
	@hoTen NVARCHAR(100),
	@ngayLam DATE,
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@maNV,
	@hoTen,
	@ngayLam,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepDichVu]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemVaSapXepNhanVien '', '', '', '1753-1-1', '9998-12-31', '', '', '', 0, 1000000000, '', N'', 'LuongCoBan', 'ASC'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp dịch vụ
CREATE PROC [dbo].[USP_TimKiemVaSapXepDichVu]
@tenDV NVARCHAR(100),
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaDV INT, TenDV NVARCHAR(100))

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT MaDV, TenDV
	FROM DichVu
	WHERE dbo.ConvertToUnsign(TenDV) LIKE ''%'' + dbo.ConvertToUnsign(@tenDV) + ''%''
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaDV, TenDV)
	EXEC sp_executesql @query,
	N'@tenDV NVARCHAR(100),
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@tenDV,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepDonGia]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemDichVuChuaPhanCong 'N21NVQL000', ''
--===========================================================================================================================
-- Tìm kiếm và sắp xếp các đơn giá
CREATE PROC [dbo].[USP_TimKiemVaSapXepDonGia]
@tenDV NVARCHAR(100),
@tenLX NVARCHAR(100),
@trangThai NVARCHAR(100),
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaDG INT, TenDV NVARCHAR(100), TenLX NVARCHAR(100), DonGia INT, TrangThai NVARCHAR(100))

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT MaDG, TenDV, TenLX, DonGia, TrangThai
	FROM BangGia AS BG
	INNER JOIN DichVu AS DV ON BG.MaDV = DV.MaDV
	INNER JOIN LoaiXe AS LX ON BG.MaLX = LX.MaLX
	WHERE dbo.ConvertToUnsign(TenDV) LIKE ''%'' + dbo.ConvertToUnsign(@tenDV) + ''%''
	AND dbo.ConvertToUnsign(TenLX) LIKE ''%'' + dbo.ConvertToUnsign(@tenLX) + ''%''
	AND TrangThai LIKE ''%'' + @trangThai + ''%''
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaDG, TenDV, TenLX, DonGia, TrangThai)
	EXEC sp_executesql @query,
	N'@tenDV NVARCHAR(100),
	@tenLX NVARCHAR(100),
	@trangThai NVARCHAR(100),
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@tenDV,
	@tenLX,
	@trangThai,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepDonGiaTheoNhanVien]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemVaSapXepChiTietCV -1, '', '', 'TenDV', 'ASC'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp các đơn giá phù hợp với nhân viên (theo bảng năng lực) và đang được dùng
CREATE PROC [dbo].[USP_TimKiemVaSapXepDonGiaTheoNhanVien]
@maNV VARCHAR(10),
@tenDV NVARCHAR(100),
@tenLX NVARCHAR(100),
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaDG INT, TenDV NVARCHAR(100), TenLX NVARCHAR(100), DonGia INT, TrangThai NVARCHAR(100))

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT MaDG, TenDV, TenLX, DonGia, TrangThai
	FROM BangGia AS BG
	INNER JOIN DichVu AS DV ON BG.MaDV = DV.MaDV
	INNER JOIN LoaiXe AS LX ON BG.MaLX = LX.MaLX
	WHERE dbo.ConvertToUnsign(TenDV) LIKE ''%'' + dbo.ConvertToUnsign(@tenDV) + ''%''
	AND dbo.ConvertToUnsign(TenLX) LIKE ''%'' + dbo.ConvertToUnsign(@tenLX) + ''%''
	AND TrangThai = N''Đang dùng''
	AND DV.MaDV IN (SELECT MaDV
				FROM NangLuc
				WHERE MaNV = @maNV)
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaDG, TenDV, TenLX, DonGia, TrangThai)
	EXEC sp_executesql @query,
	N'@maNV VARCHAR(10),
	@tenDV NVARCHAR(100),
	@tenLX NVARCHAR(100),
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@maNV,
	@tenDV,
	@tenLX,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepLoaiXe]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- USP_TimKiemVaSapXepDichVu '', 'TenDV', 'ASC'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp loại xe
CREATE PROC [dbo].[USP_TimKiemVaSapXepLoaiXe]
@tenLX NVARCHAR(100),
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaLX INT, TenLX NVARCHAR(100))

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT MaLX, TenLX
	FROM LoaiXe
	WHERE dbo.ConvertToUnsign(TenLX) LIKE ''%'' + dbo.ConvertToUnsign(@tenLX) + ''%''
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaLX, TenLX)
	EXEC sp_executesql @query,
	N'@tenLX NVARCHAR(100),
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@tenLX,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepLuong]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemVaSapXepDonGiaTheoNhanVien 'N21NVQL000', '', '', 'MaDG', 'ASC'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp lương nhân viên
CREATE PROC [dbo].[USP_TimKiemVaSapXepLuong]
@maNV VARCHAR(10),
@hoTen NVARCHAR(100),
@tuSoNgayThucLam INT,
@denSoNgayThucLam INT,
@tuThang INT,
@denThang INT,
@tuNam INT,
@denNam INT,
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaNV VARCHAR(10), HoTen NVARCHAR(100), Thang INT, Nam INT, SoNgayThucLam INT, TongDoanhThu DECIMAL, LuongThucLanh DECIMAL)

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT L.MaNV, HoTen, Thang, Nam, SoNgayThucLam, TongDoanhThu, (LuongCoBan * SoNgayThucLam / 26 + TongDoanhThu * 0.05) AS LuongThucLanh
	FROM Luong AS L
	INNER JOIN NhanVien AS NV ON L.MaNV = NV.MaNV
	WHERE L.MaNV LIKE ''%'' + @maNV + ''%''
	AND dbo.ConvertToUnsign(HoTen) LIKE ''%'' + dbo.ConvertToUnsign(@hoTen) + ''%''
	AND (SoNgayThucLam >= @tuSoNgayThucLam AND SoNgayThucLam <= @denSoNgayThucLam)
	AND (Thang >= @tuThang AND Thang <= @denThang)
	AND (Nam >= @tuNam AND Nam <= @denNam)
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaNV, HoTen, Thang, Nam, SoNgayThucLam, TongDoanhThu, LuongThucLanh)
	EXEC sp_executesql @query,
	N'@maNV VARCHAR(10),
	@hoTen NVARCHAR(100),
	@tuSoNgayThucLam INT,
	@denSoNgayThucLam INT,
	@tuThang INT,
	@denThang INT,
	@tuNam INT,
	@denNam INT,
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@maNV,
	@hoTen,
	@tuSoNgayThucLam,
	@denSoNgayThucLam,
	@tuThang,
	@denThang,
	@tuNam,
	@denNam,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepNangLuc]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_TimKiemVaSapXepLoaiXe '', 'MaLX', 'ASC'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp năng lực
CREATE PROC [dbo].[USP_TimKiemVaSapXepNangLuc]
@maNV VARCHAR(10),
@hoTen NVARCHAR(100),
@tenDV NVARCHAR(100),
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaNV VARCHAR(10), HoTen NVARCHAR(100), MaDV INT, TenDV NVARCHAR(100))

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT NL.MaNV, HoTen, NL.MaDV, TenDV
	FROM NangLuc AS NL
	INNER JOIN NhanVien AS NV ON NL.MaNV = NV.MaNV
	INNER JOIN DichVu AS DV ON NL.MaDV = DV.MaDV
	WHERE NL.MaNV LIKE ''%'' + @maNV + ''%''
	AND dbo.ConvertToUnsign(HoTen) LIKE ''%'' + dbo.ConvertToUnsign(@hoTen) + ''%''
	AND dbo.ConvertToUnsign(TenDV) LIKE ''%'' + dbo.ConvertToUnsign(@tenDV) + ''%''
	AND TrangThai = N''Đang làm''
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaNV, HoTen, MaDV, TenDV)
	EXEC sp_executesql @query,
	N'@maNV VARCHAR(10),
	@hoTen NVARCHAR(100),
	@tenDV NVARCHAR(100),
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@maNV,
	@hoTen,
	@tenDV,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemVaSapXepNhanVien]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_LayMaDVTiepTheo 'DichVu'
--===========================================================================================================================
-- Tìm kiếm và sắp xếp nhân viên - tài khoản
CREATE PROC [dbo].[USP_TimKiemVaSapXepNhanVien]
@maNV VARCHAR(10),
@hoTen NVARCHAR(100),
@gioiTinh NVARCHAR(5),
@tuNgay DATE,
@denNgay DATE,
@diaChi NVARCHAR(100),
@soDT VARCHAR(10),
@email VARCHAR(100),
@tuLuong DECIMAL,
@denLuong DECIMAL,
@tenLoai NVARCHAR(100),
@trangThai NVARCHAR(100),
@tenCot VARCHAR(100),
@huongSapXep VARCHAR(5)
AS
BEGIN
	DECLARE @table TABLE
	(MaNV VARCHAR(10), HoTen NVARCHAR(100), GioiTinh NVARCHAR(5), NgaySinh DATE, DiaChi NVARCHAR(100),
	SoDT VARCHAR(10), Email VARCHAR(100), LuongCoBan DECIMAL, TenDangNhap VARCHAR(100), TenLoai NVARCHAR(100), TrangThai NVARCHAR(100))

	DECLARE @query NVARCHAR(MAX)

	SELECT @query = 
	N'SELECT N.MaNV, HoTen, GioiTinh, NgaySinh, DiaChi, SoDT, Email, LuongCoBan, TenDangNhap, TenLoai, TrangThai
	FROM NhanVien AS N
	INNER JOIN LoaiNV AS L ON N.MaLoai = L.MaLoai
	LEFT JOIN TaiKhoan AS T ON T.MaNV = N.MaNV
	WHERE N.MaNV LIKE ''%'' + @maNV + ''%'' 
	AND dbo.ConvertToUnsign(HoTen) LIKE ''%'' + dbo.ConvertToUnsign(@hoTen) + ''%''
	AND GioiTinh LIKE ''%'' + @gioiTinh + ''%''
	AND (NgaySinh >= @tuNgay AND NgaySinh <= @denNgay)
	AND dbo.ConvertToUnsign(DiaChi) LIKE ''%'' + dbo.ConvertToUnsign(@diaChi) + ''%''
	AND SoDT LIKE ''%'' + @soDT + ''%''
	AND Email LIKE ''%'' + @email + ''%''
	AND (LuongCoBan >= @tuLuong AND LuongCoBan <= @denLuong)
	AND TenLoai LIKE ''%'' + @tenLoai + ''%''
	AND TrangThai LIKE ''%'' + @trangThai + ''%''
	AND N.MaNV <> ''ADMIN''
	ORDER BY ' + @tenCot + ' ' + @huongSapXep
    
	INSERT INTO @table (MaNV, HoTen, GioiTinh, NgaySinh, DiaChi, SoDT, Email, LuongCoBan, TenDangNhap, TenLoai, TrangThai)
	EXEC sp_executesql @query,
	N'@maNV VARCHAR(10),
	@hoTen NVARCHAR(100),
	@gioiTinh NVARCHAR(5),
	@tuNgay DATE,
	@denNgay DATE,
	@diaChi NVARCHAR(100),
	@soDT VARCHAR(10),
	@email VARCHAR(100),
	@tuLuong DECIMAL,
	@denLuong DECIMAL,
	@tenLoai NVARCHAR(100),
	@trangThai NVARCHAR(100),
	@tenCot VARCHAR(100),
	@huongSapXep VARCHAR(5)',
	@maNV,
	@hoTen,
	@gioiTinh,
	@tuNgay,
	@denNgay,
	@diaChi,
	@soDT,
	@email,
	@tuLuong,
	@denLuong,
	@tenLoai,
	@trangThai,
	@tenCot,
	@huongSapXep

	SELECT * FROM @table
END

GO
/****** Object:  Trigger [dbo].[UTG_CapNhatTrangThaiKhiThemSuaDonGia]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--++++++++++++++++++++++++++++++++++++++++++++++++++++ TRIGGER ++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Khi thêm/sửa(TrangThai) đơn giá, ngưng (tất cả) đơn giá có MaDV và MaLX tương ứng
CREATE TRIGGER [dbo].[UTG_CapNhatTrangThaiKhiThemSuaDonGia]
ON [dbo].[BangGia] FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @maDG INT = -1
	DECLARE @maDV INT = -1
	DECLARE @maLX INT = -1
	DECLARE @trangThai NVARCHAR(100)

	SELECT @maDG = MaDG, @maDV = MaDV, @maLX = MaLX, @trangThai = TrangThai
	FROM inserted

	IF(@trangThai = N'Đang dùng')
	BEGIN
		UPDATE BangGia
		SET TrangThai = N'Ngưng'
		WHERE MaDV = @maDV AND MaLX = @maLX
		AND MaDG != @maDG
	END
END

GO
/****** Object:  Trigger [dbo].[TRIGGER_Them_So_Luong_Trong_CTCV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[TRIGGER_Them_So_Luong_Trong_CTCV] on [dbo].[CongViec] after insert as
begin
	UPDATE ChiTietCV 
	set ChiTietCV.Soluong = ChiTietCV.Soluong + 1 from inserted where ChiTietCV.MaDG = inserted.MaDG
end

GO
/****** Object:  Trigger [dbo].[TRIGGER_Tru_So_Luong_Trong_CTCV]    Script Date: 05/06/2022 1:43:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[TRIGGER_Tru_So_Luong_Trong_CTCV] on [dbo].[CongViec] for delete as
begin 
	UPDATE ChiTietCV 
	set ChiTietCV.Soluong = ChiTietCV.Soluong - 1 from deleted where ChiTietCV.MaDG = deleted.MaDG
end

GO
USE [master]
GO
ALTER DATABASE [QLNV_CHBHXM] SET  READ_WRITE 
GO
