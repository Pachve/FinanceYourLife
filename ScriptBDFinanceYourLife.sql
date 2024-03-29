USE [master]
GO
/****** Object:  Database [FinanceYourLife]    Script Date: 28/06/2020 3:03:56 ******/
CREATE DATABASE [FinanceYourLife]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FinanceYourLife', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\FinanceYourLife.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FinanceYourLife_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\FinanceYourLife_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FinanceYourLife] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FinanceYourLife].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FinanceYourLife] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FinanceYourLife] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FinanceYourLife] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FinanceYourLife] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FinanceYourLife] SET ARITHABORT OFF 
GO
ALTER DATABASE [FinanceYourLife] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FinanceYourLife] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FinanceYourLife] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FinanceYourLife] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FinanceYourLife] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FinanceYourLife] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FinanceYourLife] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FinanceYourLife] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FinanceYourLife] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FinanceYourLife] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FinanceYourLife] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FinanceYourLife] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FinanceYourLife] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FinanceYourLife] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FinanceYourLife] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FinanceYourLife] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FinanceYourLife] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FinanceYourLife] SET RECOVERY FULL 
GO
ALTER DATABASE [FinanceYourLife] SET  MULTI_USER 
GO
ALTER DATABASE [FinanceYourLife] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FinanceYourLife] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FinanceYourLife] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FinanceYourLife] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [FinanceYourLife] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'FinanceYourLife', N'ON'
GO
USE [FinanceYourLife]
GO
/****** Object:  Table [dbo].[AgenteExterno]    Script Date: 28/06/2020 3:03:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgenteExterno](
	[IDAgenteExterno] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[SedePrincipal] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AgenteExterno] PRIMARY KEY CLUSTERED 
(
	[IDAgenteExterno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BonoContrato]    Script Date: 28/06/2020 3:03:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BonoContrato](
	[IDBonoContrato] [int] IDENTITY(1,1) NOT NULL,
	[ValorComercial] [money] NOT NULL,
	[ValorNominal] [money] NOT NULL,
	[NroAños] [int] NOT NULL,
	[FrecuenciaPago] [nvarchar](50) NOT NULL,
	[DiasPorAño] [int] NOT NULL,
	[TipoTasaInteres] [nvarchar](50) NOT NULL,
	[Capitalizacion] [nvarchar](50) NOT NULL,
	[TasaInteresAnual] [float] NOT NULL,
	[TasaDescuentoAnual] [float] NOT NULL,
	[ImpuestoRenta] [float] NOT NULL,
	[FechaEmision] [date] NOT NULL,
	[FK_IDBonista] [int] NOT NULL,
	[FK_IDCostesIniciales] [int] NOT NULL,
	[FK_IDEmpresaEmisora] [int] NOT NULL,
 CONSTRAINT [PK_BonoContrato] PRIMARY KEY CLUSTERED 
(
	[IDBonoContrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CostesIniciales]    Script Date: 28/06/2020 3:03:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostesIniciales](
	[IDCostesIniciales] [int] IDENTITY(1,1) NOT NULL,
	[PorcPrima] [float] NOT NULL,
	[PorcEstructuracion] [float] NULL,
	[PorcColocacion] [float] NULL,
	[PorcFlotacion] [float] NULL,
	[PorcCAVALI] [float] NULL,
 CONSTRAINT [PK_CostesIniciales] PRIMARY KEY CLUSTERED 
(
	[IDCostesIniciales] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmpresaEmisora]    Script Date: 28/06/2020 3:03:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpresaEmisora](
	[IDEmpresaEmisora] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[RUC] [nvarchar](50) NOT NULL,
	[SedePrincipal] [nvarchar](50) NOT NULL,
	[Rubro] [nvarchar](50) NOT NULL,
	[FK_IDAgenteExterno] [int] NOT NULL,
 CONSTRAINT [PK_EmpresaEmisora] PRIMARY KEY CLUSTERED 
(
	[IDEmpresaEmisora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FlujoPeriodico]    Script Date: 28/06/2020 3:03:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlujoPeriodico](
	[IDFlujoPeriodico] [int] IDENTITY(1,1) NOT NULL,
	[Bono] [money] NOT NULL,
	[BonoIndexado] [money] NOT NULL,
	[Cupon] [money] NOT NULL,
	[Cuota] [money] NOT NULL,
	[Amortizacion] [money] NOT NULL,
	[Prima] [money] NOT NULL,
	[Escudo] [money] NOT NULL,
	[FlujoEmisor] [money] NOT NULL,
	[FlujoEmisorEscudo] [money] NOT NULL,
	[FlujoBonista] [money] NOT NULL,
	[ValorBonoDCP] [money] NOT NULL,
	[FK_IDBonoContrato] [int] NOT NULL,
 CONSTRAINT [PK_FlujoPeriodico] PRIMARY KEY CLUSTERED 
(
	[IDFlujoPeriodico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoUsuario]    Script Date: 28/06/2020 3:03:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoUsuario](
	[IDTipoUsuario] [int] IDENTITY(1,1) NOT NULL,
	[TipoPersona] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TipoUsuario] PRIMARY KEY CLUSTERED 
(
	[IDTipoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UsuarioBonista]    Script Date: 28/06/2020 3:03:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioBonista](
	[IDUsuarioBonista] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [nvarchar](50) NOT NULL,
	[Apellidos] [nvarchar](50) NOT NULL,
	[Correo] [nvarchar](50) NOT NULL,
	[Contraseña] [nvarchar](50) NOT NULL,
	[RUC] [nvarchar](50) NOT NULL,
	[IDTipoUsuario] [int] NOT NULL,
 CONSTRAINT [PK_UsuarioBonista] PRIMARY KEY CLUSTERED 
(
	[IDUsuarioBonista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[AgenteExterno] ON 

INSERT [dbo].[AgenteExterno] ([IDAgenteExterno], [Nombre], [SedePrincipal]) VALUES (1, N'Banco de Comercio', N' Av. Canaval Moreyra 454-452, San Isidro 15047')
INSERT [dbo].[AgenteExterno] ([IDAgenteExterno], [Nombre], [SedePrincipal]) VALUES (2, N'Banco de Crédito del Perú', N'Av. Centenario 156, La Molina 15026')
INSERT [dbo].[AgenteExterno] ([IDAgenteExterno], [Nombre], [SedePrincipal]) VALUES (4, N'Banco Interamericano de Finanzas (BanBif)', N'Av. Rivera Navarrete 600, San Isidro 15046')
INSERT [dbo].[AgenteExterno] ([IDAgenteExterno], [Nombre], [SedePrincipal]) VALUES (5, N'Banco Pichincha', N'Av. Ricardo Palma 278, Miraflores 15074')
INSERT [dbo].[AgenteExterno] ([IDAgenteExterno], [Nombre], [SedePrincipal]) VALUES (6, N'BBVA Continental', N'Av. República de Panamá 3055-San isidro')
INSERT [dbo].[AgenteExterno] ([IDAgenteExterno], [Nombre], [SedePrincipal]) VALUES (7, N'Interbank', N'Av. Carlos Villarán 140, La Victoria 15034')
INSERT [dbo].[AgenteExterno] ([IDAgenteExterno], [Nombre], [SedePrincipal]) VALUES (8, N'Scotiabank', N'Av Dionisio Derteano 102, San Isidro 15047')
INSERT [dbo].[AgenteExterno] ([IDAgenteExterno], [Nombre], [SedePrincipal]) VALUES (9, N'Banco Santander Perú', N'Av. Rivera Navarrete 475, San Isidro 15046')
SET IDENTITY_INSERT [dbo].[AgenteExterno] OFF
SET IDENTITY_INSERT [dbo].[BonoContrato] ON 

INSERT [dbo].[BonoContrato] ([IDBonoContrato], [ValorComercial], [ValorNominal], [NroAños], [FrecuenciaPago], [DiasPorAño], [TipoTasaInteres], [Capitalizacion], [TasaInteresAnual], [TasaDescuentoAnual], [ImpuestoRenta], [FechaEmision], [FK_IDBonista], [FK_IDCostesIniciales], [FK_IDEmpresaEmisora]) VALUES (1, 360450.0000, 356000.0000, 4, N'Mensual', 360, N'Tasa Nominal', N'Semestral', 7.640625, 4.5, 30, CAST(N'2020-06-26' AS Date), 1, 1, 1)
INSERT [dbo].[BonoContrato] ([IDBonoContrato], [ValorComercial], [ValorNominal], [NroAños], [FrecuenciaPago], [DiasPorAño], [TipoTasaInteres], [Capitalizacion], [TasaInteresAnual], [TasaDescuentoAnual], [ImpuestoRenta], [FechaEmision], [FK_IDBonista], [FK_IDCostesIniciales], [FK_IDEmpresaEmisora]) VALUES (2, 1433700.0000, 1416000.0000, 4, N'Anual', 360, N'Tasa Efectiva', N'Ninguno', 7.5, 4.5, 30, CAST(N'2020-06-26' AS Date), 1, 1, 1)
INSERT [dbo].[BonoContrato] ([IDBonoContrato], [ValorComercial], [ValorNominal], [NroAños], [FrecuenciaPago], [DiasPorAño], [TipoTasaInteres], [Capitalizacion], [TasaInteresAnual], [TasaDescuentoAnual], [ImpuestoRenta], [FechaEmision], [FK_IDBonista], [FK_IDCostesIniciales], [FK_IDEmpresaEmisora]) VALUES (3, 226950.0000, 222500.0000, 3, N'Semestral', 360, N'Tasa Nominal', N'Semestral', 8.628506, 4.5, 30, CAST(N'2020-06-26' AS Date), 1, 1, 1)
INSERT [dbo].[BonoContrato] ([IDBonoContrato], [ValorComercial], [ValorNominal], [NroAños], [FrecuenciaPago], [DiasPorAño], [TipoTasaInteres], [Capitalizacion], [TasaInteresAnual], [TasaDescuentoAnual], [ImpuestoRenta], [FechaEmision], [FK_IDBonista], [FK_IDCostesIniciales], [FK_IDEmpresaEmisora]) VALUES (4, 360450.0000, 356000.0000, 4, N'Mensual', 360, N'Tasa Nominal', N'Semestral', 7.640625, 4.5, 30, CAST(N'2020-06-26' AS Date), 1, 1, 1)
INSERT [dbo].[BonoContrato] ([IDBonoContrato], [ValorComercial], [ValorNominal], [NroAños], [FrecuenciaPago], [DiasPorAño], [TipoTasaInteres], [Capitalizacion], [TasaInteresAnual], [TasaDescuentoAnual], [ImpuestoRenta], [FechaEmision], [FK_IDBonista], [FK_IDCostesIniciales], [FK_IDEmpresaEmisora]) VALUES (5, 360450.0000, 356000.0000, 4, N'Mensual', 360, N'Tasa Nominal', N'Semestral', 7.640625, 4.5, 30, CAST(N'2020-06-28' AS Date), 1, 1, 1)
SET IDENTITY_INSERT [dbo].[BonoContrato] OFF
SET IDENTITY_INSERT [dbo].[CostesIniciales] ON 

INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (1, 1, 0.5, 0.5, 0.45, 0.5)
INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (2, 1, 0.5, 0.5, 0.45, 0.5)
INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (3, 1, 0.5, 0.5, 0.45, 0.5)
INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (4, 1, 0.5, 0.5, 0.45, 0.5)
INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (5, 1, 0.5, 0.5, 0.45, 0.5)
INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (6, 1, 0.5, 0.5, 0.45, 0.5)
INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (7, 1, 0.5, 0.5, 0.45, 0.5)
INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (8, 1, 0.5, 0.5, 0.45, 0.5)
INSERT [dbo].[CostesIniciales] ([IDCostesIniciales], [PorcPrima], [PorcEstructuracion], [PorcColocacion], [PorcFlotacion], [PorcCAVALI]) VALUES (9, 1, 0.5, 0.5, 0.45, 0.5)
SET IDENTITY_INSERT [dbo].[CostesIniciales] OFF
SET IDENTITY_INSERT [dbo].[EmpresaEmisora] ON 

INSERT [dbo].[EmpresaEmisora] ([IDEmpresaEmisora], [Nombre], [RUC], [SedePrincipal], [Rubro], [FK_IDAgenteExterno]) VALUES (1, N'Alicorp', N'20100055237', N'Av. Argentina 4793 , Callao', N'Empresa de consumo masivo', 6)
SET IDENTITY_INSERT [dbo].[EmpresaEmisora] OFF
SET IDENTITY_INSERT [dbo].[FlujoPeriodico] ON 

INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (1, 356000.0000, 356000.0000, -2191.0100, -9607.6800, -7416.6700, 0.0000, 657.3000, -9607.6800, -8950.3700, 9607.6800, 368200.9600, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (2, 348583.3300, 348583.3300, -2145.3600, -9562.0300, -7416.6700, 0.0000, 643.6100, -9562.0300, -8918.4200, 9562.0300, 359992.0000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (3, 341166.6700, 341166.6700, -2099.7200, -9516.3800, -7416.6700, 0.0000, 629.9200, -9516.3800, -8886.4700, 9516.3800, 351798.5200, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (4, 333750.0000, 333750.0000, -2054.0700, -9470.7400, -7416.6700, 0.0000, 616.2200, -9470.7400, -8854.5200, 9470.7400, 343620.5700, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (5, 326333.3300, 326333.3300, -2008.4300, -9425.0900, -7416.6700, 0.0000, 602.5300, -9425.0900, -8822.5600, 9425.0900, 335458.2200, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (6, 318916.6700, 318916.6700, -1962.7800, -9379.4500, -7416.6700, 0.0000, 588.8300, -9379.4500, -8790.6100, 9379.4500, 327311.5200, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (7, 311500.0000, 311500.0000, -1917.1300, -9333.8000, -7416.6700, 0.0000, 575.1400, -9333.8000, -8758.6600, 9333.8000, 319180.5300, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (8, 304083.3300, 304083.3300, -1871.4900, -9288.1500, -7416.6700, 0.0000, 561.4500, -9288.1500, -8726.7100, 9288.1500, 311065.3000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (9, 296666.6700, 296666.6700, -1825.8400, -9242.5100, -7416.6700, 0.0000, 547.7500, -9242.5100, -8694.7600, 9242.5100, 302965.9000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (10, 289250.0000, 289250.0000, -1780.1900, -9196.8600, -7416.6700, 0.0000, 534.0600, -9196.8600, -8662.8000, 9196.8600, 294882.3800, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (11, 281833.3300, 281833.3300, -1734.5500, -9151.2200, -7416.6700, 0.0000, 520.3600, -9151.2200, -8630.8500, 9151.2200, 286814.8000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (12, 274416.6700, 274416.6700, -1688.9000, -9105.5700, -7416.6700, 0.0000, 506.6700, -9105.5700, -8598.9000, 9105.5700, 278763.2200, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (13, 267000.0000, 267000.0000, -1643.2600, -9059.9200, -7416.6700, 0.0000, 492.9800, -9059.9200, -8566.9500, 9059.9200, 270727.7000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (14, 259583.3300, 259583.3300, -1597.6100, -9014.2800, -7416.6700, 0.0000, 479.2800, -9014.2800, -8534.9900, 9014.2800, 262708.3000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (15, 252166.6700, 252166.6700, -1551.9600, -8968.6300, -7416.6700, 0.0000, 465.5900, -8968.6300, -8503.0400, 8968.6300, 254705.0700, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (16, 244750.0000, 244750.0000, -1506.3200, -8922.9900, -7416.6700, 0.0000, 451.9000, -8922.9900, -8471.0900, 8922.9900, 246718.0700, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (17, 237333.3300, 237333.3300, -1460.6700, -8877.3400, -7416.6700, 0.0000, 438.2000, -8877.3400, -8439.1400, 8877.3400, 238747.3800, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (18, 229916.6700, 229916.6700, -1415.0300, -8831.6900, -7416.6700, 0.0000, 424.5100, -8831.6900, -8407.1900, 8831.6900, 230793.0400, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (19, 222500.0000, 222500.0000, -1369.3800, -8786.0500, -7416.6700, 0.0000, 410.8100, -8786.0500, -8375.2300, 8786.0500, 222855.1100, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (20, 215083.3300, 215083.3300, -1323.7300, -8740.4000, -7416.6700, 0.0000, 397.1200, -8740.4000, -8343.2800, 8740.4000, 214933.6600, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (21, 207666.6700, 207666.6700, -1278.0900, -8694.7600, -7416.6700, 0.0000, 383.4300, -8694.7600, -8311.3300, 8694.7600, 207028.7400, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (22, 200250.0000, 200250.0000, -1232.4400, -8649.1100, -7416.6700, 0.0000, 369.7300, -8649.1100, -8279.3800, 8649.1100, 199140.4200, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (23, 192833.3300, 192833.3300, -1186.8000, -8603.4600, -7416.6700, 0.0000, 356.0400, -8603.4600, -8247.4200, 8603.4600, 191268.7600, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (24, 185416.6700, 185416.6700, -1141.1500, -8557.8200, -7416.6700, 0.0000, 342.3500, -8557.8200, -8215.4700, 8557.8200, 183413.8200, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (25, 178000.0000, 178000.0000, -1095.5000, -8512.1700, -7416.6700, 0.0000, 328.6500, -8512.1700, -8183.5200, 8512.1700, 175575.6600, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (26, 170583.3300, 170583.3300, -1049.8600, -8466.5300, -7416.6700, 0.0000, 314.9600, -8466.5300, -8151.5700, 8466.5300, 167754.3500, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (27, 163166.6700, 163166.6700, -1004.2100, -8420.8800, -7416.6700, 0.0000, 301.2600, -8420.8800, -8119.6200, 8420.8800, 159949.9300, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (28, 155750.0000, 155750.0000, -958.5700, -8375.2300, -7416.6700, 0.0000, 287.5700, -8375.2300, -8087.6600, 8375.2300, 152162.4800, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (29, 148333.3300, 148333.3300, -912.9200, -8329.5900, -7416.6700, 0.0000, 273.8800, -8329.5900, -8055.7100, 8329.5900, 144392.0600, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (30, 140916.6700, 140916.6700, -867.2700, -8283.9400, -7416.6700, 0.0000, 260.1800, -8283.9400, -8023.7600, 8283.9400, 136638.7400, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (31, 133500.0000, 133500.0000, -821.6300, -8238.3000, -7416.6700, 0.0000, 246.4900, -8238.3000, -7991.8100, 8238.3000, 128902.5600, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (32, 126083.3300, 126083.3300, -775.9800, -8192.6500, -7416.6700, 0.0000, 232.7900, -8192.6500, -7959.8500, 8192.6500, 121183.6100, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (33, 118666.6700, 118666.6700, -730.3400, -8147.0000, -7416.6700, 0.0000, 219.1000, -8147.0000, -7927.9000, 8147.0000, 113481.9300, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (34, 111250.0000, 111250.0000, -684.6900, -8101.3600, -7416.6700, 0.0000, 205.4100, -8101.3600, -7895.9500, 8101.3600, 105797.6000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (35, 103833.3300, 103833.3300, -639.0400, -8055.7100, -7416.6700, 0.0000, 191.7100, -8055.7100, -7864.0000, 8055.7100, 98130.6700, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (36, 96416.6700, 96416.6700, -593.4000, -8010.0600, -7416.6700, 0.0000, 178.0200, -8010.0600, -7832.0500, 8010.0600, 90481.2200, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (37, 89000.0000, 89000.0000, -547.7500, -7964.4200, -7416.6700, 0.0000, 164.3300, -7964.4200, -7800.0900, 7964.4200, 82849.3000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (38, 81583.3300, 81583.3300, -502.1100, -7918.7700, -7416.6700, 0.0000, 150.6300, -7918.7700, -7768.1400, 7918.7700, 75234.9800, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (39, 74166.6700, 74166.6700, -456.4600, -7873.1300, -7416.6700, 0.0000, 136.9400, -7873.1300, -7736.1900, 7873.1300, 67638.3300, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (40, 66750.0000, 66750.0000, -410.8100, -7827.4800, -7416.6700, 0.0000, 123.2400, -7827.4800, -7704.2400, 7827.4800, 60059.4100, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (41, 59333.3300, 59333.3300, -365.1700, -7781.8300, -7416.6700, 0.0000, 109.5500, -7781.8300, -7672.2800, 7781.8300, 52498.2800, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (42, 51916.6700, 51916.6700, -319.5200, -7736.1900, -7416.6700, 0.0000, 95.8600, -7736.1900, -7640.3300, 7736.1900, 44955.0100, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (43, 44500.0000, 44500.0000, -273.8800, -7690.5400, -7416.6700, 0.0000, 82.1600, -7690.5400, -7608.3800, 7690.5400, 37429.6700, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (44, 37083.3300, 37083.3300, -228.2300, -7644.9000, -7416.6700, 0.0000, 68.4700, -7644.9000, -7576.4300, 7644.9000, 29922.3200, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (45, 29666.6700, 29666.6700, -182.5800, -7599.2500, -7416.6700, 0.0000, 54.7800, -7599.2500, -7544.4800, 7599.2500, 22433.0300, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (46, 22250.0000, 22250.0000, -136.9400, -7553.6000, -7416.6700, 0.0000, 41.0800, -7553.6000, -7512.5200, 7553.6000, 14961.8600, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (47, 14833.3300, 14833.3300, -91.2900, -7507.9600, -7416.6700, 0.0000, 27.3900, -7507.9600, -7480.5700, 7507.9600, 7508.8900, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (48, 7416.6700, 7416.6700, -45.6500, -7462.3100, -7416.6700, -74.1700, 13.6900, -7536.4800, -7522.7900, 7536.4800, 0.0000, 1)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (49, 1416000.0000, 1416000.0000, -106200.0000, -422771.5900, -316571.5900, 0.0000, 31860.0000, -422771.5900, -390911.5900, 422771.5900, 1165630.3000, 2)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (50, 1099428.4100, 1099428.4100, -82457.1300, -422771.5900, -340314.4600, 0.0000, 24737.1400, -422771.5900, -398034.4500, 422771.5900, 795312.0700, 2)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (51, 759113.9500, 759113.9500, -56933.5500, -422771.5900, -365838.0500, 0.0000, 17080.0600, -422771.5900, -405691.5300, 422771.5900, 408329.5200, 2)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (52, 393275.9000, 393275.9000, -29495.6900, -422771.5900, -393275.9000, -3932.7600, 8848.7100, -426704.3500, -417855.6400, 426704.3500, 0.0000, 2)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (53, 222500.0000, 222500.0000, -9400.6200, -9400.6200, 0.0000, 0.0000, 2820.1900, -9400.6200, -6580.4400, 9400.6200, 245329.1000, 3)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (54, 222500.0000, 222500.0000, -9400.6200, -9400.6200, 0.0000, 0.0000, 2820.1900, -9400.6200, -6580.4400, 9400.6200, 241387.6400, 3)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (55, 222500.0000, 222500.0000, -9400.6200, -9400.6200, 0.0000, 0.0000, 2820.1900, -9400.6200, -6580.4400, 9400.6200, 237358.4700, 3)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (56, 222500.0000, 222500.0000, -9400.6200, -9400.6200, 0.0000, 0.0000, 2820.1900, -9400.6200, -6580.4400, 9400.6200, 233239.6500, 3)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (57, 222500.0000, 222500.0000, -9400.6200, -9400.6200, 0.0000, 0.0000, 2820.1900, -9400.6200, -6580.4400, 9400.6200, 229029.1700, 3)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (58, 222500.0000, 222500.0000, -9400.6200, -231900.6200, -222500.0000, -2225.0000, 2820.1900, -234125.6200, -231305.4400, 234125.6200, 0.0000, 3)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (59, 356000.0000, 356000.0000, -2191.0100, -9607.6800, -7416.6700, 0.0000, 657.3000, -9607.6800, -8950.3700, 9607.6800, 368200.9600, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (60, 348583.3300, 348583.3300, -2145.3600, -9562.0300, -7416.6700, 0.0000, 643.6100, -9562.0300, -8918.4200, 9562.0300, 359992.0000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (61, 341166.6700, 341166.6700, -2099.7200, -9516.3800, -7416.6700, 0.0000, 629.9200, -9516.3800, -8886.4700, 9516.3800, 351798.5200, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (62, 333750.0000, 333750.0000, -2054.0700, -9470.7400, -7416.6700, 0.0000, 616.2200, -9470.7400, -8854.5200, 9470.7400, 343620.5700, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (63, 326333.3300, 326333.3300, -2008.4300, -9425.0900, -7416.6700, 0.0000, 602.5300, -9425.0900, -8822.5600, 9425.0900, 335458.2200, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (64, 318916.6700, 318916.6700, -1962.7800, -9379.4500, -7416.6700, 0.0000, 588.8300, -9379.4500, -8790.6100, 9379.4500, 327311.5200, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (65, 311500.0000, 311500.0000, -1917.1300, -9333.8000, -7416.6700, 0.0000, 575.1400, -9333.8000, -8758.6600, 9333.8000, 319180.5300, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (66, 304083.3300, 304083.3300, -1871.4900, -9288.1500, -7416.6700, 0.0000, 561.4500, -9288.1500, -8726.7100, 9288.1500, 311065.3000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (67, 296666.6700, 296666.6700, -1825.8400, -9242.5100, -7416.6700, 0.0000, 547.7500, -9242.5100, -8694.7600, 9242.5100, 302965.9000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (68, 289250.0000, 289250.0000, -1780.1900, -9196.8600, -7416.6700, 0.0000, 534.0600, -9196.8600, -8662.8000, 9196.8600, 294882.3800, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (69, 281833.3300, 281833.3300, -1734.5500, -9151.2200, -7416.6700, 0.0000, 520.3600, -9151.2200, -8630.8500, 9151.2200, 286814.8000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (70, 274416.6700, 274416.6700, -1688.9000, -9105.5700, -7416.6700, 0.0000, 506.6700, -9105.5700, -8598.9000, 9105.5700, 278763.2200, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (71, 267000.0000, 267000.0000, -1643.2600, -9059.9200, -7416.6700, 0.0000, 492.9800, -9059.9200, -8566.9500, 9059.9200, 270727.7000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (72, 259583.3300, 259583.3300, -1597.6100, -9014.2800, -7416.6700, 0.0000, 479.2800, -9014.2800, -8534.9900, 9014.2800, 262708.3000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (73, 252166.6700, 252166.6700, -1551.9600, -8968.6300, -7416.6700, 0.0000, 465.5900, -8968.6300, -8503.0400, 8968.6300, 254705.0700, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (74, 244750.0000, 244750.0000, -1506.3200, -8922.9900, -7416.6700, 0.0000, 451.9000, -8922.9900, -8471.0900, 8922.9900, 246718.0700, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (75, 237333.3300, 237333.3300, -1460.6700, -8877.3400, -7416.6700, 0.0000, 438.2000, -8877.3400, -8439.1400, 8877.3400, 238747.3800, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (76, 229916.6700, 229916.6700, -1415.0300, -8831.6900, -7416.6700, 0.0000, 424.5100, -8831.6900, -8407.1900, 8831.6900, 230793.0400, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (77, 222500.0000, 222500.0000, -1369.3800, -8786.0500, -7416.6700, 0.0000, 410.8100, -8786.0500, -8375.2300, 8786.0500, 222855.1100, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (78, 215083.3300, 215083.3300, -1323.7300, -8740.4000, -7416.6700, 0.0000, 397.1200, -8740.4000, -8343.2800, 8740.4000, 214933.6600, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (79, 207666.6700, 207666.6700, -1278.0900, -8694.7600, -7416.6700, 0.0000, 383.4300, -8694.7600, -8311.3300, 8694.7600, 207028.7400, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (80, 200250.0000, 200250.0000, -1232.4400, -8649.1100, -7416.6700, 0.0000, 369.7300, -8649.1100, -8279.3800, 8649.1100, 199140.4200, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (81, 192833.3300, 192833.3300, -1186.8000, -8603.4600, -7416.6700, 0.0000, 356.0400, -8603.4600, -8247.4200, 8603.4600, 191268.7600, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (82, 185416.6700, 185416.6700, -1141.1500, -8557.8200, -7416.6700, 0.0000, 342.3500, -8557.8200, -8215.4700, 8557.8200, 183413.8200, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (83, 178000.0000, 178000.0000, -1095.5000, -8512.1700, -7416.6700, 0.0000, 328.6500, -8512.1700, -8183.5200, 8512.1700, 175575.6600, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (84, 170583.3300, 170583.3300, -1049.8600, -8466.5300, -7416.6700, 0.0000, 314.9600, -8466.5300, -8151.5700, 8466.5300, 167754.3500, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (85, 163166.6700, 163166.6700, -1004.2100, -8420.8800, -7416.6700, 0.0000, 301.2600, -8420.8800, -8119.6200, 8420.8800, 159949.9300, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (86, 155750.0000, 155750.0000, -958.5700, -8375.2300, -7416.6700, 0.0000, 287.5700, -8375.2300, -8087.6600, 8375.2300, 152162.4800, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (87, 148333.3300, 148333.3300, -912.9200, -8329.5900, -7416.6700, 0.0000, 273.8800, -8329.5900, -8055.7100, 8329.5900, 144392.0600, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (88, 140916.6700, 140916.6700, -867.2700, -8283.9400, -7416.6700, 0.0000, 260.1800, -8283.9400, -8023.7600, 8283.9400, 136638.7400, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (89, 133500.0000, 133500.0000, -821.6300, -8238.3000, -7416.6700, 0.0000, 246.4900, -8238.3000, -7991.8100, 8238.3000, 128902.5600, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (90, 126083.3300, 126083.3300, -775.9800, -8192.6500, -7416.6700, 0.0000, 232.7900, -8192.6500, -7959.8500, 8192.6500, 121183.6100, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (91, 118666.6700, 118666.6700, -730.3400, -8147.0000, -7416.6700, 0.0000, 219.1000, -8147.0000, -7927.9000, 8147.0000, 113481.9300, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (92, 111250.0000, 111250.0000, -684.6900, -8101.3600, -7416.6700, 0.0000, 205.4100, -8101.3600, -7895.9500, 8101.3600, 105797.6000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (93, 103833.3300, 103833.3300, -639.0400, -8055.7100, -7416.6700, 0.0000, 191.7100, -8055.7100, -7864.0000, 8055.7100, 98130.6700, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (94, 96416.6700, 96416.6700, -593.4000, -8010.0600, -7416.6700, 0.0000, 178.0200, -8010.0600, -7832.0500, 8010.0600, 90481.2200, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (95, 89000.0000, 89000.0000, -547.7500, -7964.4200, -7416.6700, 0.0000, 164.3300, -7964.4200, -7800.0900, 7964.4200, 82849.3000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (96, 81583.3300, 81583.3300, -502.1100, -7918.7700, -7416.6700, 0.0000, 150.6300, -7918.7700, -7768.1400, 7918.7700, 75234.9800, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (97, 74166.6700, 74166.6700, -456.4600, -7873.1300, -7416.6700, 0.0000, 136.9400, -7873.1300, -7736.1900, 7873.1300, 67638.3300, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (98, 66750.0000, 66750.0000, -410.8100, -7827.4800, -7416.6700, 0.0000, 123.2400, -7827.4800, -7704.2400, 7827.4800, 60059.4100, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (99, 59333.3300, 59333.3300, -365.1700, -7781.8300, -7416.6700, 0.0000, 109.5500, -7781.8300, -7672.2800, 7781.8300, 52498.2800, 4)
GO
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (100, 51916.6700, 51916.6700, -319.5200, -7736.1900, -7416.6700, 0.0000, 95.8600, -7736.1900, -7640.3300, 7736.1900, 44955.0100, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (101, 44500.0000, 44500.0000, -273.8800, -7690.5400, -7416.6700, 0.0000, 82.1600, -7690.5400, -7608.3800, 7690.5400, 37429.6700, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (102, 37083.3300, 37083.3300, -228.2300, -7644.9000, -7416.6700, 0.0000, 68.4700, -7644.9000, -7576.4300, 7644.9000, 29922.3200, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (103, 29666.6700, 29666.6700, -182.5800, -7599.2500, -7416.6700, 0.0000, 54.7800, -7599.2500, -7544.4800, 7599.2500, 22433.0300, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (104, 22250.0000, 22250.0000, -136.9400, -7553.6000, -7416.6700, 0.0000, 41.0800, -7553.6000, -7512.5200, 7553.6000, 14961.8600, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (105, 14833.3300, 14833.3300, -91.2900, -7507.9600, -7416.6700, 0.0000, 27.3900, -7507.9600, -7480.5700, 7507.9600, 7508.8900, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (106, 7416.6700, 7416.6700, -45.6500, -7462.3100, -7416.6700, -74.1700, 13.6900, -7536.4800, -7522.7900, 7536.4800, 0.0000, 4)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (107, 356000.0000, 356000.0000, -2191.0100, -8588.6700, -6397.6600, 0.0000, 657.3000, -8588.6700, -7931.3600, 8588.6700, 370179.8300, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (108, 349602.3400, 349602.3400, -2151.6300, -8588.6700, -6437.0300, 0.0000, 645.4900, -8588.6700, -7943.1800, 8588.6700, 362951.5100, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (109, 343165.3100, 343165.3100, -2112.0200, -8588.6700, -6476.6500, 0.0000, 633.6100, -8588.6700, -7955.0600, 8588.6700, 355696.6200, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (110, 336688.6600, 336688.6600, -2072.1600, -8588.6700, -6516.5100, 0.0000, 621.6500, -8588.6700, -7967.0200, 8588.6700, 348415.0700, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (111, 330172.1500, 330172.1500, -2032.0500, -8588.6700, -6556.6200, 0.0000, 609.6200, -8588.6700, -7979.0500, 8588.6700, 341106.7600, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (112, 323615.5400, 323615.5400, -1991.7000, -8588.6700, -6596.9700, 0.0000, 597.5100, -8588.6700, -7991.1600, 8588.6700, 333771.6000, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (113, 317018.5700, 317018.5700, -1951.1000, -8588.6700, -6637.5700, 0.0000, 585.3300, -8588.6700, -8003.3400, 8588.6700, 326409.4800, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (114, 310381.0000, 310381.0000, -1910.2500, -8588.6700, -6678.4200, 0.0000, 573.0700, -8588.6700, -8015.5900, 8588.6700, 319020.3100, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (115, 303702.5800, 303702.5800, -1869.1400, -8588.6700, -6719.5200, 0.0000, 560.7400, -8588.6700, -8027.9200, 8588.6700, 311603.9800, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (116, 296983.0600, 296983.0600, -1827.7900, -8588.6700, -6760.8800, 0.0000, 548.3400, -8588.6700, -8040.3300, 8588.6700, 304160.4000, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (117, 290222.1800, 290222.1800, -1786.1800, -8588.6700, -6802.4900, 0.0000, 535.8500, -8588.6700, -8052.8100, 8588.6700, 296689.4600, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (118, 283419.6900, 283419.6900, -1744.3100, -8588.6700, -6844.3500, 0.0000, 523.2900, -8588.6700, -8065.3700, 8588.6700, 289191.0700, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (119, 276575.3400, 276575.3400, -1702.1900, -8588.6700, -6886.4800, 0.0000, 510.6600, -8588.6700, -8078.0100, 8588.6700, 281665.1300, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (120, 269688.8600, 269688.8600, -1659.8100, -8588.6700, -6928.8600, 0.0000, 497.9400, -8588.6700, -8090.7200, 8588.6700, 274111.5300, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (121, 262760.0000, 262760.0000, -1617.1600, -8588.6700, -6971.5000, 0.0000, 485.1500, -8588.6700, -8103.5200, 8588.6700, 266530.1700, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (122, 255788.4900, 255788.4900, -1574.2600, -8588.6700, -7014.4100, 0.0000, 472.2800, -8588.6700, -8116.3900, 8588.6700, 258920.9500, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (123, 248774.0800, 248774.0800, -1531.0900, -8588.6700, -7057.5800, 0.0000, 459.3300, -8588.6700, -8129.3400, 8588.6700, 251283.7700, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (124, 241716.5000, 241716.5000, -1487.6500, -8588.6700, -7101.0200, 0.0000, 446.2900, -8588.6700, -8142.3700, 8588.6700, 243618.5200, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (125, 234615.4800, 234615.4800, -1443.9500, -8588.6700, -7144.7200, 0.0000, 433.1800, -8588.6700, -8155.4800, 8588.6700, 235925.1100, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (126, 227470.7600, 227470.7600, -1399.9700, -8588.6700, -7188.6900, 0.0000, 419.9900, -8588.6700, -8168.6700, 8588.6700, 228203.4200, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (127, 220282.0700, 220282.0700, -1355.7300, -8588.6700, -7232.9400, 0.0000, 406.7200, -8588.6700, -8181.9500, 8588.6700, 220453.3600, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (128, 213049.1300, 213049.1300, -1311.2200, -8588.6700, -7277.4500, 0.0000, 393.3600, -8588.6700, -8195.3000, 8588.6700, 212674.8200, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (129, 205771.6800, 205771.6800, -1266.4300, -8588.6700, -7322.2400, 0.0000, 379.9300, -8588.6700, -8208.7400, 8588.6700, 204867.6900, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (130, 198449.4400, 198449.4400, -1221.3600, -8588.6700, -7367.3100, 0.0000, 366.4100, -8588.6700, -8222.2600, 8588.6700, 197031.8800, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (131, 191082.1300, 191082.1300, -1176.0200, -8588.6700, -7412.6500, 0.0000, 352.8100, -8588.6700, -8235.8600, 8588.6700, 189167.2600, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (132, 183669.4900, 183669.4900, -1130.4000, -8588.6700, -7458.2700, 0.0000, 339.1200, -8588.6700, -8249.5500, 8588.6700, 181273.7500, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (133, 176211.2200, 176211.2200, -1084.5000, -8588.6700, -7504.1700, 0.0000, 325.3500, -8588.6700, -8263.3200, 8588.6700, 173351.2300, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (134, 168707.0500, 168707.0500, -1038.3100, -8588.6700, -7550.3600, 0.0000, 311.4900, -8588.6700, -8277.1700, 8588.6700, 165399.6000, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (135, 161156.6900, 161156.6900, -991.8400, -8588.6700, -7596.8200, 0.0000, 297.5500, -8588.6700, -8291.1100, 8588.6700, 157418.7400, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (136, 153559.8700, 153559.8700, -945.0900, -8588.6700, -7643.5800, 0.0000, 283.5300, -8588.6700, -8305.1400, 8588.6700, 149408.5600, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (137, 145916.2900, 145916.2900, -898.0400, -8588.6700, -7690.6200, 0.0000, 269.4100, -8588.6700, -8319.2500, 8588.6700, 141368.9400, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (138, 138225.6700, 138225.6700, -850.7100, -8588.6700, -7737.9500, 0.0000, 255.2100, -8588.6700, -8333.4500, 8588.6700, 133299.7800, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (139, 130487.7100, 130487.7100, -803.0900, -8588.6700, -7785.5800, 0.0000, 240.9300, -8588.6700, -8347.7400, 8588.6700, 125200.9600, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (140, 122702.1400, 122702.1400, -755.1700, -8588.6700, -7833.4900, 0.0000, 226.5500, -8588.6700, -8362.1100, 8588.6700, 117072.3900, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (141, 114868.6400, 114868.6400, -706.9600, -8588.6700, -7881.7100, 0.0000, 212.0900, -8588.6700, -8376.5800, 8588.6700, 108913.9400, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (142, 106986.9400, 106986.9400, -658.4500, -8588.6700, -7930.2100, 0.0000, 197.5400, -8588.6700, -8391.1300, 8588.6700, 100725.5100, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (143, 99056.7200, 99056.7200, -609.6500, -8588.6700, -7979.0200, 0.0000, 182.8900, -8588.6700, -8405.7700, 8588.6700, 92506.9900, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (144, 91077.7000, 91077.7000, -560.5400, -8588.6700, -8028.1300, 0.0000, 168.1600, -8588.6700, -8420.5000, 8588.6700, 84258.2700, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (145, 83049.5800, 83049.5800, -511.1300, -8588.6700, -8077.5400, 0.0000, 153.3400, -8588.6700, -8435.3300, 8588.6700, 75979.2400, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (146, 74972.0400, 74972.0400, -461.4200, -8588.6700, -8127.2500, 0.0000, 138.4300, -8588.6700, -8450.2400, 8588.6700, 67669.7800, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (147, 66844.7900, 66844.7900, -411.4000, -8588.6700, -8177.2700, 0.0000, 123.4200, -8588.6700, -8465.2500, 8588.6700, 59329.7900, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (148, 58667.5200, 58667.5200, -361.0700, -8588.6700, -8227.6000, 0.0000, 108.3200, -8588.6700, -8480.3500, 8588.6700, 50959.1500, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (149, 50439.9300, 50439.9300, -310.4300, -8588.6700, -8278.2300, 0.0000, 93.1300, -8588.6700, -8495.5400, 8588.6700, 42557.7500, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (150, 42161.6900, 42161.6900, -259.4800, -8588.6700, -8329.1800, 0.0000, 77.8500, -8588.6700, -8510.8200, 8588.6700, 34125.4700, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (151, 33832.5100, 33832.5100, -208.2200, -8588.6700, -8380.4400, 0.0000, 62.4700, -8588.6700, -8526.2000, 8588.6700, 25662.2100, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (152, 25452.0700, 25452.0700, -156.6500, -8588.6700, -8432.0200, 0.0000, 46.9900, -8588.6700, -8541.6700, 8588.6700, 17167.8500, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (153, 17020.0500, 17020.0500, -104.7500, -8588.6700, -8483.9200, 0.0000, 31.4300, -8588.6700, -8557.2400, 8588.6700, 8642.2700, 5)
INSERT [dbo].[FlujoPeriodico] ([IDFlujoPeriodico], [Bono], [BonoIndexado], [Cupon], [Cuota], [Amortizacion], [Prima], [Escudo], [FlujoEmisor], [FlujoEmisorEscudo], [FlujoBonista], [ValorBonoDCP], [FK_IDBonoContrato]) VALUES (154, 8536.1300, 8536.1300, -52.5400, -8588.6700, -8536.1300, -85.3600, 15.7600, -8674.0300, -8658.2700, 8674.0300, 0.0000, 5)
SET IDENTITY_INSERT [dbo].[FlujoPeriodico] OFF
SET IDENTITY_INSERT [dbo].[TipoUsuario] ON 

INSERT [dbo].[TipoUsuario] ([IDTipoUsuario], [TipoPersona]) VALUES (1, N'Administrator')
INSERT [dbo].[TipoUsuario] ([IDTipoUsuario], [TipoPersona]) VALUES (2, N'Customer')
SET IDENTITY_INSERT [dbo].[TipoUsuario] OFF
SET IDENTITY_INSERT [dbo].[UsuarioBonista] ON 

INSERT [dbo].[UsuarioBonista] ([IDUsuarioBonista], [Nombres], [Apellidos], [Correo], [Contraseña], [RUC], [IDTipoUsuario]) VALUES (1, N'Victor Green JAJA', N'Pachari Vega', N'pachve_05@outlook.com', N'12', N'20350457161', 2)
SET IDENTITY_INSERT [dbo].[UsuarioBonista] OFF
ALTER TABLE [dbo].[BonoContrato]  WITH CHECK ADD  CONSTRAINT [FK_BonoContrato_CostesIniciales] FOREIGN KEY([FK_IDCostesIniciales])
REFERENCES [dbo].[CostesIniciales] ([IDCostesIniciales])
GO
ALTER TABLE [dbo].[BonoContrato] CHECK CONSTRAINT [FK_BonoContrato_CostesIniciales]
GO
ALTER TABLE [dbo].[BonoContrato]  WITH CHECK ADD  CONSTRAINT [FK_BonoContrato_EmpresaEmisora] FOREIGN KEY([FK_IDEmpresaEmisora])
REFERENCES [dbo].[EmpresaEmisora] ([IDEmpresaEmisora])
GO
ALTER TABLE [dbo].[BonoContrato] CHECK CONSTRAINT [FK_BonoContrato_EmpresaEmisora]
GO
ALTER TABLE [dbo].[BonoContrato]  WITH CHECK ADD  CONSTRAINT [FK_BonoContrato_UsuarioBonista] FOREIGN KEY([FK_IDBonista])
REFERENCES [dbo].[UsuarioBonista] ([IDUsuarioBonista])
GO
ALTER TABLE [dbo].[BonoContrato] CHECK CONSTRAINT [FK_BonoContrato_UsuarioBonista]
GO
ALTER TABLE [dbo].[EmpresaEmisora]  WITH CHECK ADD  CONSTRAINT [FK_AgenteExterno_EmpresaEmisora] FOREIGN KEY([FK_IDAgenteExterno])
REFERENCES [dbo].[AgenteExterno] ([IDAgenteExterno])
GO
ALTER TABLE [dbo].[EmpresaEmisora] CHECK CONSTRAINT [FK_AgenteExterno_EmpresaEmisora]
GO
ALTER TABLE [dbo].[FlujoPeriodico]  WITH CHECK ADD  CONSTRAINT [FK_FlujoPeriodico_BonoContrato] FOREIGN KEY([FK_IDBonoContrato])
REFERENCES [dbo].[BonoContrato] ([IDBonoContrato])
GO
ALTER TABLE [dbo].[FlujoPeriodico] CHECK CONSTRAINT [FK_FlujoPeriodico_BonoContrato]
GO
ALTER TABLE [dbo].[UsuarioBonista]  WITH CHECK ADD  CONSTRAINT [FK_TipoUsuario_UsuarioBonista] FOREIGN KEY([IDTipoUsuario])
REFERENCES [dbo].[TipoUsuario] ([IDTipoUsuario])
GO
ALTER TABLE [dbo].[UsuarioBonista] CHECK CONSTRAINT [FK_TipoUsuario_UsuarioBonista]
GO
USE [master]
GO
ALTER DATABASE [FinanceYourLife] SET  READ_WRITE 
GO
