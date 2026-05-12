USE [master]
GO
/****** Object:  Database [QuanLyCamDo]    Script Date: 5/12/2026 11:12:07 AM ******/
CREATE DATABASE [QuanLyCamDo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyCamDo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\QuanLyCamDo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyCamDo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\QuanLyCamDo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QuanLyCamDo] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyCamDo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyCamDo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyCamDo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyCamDo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyCamDo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyCamDo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyCamDo] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyCamDo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyCamDo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyCamDo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyCamDo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyCamDo] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [QuanLyCamDo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyCamDo', N'ON'
GO
ALTER DATABASE [QuanLyCamDo] SET QUERY_STORE = ON
GO
ALTER DATABASE [QuanLyCamDo] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QuanLyCamDo]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CalcMoneyContract]    Script Date: 5/12/2026 11:12:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_CalcMoneyContract]
(
    @ContractID INT,
    @TargetDate DATE
)

RETURNS DECIMAL(18,2)

AS
BEGIN

    DECLARE @LoanAmount DECIMAL(18,2)

    DECLARE @CreateDate DATE

    DECLARE @Days INT

    DECLARE @Interest DECIMAL(18,2)

    DECLARE @Total DECIMAL(18,2)

    SELECT
        @LoanAmount = LoanAmount,
        @CreateDate = CreateDate

    FROM HopDong

    WHERE ContractID = @ContractID

    SET @Days =
    DATEDIFF(
        DAY,
        @CreateDate,
        @TargetDate
    )

    SET @Interest =
    (@LoanAmount / 1000000.0)
    * 5000
    * @Days

    SET @Total =
    @LoanAmount + @Interest

    RETURN @Total

END
GO
/****** Object:  Table [dbo].[HopDong]    Script Date: 5/12/2026 11:12:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDong](
	[ContractID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[LoanAmount] [decimal](18, 2) NULL,
	[RemainingDebt] [decimal](18, 2) NULL,
	[CreateDate] [date] NULL,
	[Deadline1] [date] NULL,
	[Deadline2] [date] NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ContractID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HopDong_TaiSan]    Script Date: 5/12/2026 11:12:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDong_TaiSan](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContractID] [int] NULL,
	[AssetID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 5/12/2026 11:12:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[Phone] [varchar](10) NULL,
	[CCCD] [varchar](12) NULL,
	[Address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiSan]    Script Date: 5/12/2026 11:12:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiSan](
	[AssetID] [int] IDENTITY(1,1) NOT NULL,
	[AssetName] [nvarchar](100) NULL,
	[AssetValue] [decimal](18, 2) NULL,
	[AssetStatus] [nvarchar](50) NULL,
	[IsSold] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhToan]    Script Date: 5/12/2026 11:12:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhToan](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[ContractID] [int] NULL,
	[PayDate] [date] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Collector] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[HopDong] ON 

INSERT [dbo].[HopDong] ([ContractID], [CustomerID], [LoanAmount], [RemainingDebt], [CreateDate], [Deadline1], [Deadline2], [Status]) VALUES (1, 1, CAST(10000000.00 AS Decimal(18, 2)), CAST(7500000.00 AS Decimal(18, 2)), CAST(N'2026-05-01' AS Date), CAST(N'2026-05-01' AS Date), CAST(N'2026-05-20' AS Date), N'Đang trả góp')
INSERT [dbo].[HopDong] ([ContractID], [CustomerID], [LoanAmount], [RemainingDebt], [CreateDate], [Deadline1], [Deadline2], [Status]) VALUES (2, 2, CAST(15000000.00 AS Decimal(18, 2)), CAST(15000000.00 AS Decimal(18, 2)), CAST(N'2026-04-20' AS Date), CAST(N'2026-04-30' AS Date), CAST(N'2026-05-10' AS Date), N'Đã thanh lý')
INSERT [dbo].[HopDong] ([ContractID], [CustomerID], [LoanAmount], [RemainingDebt], [CreateDate], [Deadline1], [Deadline2], [Status]) VALUES (3, 3, CAST(8000000.00 AS Decimal(18, 2)), CAST(8000000.00 AS Decimal(18, 2)), CAST(N'2026-05-05' AS Date), CAST(N'2026-05-15' AS Date), CAST(N'2026-05-25' AS Date), N'Đang vay')
SET IDENTITY_INSERT [dbo].[HopDong] OFF
GO
SET IDENTITY_INSERT [dbo].[HopDong_TaiSan] ON 

INSERT [dbo].[HopDong_TaiSan] ([ID], [ContractID], [AssetID]) VALUES (1, 1, 1)
INSERT [dbo].[HopDong_TaiSan] ([ID], [ContractID], [AssetID]) VALUES (2, 2, 2)
INSERT [dbo].[HopDong_TaiSan] ([ID], [ContractID], [AssetID]) VALUES (3, 3, 3)
SET IDENTITY_INSERT [dbo].[HopDong_TaiSan] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([CustomerID], [FullName], [Phone], [CCCD], [Address]) VALUES (1, N'Trần Minh Quang', N'0982456712', N'019204008761', N'Thái Nguyên')
INSERT [dbo].[KhachHang] ([CustomerID], [FullName], [Phone], [CCCD], [Address]) VALUES (2, N'Phạm Đức Huy', N'0978123456', N'001204015432', N'Hà Nội')
INSERT [dbo].[KhachHang] ([CustomerID], [FullName], [Phone], [CCCD], [Address]) VALUES (3, N'Lê Quốc Bảo', N'0365987412', N'042204009876', N'Bắc Giang')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiSan] ON 

INSERT [dbo].[TaiSan] ([AssetID], [AssetName], [AssetValue], [AssetStatus], [IsSold]) VALUES (1, N'IPhone 15 Pro Max', CAST(28000000.00 AS Decimal(18, 2)), N'Đang cầm cố', 0)
INSERT [dbo].[TaiSan] ([AssetID], [AssetName], [AssetValue], [AssetStatus], [IsSold]) VALUES (2, N'Laptop Dell G15', CAST(22000000.00 AS Decimal(18, 2)), N'Đã bán thanh lý', 1)
INSERT [dbo].[TaiSan] ([AssetID], [AssetName], [AssetValue], [AssetStatus], [IsSold]) VALUES (3, N'Xe Wave Alpha', CAST(18000000.00 AS Decimal(18, 2)), N'Đang cầm cố', 0)
SET IDENTITY_INSERT [dbo].[TaiSan] OFF
GO
SET IDENTITY_INSERT [dbo].[ThanhToan] ON 

INSERT [dbo].[ThanhToan] ([PaymentID], [ContractID], [PayDate], [Amount], [Collector]) VALUES (1, 1, CAST(N'2026-05-11' AS Date), CAST(3000000.00 AS Decimal(18, 2)), N'Lê Văn Minh')
SET IDENTITY_INSERT [dbo].[ThanhToan] OFF
GO
ALTER TABLE [dbo].[TaiSan] ADD  DEFAULT ((0)) FOR [IsSold]
GO
ALTER TABLE [dbo].[HopDong]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[KhachHang] ([CustomerID])
GO
ALTER TABLE [dbo].[HopDong_TaiSan]  WITH CHECK ADD FOREIGN KEY([AssetID])
REFERENCES [dbo].[TaiSan] ([AssetID])
GO
ALTER TABLE [dbo].[HopDong_TaiSan]  WITH CHECK ADD FOREIGN KEY([ContractID])
REFERENCES [dbo].[HopDong] ([ContractID])
GO
ALTER TABLE [dbo].[ThanhToan]  WITH CHECK ADD FOREIGN KEY([ContractID])
REFERENCES [dbo].[HopDong] ([ContractID])
GO
/****** Object:  StoredProcedure [dbo].[sp_Payment]    Script Date: 5/12/2026 11:12:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Payment]
(
    @ContractID INT,

    @MoneyPaid DECIMAL(18,2),

    @Collector NVARCHAR(100)
)

AS
BEGIN

    DECLARE @CurrentDebt DECIMAL(18,2)

    SELECT
    @CurrentDebt =
    dbo.fn_CalcMoneyContract(
        @ContractID,
        GETDATE()
    )

    INSERT INTO ThanhToan
    VALUES
    (
        @ContractID,
        GETDATE(),
        @MoneyPaid,
        @Collector
    )

    UPDATE HopDong
    SET RemainingDebt =
    @CurrentDebt - @MoneyPaid

    WHERE ContractID = @ContractID

    IF (@CurrentDebt - @MoneyPaid) <= 0

    BEGIN

        UPDATE HopDong
        SET Status = N'Đã thanh toán'

        WHERE ContractID = @ContractID

    END

    ELSE

    BEGIN

        UPDATE HopDong
        SET Status = N'Đang trả góp'

        WHERE ContractID = @ContractID

    END

END
GO
/****** Object:  Trigger [dbo].[TRG_QuaHan]    Script Date: 5/12/2026 11:12:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_QuaHan]
ON [dbo].[HopDong]
AFTER UPDATE
AS
BEGIN

    UPDATE HopDong

    SET Status = N'Quá hạn'

    WHERE
    GETDATE() > Deadline1
    AND Status = N'Đang vay'

END
GO
ALTER TABLE [dbo].[HopDong] ENABLE TRIGGER [TRG_QuaHan]
GO
/****** Object:  Trigger [dbo].[TRG_ThanhLy]    Script Date: 5/12/2026 11:12:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_ThanhLy]
ON [dbo].[HopDong]
AFTER UPDATE
AS
BEGIN

    UPDATE TaiSan

    SET
    AssetStatus = N'Đã bán thanh lý',
    IsSold = 1

    WHERE AssetID IN
    (
        SELECT AssetID
        FROM HopDong_TaiSan

        WHERE ContractID IN
        (
            SELECT ContractID
            FROM inserted

            WHERE Status = N'Đã thanh lý'
        )
    )

END
GO
ALTER TABLE [dbo].[HopDong] ENABLE TRIGGER [TRG_ThanhLy]
GO
USE [master]
GO
ALTER DATABASE [QuanLyCamDo] SET  READ_WRITE 
GO
