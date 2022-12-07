CREATE DATABASE DB_Training
GO
USE DB_Training
GO
--DROP DATABASE IF EXISTS DB_Training

CREATE TABLE [dbo].[MB_PhanHe]
(
[Id] [int] NOT NULL, -- Được nhập giá trị số (bắt buộc nhập)
MaPhanHe NVARCHAR(20),--(bắt buộc nhập)
[TenPhanHe] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,--(bắt buộc nhập)
[GhiChu] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsHienThi] BIT,
[NguoiTao] [int] NULL,
[NgayTao] [datetime] NULL,
[NguoiCapNhat] [int] NULL,
[NgayCapNhat] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MB_PhanHe] ADD CONSTRAINT [PK_MB_PhanHe] PRIMARY KEY CLUSTERED ([Id]) ON [PRIMARY]
GO


CREATE TABLE [dbo].[MB_Truong]
(
[Id] [int] NOT NULL, -- Được nhập giá trị số--(bắt buộc nhập)
[MaTruong] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,--(bắt buộc nhập)
[TenTruong] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,--(bắt buộc nhập)
[TruocThuocBo] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DuongDanLogo] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsHienThi] [bit] NOT NULL CONSTRAINT [DF_MB_Truong_IsHienThi] DEFAULT ((0)),
[IsSuDungRieng] [bit] NOT NULL CONSTRAINT [DF_MB_Truong_IsSuDungRieng] DEFAULT ((0)),
[ThongTinRieng] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GhiChu] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Loai] [int] NULL,
[NguoiTao] [int] NULL,
[NgayTao] [datetime] NULL,
[NguoiCapNhat] [int] NULL,
[NgayCapNhat] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[MB_Truong] ADD CONSTRAINT [PK_MB_Truong] PRIMARY KEY CLUSTERED ([Id]) ON [PRIMARY]


GO
CREATE TABLE [dbo].[MB_Truong_PhanHe]
(
[Id] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION, -- Giá trị tự tăng, không nhập
[IDTruong] [int] NULL, -- Chọn MB_Truong--(bắt buộc nhập)
[IDPhanHe] [int] NULL, -- Chọn MB_PhanHe--(bắt buộc nhập)
[Url] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Url_2] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Url_3] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UrlSocket] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubAPI] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubAPI_2] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubAPI_3] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GhiChu] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Warning_RequireSurvey] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FeaturesRequireSurvey] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NguoiTao] [int] NULL,
[NgayTao] [datetime] NULL,
[NguoiCapNhat] [int] NULL,
[NgayCapNhat] [datetime] NULL,
[VersionEgovAPI] [int] NULL CONSTRAINT [DF_MB_Truong_PhanHe_VersionEgovAPI] DEFAULT ((2)),
[UrlPayment] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VersionStudentAPI] [int] NULL CONSTRAINT [DF_MB_Truong_PhanHe_VersionStudentAPI] DEFAULT ((1)),
[WarningMessage] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HasAds] [bit] NULL,
[WebsiteUrl] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VersionWeb] [int] NULL,
[UseHTMLSalaryView] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MB_Truong_PhanHe] ADD CONSTRAINT [PK_MB_Truong_PhanHe] PRIMARY KEY CLUSTERED ([Id]) ON [PRIMARY]
GO

/*
Yêu cầu:

-- Nhập được danh sách phân hệ 
-- Nhập được danh sách trường
-- Nhập được thông tin Trường tương ứng với từng phân hệ

Các cột: 
[NguoiTao] mặc định null,
[NgayTao] Mặc định ngày hiện tại,
[NguoiCapNhat] mặc định null,
[NgayCapNhat] Mặc định ngày cập nhật

*/
--Create procedure
--Lấy tất cả dữ liệu trường
CREATE PROC SP_GetALLTruong
AS
BEGIN
	SELECT t.Id, t.MaTruong, t.TenTruong, t.TruocThuocBo, t.DuongDanLogo, t.IsHienThi, t.IsSuDungRieng, t.ThongTinRieng, t.GhiChu, t.Loai, t.NguoiTao, t.NgayTao, t.NguoiCapNhat, t.NgayCapNhat
	FROM MB_Truong t
END;
GO

--Lấy tất cả dữ liệu phân hệ
CREATE PROC SP_GetAllPhanHe
AS
BEGIN
	SELECT ph.Id, ph.MaPhanHe, ph.TenPhanHe, ph.GhiChu, ph.IsHienThi, ph.NguoiTao, ph.NgayTao, ph.NguoiCapNhat, ph.NgayCapNhat
	FROM MB_PhanHe ph
END;
GO
--Lấy tất cả dữ liệu MB_Truong_PhanHe
CREATE PROC sp_GetALLTruong_PhanHe
AS
BEGIN
	SELECT tph.Id, tph.IDTruong, tph.IDPhanHe, tph.Url, tph.Url_2, tph.Url_3, tph.UrlSocket, tph.SubAPI, tph.SubAPI_2, tph.SubAPI_3, tph.GhiChu, tph.Warning_RequireSurvey, tph.FeaturesRequireSurvey, tph.NguoiTao, tph.NgayTao, tph.NguoiCapNhat, tph.NgayCapNhat, tph.VersionEgovAPI, tph.UrlPayment, tph.VersionStudentAPI, tph.WarningMessage, tph.HasAds, tph.WebsiteUrl, tph.VersionWeb, tph.UseHTMLSalaryView
	FROM MB_Truong_PhanHe tph
END;
GO	

--Lấy danh sách trường theo id
CREATE PROC sp_GetTruongByID @id int
AS
BEGIN
	SELECT t.Id, t.MaTruong, t.TenTruong, t.TruocThuocBo, t.DuongDanLogo, t.IsHienThi, t.IsSuDungRieng, t.ThongTinRieng, t.GhiChu, t.Loai, t.NguoiTao, t.NgayTao, t.NguoiCapNhat, t.NgayCapNhat
	FROM MB_Truong t
	WHERE t.Id = @id
END;
GO

--Xóa dữ liệu trường theo id
CREATE PROC sp_DeleteTruongByID @id int
AS
BEGIN
	DELETE FROM MB_Truong WHERE Id = @id;
END;
GO

--Insert dữ liệu trường
CREATE PROC sp_AddTruong @id int, @matruong nvarchar(20), @tentruong nvarchar(200), @truocthuocbo nvarchar(200), @duongdanlogo ntext, @ishienthi bit, @issudungrieng bit, @thongtinrieng ntext, @ghichu nvarchar(500), @loai int 
AS
BEGIN
	INSERT INTO MB_Truong VALUES (@id, @matruong, @tentruong, @truocthuocbo, @duongdanlogo, @ishienthi, @issudungrieng, @thongtinrieng, @ghichu, @loai, null, GETDATE(), null, null);
END;
GO

--Update dữ liệu trường
CREATE PROC sp_UpdateTruong @id int, @matruong nvarchar(20), @tentruong nvarchar(200), @truocthuocbo nvarchar(200), @duongdanlogo ntext, @ishienthi bit, @issudungrieng bit, @thongtinrieng ntext, @ghichu nvarchar(500), @loai int, @nguoitao int, @nguoicapnhat int
AS
BEGIN
	UPDATE MB_Truong
	SET MaTruong = @matruong, TenTruong = @tentruong, TruocThuocBo = @truocthuocbo, DuongDanLogo = @duongdanlogo, IsHienThi = @ishienthi, IsSuDungRieng = @issudungrieng, ThongTinRieng = @thongtinrieng, GhiChu = @ghichu, Loai = @loai, NguoiTao = @nguoitao, NguoiCapNhat = @nguoicapnhat, NgayCapNhat = GETDATE()
	WHERE Id = @id
END;
GO

--Lấy danh sách phân hệ theo id
CREATE PROC sp_GetPhanHeByID @id int
AS
BEGIN
	SELECT ph.Id, ph.MaPhanHe, ph.TenPhanHe, ph.GhiChu, ph.IsHienThi, ph.NguoiTao, ph.NgayTao, ph.NguoiCapNhat, ph.NgayCapNhat
	FROM MB_PhanHe ph
	WHERE ph.Id = @id
END;
GO

--Insert dữ liệu phân hệ
CREATE PROC sp_AddPhanHe @id int, @maphanhe nvarchar(20), @tenphanhe nvarchar(200), @ghichu nvarchar(500), @ishienthi bit
AS
BEGIN
	INSERT INTO MB_PhanHe VALUES (@id, @maphanhe, @tenphanhe, @ghichu, @ishienthi, null, GETDATE(), null, null);
END;
GO

--Xóa dữ liệu phân hệ theo id
CREATE PROC sp_DeletePhanHeByID @id int
AS
BEGIN
	DELETE FROM MB_PhanHe WHERE Id = @id;
END;
GO

--Update dữ liệu phân hệ
CREATE PROC sp_UpdatePhanHe @id int, @maphanhe nvarchar(20), @tenphanhe nvarchar(200), @ghichu nvarchar(500), @ishienthi bit, @nguoitao int, @nguoicapnhat int
AS
BEGIN
	UPDATE MB_PhanHe SET Id = @id, MaPhanHe = @maphanhe, TenPhanHe = @tenphanhe, GhiChu = @ghichu, IsHienThi = @ishienthi, NguoiTao = @nguoitao, NguoiCapNhat = @nguoicapnhat, NgayCapNhat = GETDATE()
	WHERE Id = @id
END;
GO

--Lấy dữ liệu MB_Truong_PhanHe theo id trường
CREATE PROC sp_GetTruong_PhanHeTheoIDTruong @id int
AS
BEGIN
	SELECT tph.Id, tph.IDTruong, tph.IDPhanHe, tph.Url, tph.Url_2, tph.Url_3, tph.UrlSocket, tph.SubAPI, tph.SubAPI_2, tph.SubAPI_3, tph.GhiChu, tph.Warning_RequireSurvey, tph.FeaturesRequireSurvey, tph.NguoiTao, tph.NgayTao, tph.NguoiCapNhat, tph.NgayCapNhat, tph.VersionEgovAPI, tph.UrlPayment, tph.VersionStudentAPI, tph.WarningMessage, tph.HasAds, tph.WebsiteUrl, tph.VersionWeb, tph.UseHTMLSalaryView
	FROM MB_Truong_PhanHe tph
	WHERE tph.IDTruong = @id
END;
GO
--Lấy dữ liệu MB_Truong_PhanHe theo id
CREATE PROC sp_GetTruong_PhanHeTheoID @id int
AS
BEGIN
	SELECT tph.Id, tph.IDTruong, tph.IDPhanHe, tph.Url, tph.Url_2, tph.Url_3, tph.UrlSocket, tph.SubAPI, tph.SubAPI_2, tph.SubAPI_3, tph.GhiChu, tph.Warning_RequireSurvey, tph.FeaturesRequireSurvey, tph.NguoiTao, tph.NgayTao, tph.NguoiCapNhat, tph.NgayCapNhat, tph.VersionEgovAPI, tph.UrlPayment, tph.VersionStudentAPI, tph.WarningMessage, tph.HasAds, tph.WebsiteUrl, tph.VersionWeb, tph.UseHTMLSalaryView
	FROM MB_Truong_PhanHe tph
	WHERE tph.Id = @id
END;
GO

--Insert dữ liệu MB_Truong_PhanHe
CREATE PROC sp_AddTruong_PhanHe @idtruong int, @idphanhe int, @url nvarchar(500), @url_2 nvarchar(500), @url_3 nvarchar(500), @urlsocket nvarchar(500), @subapi nvarchar(200), @subapi_2 nvarchar(200), @subapi_3 nvarchar(200), @ghichu nvarchar(500), @warning_requiresurvey  nvarchar(1000), @featuresrequiresurvey  nvarchar(250), @versionegovapi int, @urlpayment  nvarchar(500), @versionstudentapi int, @warningmessage  nvarchar(1000), @hasads bit, @websiteurl  nvarchar(500), @versionweb int, @usehtmlsalaryview bit
AS
BEGIN
	INSERT INTO MB_Truong_PhanHe VALUES (@idtruong, @idphanhe, @url, @url_2, @url_3, @urlsocket, @subapi, @subapi_2, @subapi_3, @ghichu, @warning_requiresurvey, @featuresrequiresurvey, null, GETDATE(), null, null,  @versionegovapi, @urlpayment, @versionstudentapi, @warningmessage, @hasads, @websiteurl, @versionweb, @usehtmlsalaryview);
END;
GO
--Xóa dữ liệu MB_Truong_PhanHe theo Id
CREATE PROC sp_DeleteTruong_PhanHeByID @id int
AS
BEGIN
	DELETE FROM MB_Truong_PhanHe WHERE Id = @id;
END;
GO
--Cập nhật dữ liệu MB_Truong_PhanHe
CREATE PROC sp_UpdateTruong_PhanHe @id int, @idtruong int, @idphanhe int, @url nvarchar(500), @url_2 nvarchar(500), @url_3 nvarchar(500), @urlsocket nvarchar(500), @subapi nvarchar(200), @subapi_2 nvarchar(200), @subapi_3 nvarchar(200), @ghichu nvarchar(500), @warning_requiresurvey  nvarchar(1000), @featuresrequiresurvey  nvarchar(250), @nguoitao int, @ngaytao datetime, @nguoicapnhat int, @versionegovapi int, @urlpayment  nvarchar(500), @versionstudentapi int, @warningmessage  nvarchar(1000), @hasads bit, @websiteurl  nvarchar(500), @versionweb int, @usehtmlsalaryview bit
AS
BEGIN
	UPDATE MB_Truong_PhanHe
	SET IDTruong = @idtruong, IDPhanHe = @idphanhe, Url = @url, Url_2 = @url_2, Url_3 = @url_3, UrlSocket = @urlsocket, SubAPI = @subapi, SubAPI_2 = @subapi_2, SubAPI_3 = @subapi_3, GhiChu = @ghichu, Warning_RequireSurvey = @warning_requiresurvey, FeaturesRequireSurvey = @featuresrequiresurvey, NguoiTao = @nguoitao, NgayTao = @ngaytao, NguoiCapNhat = @nguoicapnhat, NgayCapNhat = GETDATE(), VersionEgovAPI = @versionegovapi, UrlPayment = @urlpayment, VersionStudentAPI = @versionstudentapi, WarningMessage = @warningmessage, HasAds = @hasads, WebsiteUrl = @websiteurl, VersionWeb = @versionweb, UseHTMLSalaryView = @usehtmlsalaryview
	WHERE Id = @id
END
GO
--Xóa dữ liệu MB_Truong_PhanHe theo Id trường
CREATE PROC sp_DeleteTruong_PhanHeByIDTruong @idtruong int
AS
BEGIN
	DELETE FROM MB_Truong_PhanHe WHERE IDTruong = @idtruong;
END;
GO

--Nhập dữ liệu MB_Truong
use DB_Training
INSERT INTO MB_Truong VALUES
(1, N'TRUONG001', N'Trường Đại hoc Đà Nẵng', N'Bộ Giáo dục và Đào tạo', 'logo_dhdn.jpg', 1, 0, null, null, null, null, null, null, null),
(2, N'TRUONG002', N'Trường Đại học Huế', N'Bộ Giáo dục và Đào tạo', 'logo_dhh.png', 1, 0, null, null, null, null, null, null, null),
(3, N'TRUONG003', N'Trường Đại học Thái Nguyên', N'Bộ Giáo dục và Đào tạo', 'logo_dhtn.jpg', 1, 0, null, null, null, null, null, null, null);
--SELECT* FROM MB_Truong
--Nhập dữ liệu MB_PhanHe
use DB_Training
INSERT INTO MB_PhanHe VALUES
(1, 'PH001', N'Hệ trung cấp chính quy', null, 1, null, GETDATE(), null, null),
(2, 'PH002', N'Hệ trung cấp tại chức', null, 1, null, GETDATE(), null, null),
(3, 'PH003', N'Hệ vừa học vừa làm', null, 1, null, GETDATE(), null, null);
--SELECT* FROM MB_PhanHe

--Nhập dữ liệu MB_Truong_PhanHe
use DB_Training
INSERT INTO MB_Truong_PhanHe VALUES
(1, 1, null, null, null, null, null, null, null, null, null, null, null, GETDATE(), null, null, 2, null, 1, null, null, null, null, null),
(1, 2, null, null, null, null, null, null, null, null, null, null, null, GETDATE(), null, null, 2, null, 1, null, null, null, null, null),
(2, 1, null, null, null, null, null, null, null, null, null, null, null, GETDATE(), null, null, 2, null, 1, null, null, null, null, null);
--SELECT* FROM MB_Truong_PhanHe
