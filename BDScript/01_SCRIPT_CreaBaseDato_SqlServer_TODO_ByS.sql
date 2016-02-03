/* MODULO DE PRESUPUESTO para prueba :*/
USE [master]
GO

CREATE DATABASE [BD_ByS] ON  
PRIMARY 
(	NAME		= N'BoticaSalud_Primary', 
	FILENAME	= N'H:\UPC_TP3\BD_TP3\BD_BoticaSalud_Primary2.mdf' , 
	SIZE		= 20MB , 
	MAXSIZE		= 150MB, 
	FILEGROWTH	= 10%
), 
FILEGROUP [DATABASE01] 
(	NAME		= N'BoticaSalud_Data', 
    FILENAME	= N'H:\UPC_TP3\BD_TP3\BD_BoticaSalud_Data2.ndf' ,
  	SIZE		= 50MB , 
	MAXSIZE		= 800MB,
	FILEGROWTH	= 10%
), 
FILEGROUP [INDICES] 
(	NAME		= N'BoticaSalud_Index', 
    FILENAME	= N'H:\UPC_TP3\BD_TP3\BD_Botica_Index2.ndf' , 
  	SIZE		= 50MB , 
	MAXSIZE		= 500MB,
	FILEGROWTH	= 10%
), 
FILEGROUP [MULTIMEDIA] 
(	NAME		= N'BoticaSalud_Multimedia', 
    FILENAME	= N'H:\UPC_TP3\BD_TP3\BD_BoticaS_Multimedia2.ndf' , 
  	SIZE		= 15MB , 
	MAXSIZE		= 200MB, 
	FILEGROWTH	= 10%
), 
FILEGROUP [HISTORIA] 
(
    NAME		= N'BoticaSalud_Historia',
    FILENAME	= 'H:\UPC_TP3\BD_TP3\BD_BoticaS_Historiaz2.ndf',
    SIZE		= 15MB,
    MAXSIZE		= 300MB,
    FILEGROWTH	= 15MB
)
LOG ON 
(	NAME		= N'BoticaSalud_Logs', 
    FILENAME	= N'H:\UPC_TP3\BD_TP3\BD_BoticaS_Logs2.ldf' , 
  	SIZE		= 5MB, 
	MAXSIZE		= 200MB , 
	FILEGROWTH	= 5%
)
GO

-- CREACION DE TABLAS
USE BD_ByS
GO

CREATE SCHEMA Presupuesto
GO

CREATE SCHEMA RecursosHumanos
GO

CREATE SCHEMA Maestros
GO

CREATE SCHEMA Trazabilidad
GO

/***************************************************************************************
* CREACION DE LA TABLA : RecursosHumanos.Area
* Tabla para almacenar los nombres de las cuales Areas
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'RecursosHumanos.Area') AND type in (N'U'))
BEGIN
CREATE TABLE RecursosHumanos.Area
(
  codArea			INTEGER        IDENTITY(1,1) NOT NULL,
  desNombre         VARCHAR(40)    NOT NULL,
  gloDescripcion    VARCHAR(10)	   NOT NULL,
  
  indActivo         BIT       	   NOT NULL CONSTRAINT DEF_Area_indActivo	  DEFAULT (1),
  segUsuarioCrea    VARCHAR(25)    NOT NULL CONSTRAINT DEF_Area_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   VARCHAR(25)    NULL,
  segFechaCrea      DATETIME       NOT NULL CONSTRAINT DEF_Area_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     DATETIME       NULL,
  segMaquinaOrigen  VARCHAR(25)    NOT NULL CONSTRAINT DEF_Area_segMaquina	  DEFAULT (host_name()),
  indEliminado      BIT			   NOT NULL CONSTRAINT DEF_Area_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_Area_codArea PRIMARY KEY CLUSTERED 
	(
		codArea ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : RecursosHumanos.Cargo
* Tabla para almacenar los nombres de las cuales Cargos
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'RecursosHumanos.Cargo') AND type in (N'U'))
BEGIN
CREATE TABLE RecursosHumanos.Cargo
(
  codCargo	        INTEGER        IDENTITY(1,1) NOT NULL,
  desNombre         VARCHAR(40)    NOT NULL,
  gloDescripcion    VARCHAR(10)   NOT NULL,
  
  indActivo         BIT       	   NOT NULL CONSTRAINT DEF_Cargo_indActivo	  DEFAULT (1),
  segUsuarioCrea    VARCHAR(25)    NOT NULL CONSTRAINT DEF_Cargo_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   VARCHAR(25)    NULL,
  segFechaCrea      DATETIME       NOT NULL CONSTRAINT DEF_Cargo_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     DATETIME       NULL,
  segMaquinaOrigen  VARCHAR(25)    NOT NULL CONSTRAINT DEF_Cargo_segMaquina	  DEFAULT (host_name()),
  indEliminado      BIT			   NOT NULL CONSTRAINT DEF_Cargo_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_Area_codCargo PRIMARY KEY CLUSTERED 
	(
		codCargo ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : RecursosHumanos.Cargo
* Tabla para almacenar los nombres de las Empleados
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'RecursosHumanos.Empleado') AND type in (N'U'))
BEGIN
CREATE TABLE RecursosHumanos.Empleado
(
  codEmpleado		int IDENTITY(1,1) NOT NULL,
  codPersona		int				NOT NULL,
  codCargo			int				NOT NULL,
  codArea			int				NOT NULL,
  desNombre			VARCHAR(40)		NOT NULL,
  desApellido		VARCHAR(40)		NOT NULL,
  indActivo         BIT       	   NOT NULL CONSTRAINT DEF_Empleado_indActivo	  DEFAULT (1),
  segUsuarioCrea    VARCHAR(25)    NOT NULL CONSTRAINT DEF_Empleado_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   VARCHAR(25)    NULL,
  segFechaCrea      DATETIME       NOT NULL CONSTRAINT DEF_Empleado_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     DATETIME       NULL,
  segMaquinaOrigen  VARCHAR(25)    NOT NULL CONSTRAINT DEF_Empleado_segMaquina	  DEFAULT (host_name()),
  indEliminado      BIT			   NOT NULL CONSTRAINT DEF_Empleado_indEliminado	  DEFAULT (0),
  desLogin			VARCHAR(40)		NULL,
  clvPassword		VARCHAR(250)	NULL,
   CONSTRAINT PK_Empleado_codEmpleado PRIMARY KEY CLUSTERED 
	(
		codEmpleado ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO
  
/***************************************************************************************
* CREACION DE LA TABLA : Presupuesto.Gasto
* Tabla para almacenar los gastos reales de los presupuestos
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.Gasto') AND type in (N'U'))
BEGIN
CREATE TABLE Presupuesto.Gasto
(
  codGasto			int IDENTITY(1,1) NOT NULL,
  codPlantillaDeta	int				NOT NULL,
  monTotal			decimal(12,2)	NOT NULL,
  cntCantidad		decimal(10,2)	NOT NULL,
  numDocumento		nvarchar(16)	NOT NULL,
  gloObservacion	nvarchar(120)  NULL,
  fecGasto			datetime		NOT NULL,
  codEmpleadoResp	int				NOT NULL,
  indActivo         BIT       	   NOT NULL CONSTRAINT DEF_Gasto_indActivo	  DEFAULT (1),
  segUsuarioCrea    VARCHAR(25)    NOT NULL CONSTRAINT DEF_Gasto_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   VARCHAR(25)    NULL,
  segFechaCrea      DATETIME       NOT NULL CONSTRAINT DEF_Gasto_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     DATETIME       NULL,
  segMaquinaOrigen  VARCHAR(25)    NOT NULL CONSTRAINT DEF_Gasto_segMaquina	  DEFAULT (host_name()),
  indEliminado      BIT			   NOT NULL CONSTRAINT DEF_Gasto_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_Gasto_codGasto PRIMARY KEY CLUSTERED 
	(
		codGasto ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Presupuesto.Partida
* Tabla para almacenar los Partidas de los presupuestos
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.Partida') AND type in (N'U'))
BEGIN
CREATE TABLE Presupuesto.Partida
(
  codPartida	    int IDENTITY(1,1) NOT NULL,
  desNombre			nvarchar(60)    NOT NULL,
  codNumero			nvarchar(10)   NOT NULL,
  indActivo         BIT       	   NOT NULL CONSTRAINT DEF_Partida_indActivo	  DEFAULT (1),
  segUsuarioCrea    VARCHAR(25)    NOT NULL CONSTRAINT DEF_Partida_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   VARCHAR(25)    NULL,
  segFechaCrea      DATETIME       NOT NULL CONSTRAINT DEF_Partida_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     DATETIME       NULL,
  segMaquinaOrigen  VARCHAR(25)    NOT NULL CONSTRAINT DEF_Partida_segMaquina	  DEFAULT (host_name()),
  indEliminado      BIT			   NOT NULL CONSTRAINT DEF_Partida_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_Partida_codPartida PRIMARY KEY CLUSTERED 
	(
		codPartida ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Maestros.Persona
* Tabla para almacenar las Personas
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Maestros.Persona') AND type in (N'U'))
BEGIN
CREATE TABLE Maestros.Persona
(
  codPersona int    IDENTITY(1,1) NOT NULL,
  desRazonSocial    nvarchar(100)  NOT NULL,
  desComercial      nvarchar(100)  NULL,
  indActivo         BIT       	   NOT NULL CONSTRAINT DEF_Persona_indActivo	  DEFAULT (1),
  segUsuarioCrea    VARCHAR(25)    NOT NULL CONSTRAINT DEF_Persona_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   VARCHAR(25)    NULL,
  segFechaCrea      DATETIME       NOT NULL CONSTRAINT DEF_Persona_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     DATETIME       NULL,
  segMaquinaOrigen  VARCHAR(25)    NOT NULL CONSTRAINT DEF_Persona_segMaquina	  DEFAULT (host_name()),
  indEliminado      BIT		   NOT NULL CONSTRAINT DEF_Persona_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_Persona_codPersona PRIMARY KEY CLUSTERED 
	(
		codPersona ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

--alter table Presupuesto.Plantilla
--add numDiasExtemporaneo		int  NOT NULL CONSTRAINT DEF_Plantilla_numDiasExtemporaneo	  DEFAULT (0)

/***************************************************************************************
* CREACION DE LA TABLA : Presupuesto.Plantilla
* Tabla para almacenar los Plantilla de los presupuestos
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.Plantilla') AND type in (N'U'))
BEGIN
CREATE TABLE Presupuesto.Plantilla
(
  codPlantilla 				int IDENTITY(1,1) NOT NULL,
  numPlantilla 				nvarchar(10)  	NOT NULL,
  codRegEstado 				int  		NOT NULL,
  codArea 					int  NOT NULL,
  codPresupuesto			int  NOT NULL,
  codSolicitud			 	int  NOT NULL,
  codEmpleadoElabora 		int  NOT NULL,
  segUsuarioCrea    		VARCHAR(25)    NOT NULL CONSTRAINT DEF_Plantilla_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   		VARCHAR(25)    NULL,
  segFechaCrea      		DATETIME       NOT NULL CONSTRAINT DEF_Plantilla_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     		DATETIME       NULL,
  segMaquinaOrigen  		VARCHAR(25)    NOT NULL CONSTRAINT DEF_Plantilla_segMaquina	  DEFAULT (host_name()),
  indEliminado      		BIT	       NOT NULL CONSTRAINT DEF_Plantilla_indEliminado	  DEFAULT (0),
  numDiasExtemporaneo		int  NOT NULL CONSTRAINT DEF_Plantilla_numDiasExtemporaneo	  DEFAULT (0),
   CONSTRAINT PK_Plantilla_codPlantilla PRIMARY KEY CLUSTERED 
	(
		codPlantilla ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Presupuesto.PlantillaDeta
* Tabla para almacenar los detalles de las Plantilla de los presupuestos
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.PlantillaDeta') AND type in (N'U'))
BEGIN
CREATE TABLE Presupuesto.PlantillaDeta
(
  codPlantillaDeta 			int IDENTITY(1,1) NOT NULL,
  codPlantilla 				int				NOT NULL,
  codEmpleadoAprueba 		int				NULL,
  gloDescripcion 			nvarchar(150)	NOT NULL,
  monEstimado 				decimal(12,2)	NOT NULL,
  cntCantidad 				decimal(10,2)	NOT NULL,
  codRegEstado 				int  			NOT NULL,
  fecEjecucion 				datetime  		NULL,
  indPlantilla 				nvarchar(1)  	NOT NULL,
  codPartida 				int  			NOT NULL,
  numPartida 				nvarchar(12)  	NOT NULL,
  segUsuarioCrea    		VARCHAR(25)    NOT NULL CONSTRAINT DEF_PlantillaDeta_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   		VARCHAR(25)    NULL,
  segFechaCrea      		DATETIME       NOT NULL CONSTRAINT DEF_PlantillaDeta_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     		DATETIME       NULL,
  segMaquinaOrigen  		VARCHAR(25)    NOT NULL CONSTRAINT DEF_PlantillaDeta_segMaquina	  DEFAULT (host_name()),
  indEliminado      		BIT	       NOT NULL CONSTRAINT DEF_PlantillaDeta_indEliminado	  DEFAULT (0),
  codEmpleadoRespon		int null,
   CONSTRAINT PK_PlantillaDeta_codPlantillaDeta PRIMARY KEY CLUSTERED 
	(
		codPlantillaDeta ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO


/***************************************************************************************
* CREACION DE LA TABLA : Presupuesto.PresupuestoArea
* Tabla para almacenar los presupuestos estimados por año
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.PresupuestoArea') AND type in (N'U'))
BEGIN
CREATE TABLE Presupuesto.PresupuestoArea
(
  codPresupuestoArea 		int IDENTITY(1,1) NOT NULL,
  codPresupuesto	 		int				NULL,
  codArea 					int				NULL,
  monMaximo 				decimal(12,2)	NULL,
  indActivo         		BIT 			NOT NULL CONSTRAINT DEF_PresupuestoArea_indActivo	  DEFAULT (1),
  segUsuarioCrea    		VARCHAR(25)		NOT NULL CONSTRAINT DEF_PresupuestoArea_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   		VARCHAR(25)		NULL,
  segFechaCrea      		DATETIME		NOT NULL CONSTRAINT DEF_PresupuestoArea_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     		DATETIME		NULL,
  segMaquinaOrigen  		VARCHAR(25)		NOT NULL CONSTRAINT DEF_PresupuestoArea_segMaquina	  DEFAULT (host_name()),
  indEliminado      		BIT				NOT NULL CONSTRAINT DEF_PresupuestoArea_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_PresupuestoArea_codPresupuestoArea PRIMARY KEY CLUSTERED 
	(
		codPresupuestoArea ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Presupuesto.Presupuesto
* Tabla para almacenar los presupuestos por año
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.Presupuesto') AND type in (N'U'))
BEGIN
CREATE TABLE Presupuesto.Presupuesto
(
  codPresupuesto 		int IDENTITY(1,1)	NOT NULL,
  desNombre 			nvarchar(100)		NOT NULL,
  numAnio 				int  				NOT NULL,
  fecInicio 			datetime  			NULL,
  fecCierre 			datetime  			NULL,
  codRegEstado			int  				NOT NULL,
  segUsuarioCrea    	VARCHAR(25)			NOT NULL CONSTRAINT DEF_Presupuesto_segUsuarioCrea DEFAULT USER_NAME(),
  segUsuarioEdita   	VARCHAR(25)			NULL,
  segFechaCrea      	DATETIME			NOT NULL CONSTRAINT DEF_Presupuesto_segFechaCrea   DEFAULT GETDATE(),
  segFechaEdita     	DATETIME			NULL,
  segMaquinaOrigen  	VARCHAR(25)			NOT NULL CONSTRAINT DEF_Presupuesto_segMaquina	  DEFAULT (host_name()),
  indEliminado      	BIT					NOT NULL CONSTRAINT DEF_Presupuesto_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_Presupuesto_codPresupuesto PRIMARY KEY CLUSTERED 
	(
		codPresupuesto ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Presupuesto.Solicitud
* Tabla para almacenar los presupuestos por aÃ±o
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.Solicitud') AND type in (N'U'))
BEGIN
-- Creating table 'Solicitud'
	CREATE TABLE Presupuesto.Solicitud
	(
    codSolicitud			int	IDENTITY(1,1)	NOT NULL,
	numSolicitud			varchar(10)		NOT NULL,
    gloObservacion			varchar(100)		NULL,
    fecSolicitada			datetime			NULL,
    indTipo					nvarchar(1)			NOT NULL,
    fecLimite				datetime			NULL,
	codEmpleadoGenera		int					NOT NULL,
    codEmpleadoAprueba		int					NULL,
    codPresupuesto 			int					NULL,
	codRegEstado			INT					NULL,
	segUsuarioCrea    		VARCHAR(25)			NOT NULL CONSTRAINT DEF_Solicitud_segUsuarioCrea DEFAULT USER_NAME(),
	segUsuarioEdita   		VARCHAR(25)			NULL,
	segFechaCrea      		DATETIME			NOT NULL CONSTRAINT DEF_Solicitud_segFechaCrea   DEFAULT GETDATE(),
	segFechaEdita     		DATETIME			NULL,
	segMaquinaOrigen  		VARCHAR(25)			NOT NULL CONSTRAINT DEF_Solicitud_segMaquina	  DEFAULT (host_name()),
	indEliminado      		BIT					NOT NULL CONSTRAINT DEF_Solicitud_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_Solicitud_codSolicitud PRIMARY KEY CLUSTERED 
	(
		codSolicitud ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA :select  * from  Presupuesto.SolicitudDeta
* Tabla para almacenar los presupuestos por aÃ±o
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.SolicitudDeta') AND type in (N'U'))
BEGIN
-- Creating table 'SolicitudPresupuestoDeta'
CREATE TABLE Presupuesto.SolicitudDeta 
(
    codSolicitudDeta				int IDENTITY(1,1)	NOT NULL,
    codSolicitud					int					NOT NULL,
    codPlantillaDeta				int					NOT NULL,
    cntCantidad						DECIMAL(10,2)		NOT NULL,
    gloDescripcion					nvarchar(120)		NOT NULL,
	segUsuarioCrea    				VARCHAR(25)			NOT NULL CONSTRAINT DEF_SolicitudDeta_segUsuarioCrea DEFAULT USER_NAME(),
	segUsuarioEdita   				VARCHAR(25)			NULL,
	segFechaCrea      				DATETIME			NOT NULL CONSTRAINT DEF_SolicitudDeta_segFechaCrea   DEFAULT GETDATE(),
	segFechaEdita     				DATETIME			NULL,
	segMaquinaOrigen  				VARCHAR(25)			NOT NULL CONSTRAINT DEF_SolicitudDeta_segMaquina	 DEFAULT (host_name()),
	indEliminado      				BIT					NOT NULL CONSTRAINT DEF_SolicitudDeta_indEliminado	 DEFAULT (0),
   CONSTRAINT PK_SolicitudDeta_codSolicitudDeta PRIMARY KEY CLUSTERED 
	(
		codSolicitudDeta ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

/**********************************************************************************************************/
/*************************************** Scripts de Trazabilidad ******************************************/
/**********************************************************************************************************/

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.FichaTecnicaProductoFarmacia
* Tabla para almacenar la Ficha Tecnica de Cada Producto con la informacion de la propia Farmacia
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.FichaTecnicaProductoFarmacia') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[FichaTecnicaProductoFarmacia](
	[codigoFichaTecProducto] [varchar](10) NOT NULL,
	[nombre] [varchar](10) NULL,
	[descripcion] [varchar](10) NULL,
	[etiquetado] [varchar](10) NULL,
	[procedimientoAlmacen] [varchar](255) NULL,
	[procedimientoVenta] [varchar](255) NULL,
	[procedimiemtoDistribucion] [varchar](255) NULL,
	[posologia] [varchar](50) NULL,
	[quimicoFarmaceutico] [varchar](10) NULL,
	[aprobar] [varchar](10) NULL,
	[codigoProcedimiento] [varchar](10) NULL,
	[codigoFichaTecProveedor] [varchar](10) NULL,
 CONSTRAINT [PK_FichaTecnicaProductoFarmacia] PRIMARY KEY CLUSTERED 
(
	[codigoFichaTecProducto] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.FichaTecnicaProductoProveedor
* Tabla para almacenar la Ficha Tecnica de Cada Producto basado en la informacion del Proveedor
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.FichaTecnicaProductoProveedor') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[FichaTecnicaProductoProveedor](
	[codigoFichaTecProveedor] [varchar](10) NOT NULL,
	[nombre] [varchar](10) NULL,
	[nomTecnico] [varchar](10) NULL,
	[modoUso] [varchar](255) NULL,
	[contraIndicacion] [varchar](255) NULL,
	[condicionesUso] [varchar](255) NULL,
	[condicionesAlmacen] [varchar](255) NULL,
	[condicionesComercial] [varchar](255) NULL,
	[temperaturaMinima] [varchar](10) NULL,
	[temperaturaMaxima] [varchar](10) NULL,
	[laboratorioOrigen] [varchar](50) NULL,
 CONSTRAINT [PK_FichaTecnicaProductoProveedor] PRIMARY KEY CLUSTERED 
(
	[codigoFichaTecProveedor] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.HojaMerma
* Tabla para almacenar la informacion de los productos que se pierden en el proceso de 
* elaboracion de una formula en el laboratorio.
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.HojaMerma') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[HojaMerma](
	[numeroHojaMerma] [varchar](10) NOT NULL,
	[cantidadInsumo] [varchar](10) NULL,
	[fecha] [date] NULL,
	[motivo] [varchar](50) NULL,
	[codigoProducto] [varchar](10) NULL,
 CONSTRAINT [PK_HojaMerma] PRIMARY KEY CLUSTERED 
(
	[numeroHojaMerma] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.InformeTrazabilidad
* Tabla para almacenar la informacion del Analisis del Informe de Trazabilidad
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.InformeTrazabilidad') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[InformeTrazabilidad](
	[codigoInformeTrazabilidad] [varchar](10) NOT NULL,
	[producto] [varchar](50) NULL,
	[detalleAnalisis] [varchar](255) NULL,
	[anexo] [varchar](255) NULL,
	[codigoTraza] [varchar](10) NULL,
 CONSTRAINT [PK_InformeTrazabilidad] PRIMARY KEY CLUSTERED 
(
	[codigoInformeTrazabilidad] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.InformeVenta
* Tabla que almacena la informacion de las Ventas que se han dado por cada producto
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.InformeVenta') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[InformeVenta](
	[codigoVenta] [varchar](10) NOT NULL,
	[fechaVenta] [date] NULL,
	[nombreProducto] [varchar](10) NULL,
	[cantidad] [varchar](10) NULL,
	[nombreCliente] [varchar](10) NULL,
	[precio] [varchar](10) NULL,
	[codigoProducto] [varchar](10) NULL,
 CONSTRAINT [PK_InformeVenta] PRIMARY KEY CLUSTERED 
(
	[codigoVenta] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.Kardex
* Tabla que contiene la informacion del movimiento de un Producto
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.Kardex') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[Kardex](
	[numeroKardex] [varchar](10) NOT NULL,
	[fecha] [date] NULL,
	[ingreso] [varchar](10) NULL,
	[salidas] [varchar](10) NULL,
	[saldos] [varchar](10) NULL,
	[observaciones] [varchar](255) NULL,
	[codigoProducto] [varchar](10) NULL,
 CONSTRAINT [PK_Kardex] PRIMARY KEY CLUSTERED 
(
	[numeroKardex] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.LibroReceta
* Tabla que contiene la informacion de todas las recetas para elaborar los preparados
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.LibroReceta') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[LibroReceta](
	[nombreProducto] [varchar](10) NOT NULL,
	[fechaProducto] [date] NULL,
	[quimicoLaboratorista] [varchar](10) NULL,
	[codigoProducto] [varchar](10) NULL,
 CONSTRAINT [PK_LibroReceta] PRIMARY KEY CLUSTERED 
(
	[nombreProducto] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.OrdenDeCompra
* Tabla que contiene la informacion de las Ordenes de Compra que se han generado para mantener el stock
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.OrdenDeCompra') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[OrdenDeCompra](
	[codigoCompra] [varchar](10) NOT NULL,
	[fechaCompra] [date] NULL,
	[nombreProducto] [varchar](10) NULL,
	[cantidad] [varchar](10) NULL,
	[nombreProveedor] [varchar](10) NULL,
	[costo] [varchar](10) NULL,
	[codigoProducto] [varchar](10) NULL,
 CONSTRAINT [PK_OrdenDeCompra] PRIMARY KEY CLUSTERED 
(
	[codigoCompra] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.OrdenDeDespacho
* Tabla que contiene la informacion de los movimientos de un producto desde la Principal a las Sucursales
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.OrdenDeDespacho') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[OrdenDeDespacho](
	[numeroOrden] [varchar](10) NOT NULL,
	[fecha] [date] NULL,
	[totalPedidos] [varchar](10) NULL,
	[pesoTotal] [varchar](10) NULL,
	[observaciones] [varchar](255) NULL,
	[codigoProducto] [varchar](10) NULL,
 CONSTRAINT [PK_OrdenDeDespacho] PRIMARY KEY CLUSTERED 
(
	[numeroOrden] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.Procedimiento
* Tabla que registra la informacion del procedimiento administrativo que rigen las actividades de Boticas B&S
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.Procedimiento') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[Procedimiento](
	[codigoProcedimiento] [varchar](10) NOT NULL,
	[version] [varchar](10) NULL,
	[fechIniVigencia] [date] NULL,
	[fechFinVigencia] [date] NULL,
	[responsable] [varchar](50) NULL,
	[unidadPlazo] [varchar](10) NULL,
	[observaciones] [varchar](50) NULL,
 CONSTRAINT [PK_Procedimiento] PRIMARY KEY CLUSTERED 
(
	[codigoProcedimiento] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.Producto
* Tabla que contiene la informacion de cada Producto que se tiene en la Farmacia
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.Producto') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[Producto](
	[codigoProducto] [varchar](10) NOT NULL,
	[nombreProducto] [varchar](50) NULL,
	[descripcion] [varchar](50) NULL,
	[tipoProducto] [varchar](50) NULL,
	[presentacion] [varchar](10) NULL,
	[pesoProducto] [varchar](10) NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[codigoProducto] ASC
)
)
ON [DATABASE01]
END
GO

/***************************************************************************************
* CREACION DE LA TABLA : Trazabilidad.Trazabilidad
* Tabla que contiene el detalle de la información de trazabilidad realizada a los productos seleccionados
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Trazabilidad.Trazabilidad') AND type in (N'U'))
BEGIN
CREATE TABLE [Trazabilidad].[Trazabilidad](
	[codigoTraza] [varchar](10) NOT NULL,
	[fechaTraza] [date] NULL,
	[producto] [varchar](50) NULL,
	[descripcion] [varchar](255) NULL,
	[codigoVenta] [varchar](10) NULL,
	[numeroKardex] [varchar](10) NULL,
	[codigoCompra] [varchar](10) NULL,
	[numeroOrden] [varchar](10) NULL,
	[numeroHojaMerma] [varchar](10) NULL,
	[nombreProducto] [varchar](10) NULL,
	[codigoFichaTecProducto] [varchar](10) NULL,
 CONSTRAINT [PK_Trazabilidad] PRIMARY KEY CLUSTERED 
(
	[codigoTraza] ASC
)
)
ON [DATABASE01]
END
GO

-- CREACION DE PROCEDIMIENTOS ALMACENADOS
use BD_ByS
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Plantilla')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_Plantilla] AS RETURN')
	--[Presupuesto].[pa_S_Plantilla] null,2016,3
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_Plantilla] 
(
	@p_codPlantilla			INT=null,
	@p_anio       			INT=null,
	@p_codArea        		INT=null
)
AS
BEGIN
	 select distinct
	 pl.codPlantilla
	,pl.numPlantilla
	,pr.desNombre		[nombrePresupuesto]
	,pr.numAnio
	,pr.fecCierre
	,ar.desNombre		[codAreaNombre]
	,em.desNombre +', '+em.desApellido [desEmpleadoActual]
	,ca.desNombre		[codCargoNombre]
	,ep.desNombre +', '+ep.desApellido [desEmpleadoElabora]
	,pl.segFechaEdita
	,pl.segUsuarioEdita
	,pl.segFechaCrea
	,pl.segUsuarioCrea
	,pra.monMaximo
	,pl.numDiasExtemporaneo
	,CASE WHEN pl.codRegEstado = 1 THEN 'PENDIENTE'
		  WHEN pl.codRegEstado = 2 THEN 'TERMIN.INGR'
		  WHEN pl.codRegEstado = 3 THEN 'APROBADO'
		  WHEN pl.codRegEstado = 4 THEN 'DESAP.OBSER'
		  WHEN pl.codRegEstado = 5 THEN 'EJECUTADA'
	 END [EstadoPlantilla]
	,(SELECT sum(sdt.monEstimado) FROM 
	  Presupuesto.PlantillaDeta sdt
	  WHERE 
	  sdt.codPlantilla in ( select px.codPlantilla
							from Presupuesto.Plantilla px 
							inner join Presupuesto.Presupuesto rx 
							on rx.codPresupuesto = px.codPresupuesto
							where px.codArea = isnull(@p_codArea,0)
							and rx.numAnio = isnull(@p_anio,0)
						  )
	  ) AS monEstimadoTotalxArea
	  
	from Presupuesto.Plantilla pl
	inner join Presupuesto.Presupuesto pr on pl.codPresupuesto = pr.codPresupuesto 
	inner join RecursosHumanos.Area ar on pl.codArea = ar.codArea
	inner join RecursosHumanos.Empleado em on em.codArea = ar.codArea
	inner join RecursosHumanos.Cargo ca on em.codCargo = ca.codCargo
	inner join RecursosHumanos.Empleado ep on pl.codEmpleadoElabora = ep.codEmpleado
	inner join Presupuesto.PresupuestoArea pra on pra.codArea = ar.codArea and
												  pra.codPresupuesto = pr.codPresupuesto
	where
	ISNULL(pl.codPlantilla,'')	=	(CASE WHEN ISNULL(@p_codPlantilla,'')<>''	
										THEN ISNULL(@p_codPlantilla,'') 
										ELSE ISNULL(pl.codPlantilla,'')	
									 END) AND
	ISNULL(pr.numAnio,'')		=	(CASE WHEN ISNULL(@p_anio,'')	<>''		
										THEN  ISNULL(@p_anio,'')   	
										ELSE ISNULL(pr.numAnio,'')	
									 END) AND
	ISNULL(ar.codArea,'')		=	(CASE WHEN ISNULL(@p_codArea,'')<>''		
										THEN  ISNULL(@p_codArea,'') 
										ELSE ISNULL(ar.codArea,'')	
									 END) AND
	pl.indEliminado = 0
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_EmpleadoLogin')
BEGIN
	EXEC('CREATE PROCEDURE [RecursosHumanos].[pa_S_EmpleadoLogin] AS RETURN')
END
GO
ALTER PROCEDURE [RecursosHumanos].[pa_S_EmpleadoLogin]
(
	@p_desLogin    			varchar(50)
)
AS
BEGIN
	select 
	 codEmpleado 
	,codCargo
	,codArea
	,desNombre
	,desApellido
	from RecursosHumanos.Empleado em 
	where
	desLogin = @p_desLogin 
	and	indActivo = 1
	and indEliminado=0
END
GO


IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_PlantillaDeta')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_PlantillaDeta] AS RETURN')
	--[Presupuesto].[pa_S_PlantillaDeta]null,2015,6,4
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_PlantillaDeta]
(
	@p_codPlantillaDeta		INT=null,
	@p_anio       			INT=null,
	@p_codArea        		INT=null,
	@p_codRegEstado			INT=null
)
AS
BEGIN
	select
	 pd.codPlantillaDeta
	,pd.codPlantilla
	,pd.codEmpleadoAprueba
	,ema.desNombre +', '+ema.desApellido [codEmpleadoApruebaNombre]
	,pd.gloDescripcion
	,pd.monEstimado
	,pd.cntCantidad
	,pd.codRegEstado
	,CASE WHEN pd.codRegEstado = 1 THEN 'PENDIENxAPROB'
		  WHEN pd.codRegEstado = 2 THEN 'APROBADO'
		  WHEN pd.codRegEstado = 3 THEN 'DESAPROBADO'
		  WHEN pd.codRegEstado = 4 THEN 'EN EJECUCION'
		  WHEN pd.codRegEstado = 5 THEN 'EJECUTADO'
	 END codRegEstadoNombre
	,pd.fecEjecucion
	,pd.codEmpleadoRespon
	,emr.desNombre +', '+emr.desApellido [codEmpleadoResponRespon]
	,pd.indPlantilla
	,CASE WHEN pd.indPlantilla = 'N' THEN 'NORMAL'
		  ELSE 'ADICIONAL'
	 END [indPlantillaTipo]
	,pd.codPartida
	,pd.numPartida
	,pd.segUsuarioCrea
	,pd.segUsuarioEdita
	,pd.segFechaCrea
	,pd.segFechaEdita
	,pd.segMaquinaOrigen
	,par.desNombre codPartidaNombre
	,par.codNumero
	,pl.codArea
	,are.desNombre codAreaNombre
	from
	Presupuesto.PlantillaDeta pd
	inner join Presupuesto.Plantilla pl on pl.codPlantilla = pd.codPlantilla
	inner join Presupuesto.Presupuesto pr on pl.codPresupuesto = pr.codPresupuesto 
	inner join RecursosHumanos.Area are on pl.codArea = are.codArea
	left join RecursosHumanos.Empleado ema on pd.codEmpleadoAprueba = ema.codEmpleado
	left join RecursosHumanos.Empleado emr on pd.codEmpleadoRespon = emr.codEmpleado
	inner join Presupuesto.Partida par on pd.codPartida = par.codPartida
	
	WHERE
	ISNULL(pd.codPlantillaDeta,'')	=	(CASE WHEN ISNULL(@p_codPlantillaDeta,'')<>''	THEN  ISNULL(@p_codPlantillaDeta,'') ELSE ISNULL(pd.codPlantillaDeta,'')	END) AND
	ISNULL(pr.numAnio,'')			=	(CASE WHEN ISNULL(@p_anio,'')	<>''	THEN  ISNULL(@p_anio,'')   	ELSE ISNULL(pr.numAnio,'')	END) AND
	ISNULL(pl.codArea,'')			=	(CASE WHEN ISNULL(@p_codArea,'')<>''	THEN  ISNULL(@p_codArea,'') ELSE ISNULL(pl.codArea,'')	END) AND
	ISNULL(pd.codRegEstado,'')		=	(CASE WHEN ISNULL(@p_codRegEstado,'')<>''	THEN  ISNULL(@p_codRegEstado,'') ELSE ISNULL(pd.codRegEstado,'')	END) AND
	pd.indEliminado = 0
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_PlantillaDetaPagina')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_PlantillaDetaPagina] AS RETURN')
	--[Presupuesto].[pa_S_PlantillaDetaPagina] 2,15,'',''	
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_PlantillaDetaPagina] 
(
	 @p_NumPagina			int
	,@p_TamPagina			int
	,@p_OrdenPor			varchar(30)=null
	,@p_OrdenTipo			varchar(4)=null
	,@p_anio       			INT=null
	,@p_codArea        		INT=null
	,@p_codRegEstado		INT=null
)
AS
BEGIN
SET NOCOUNT ON
	SELECT
	*
	
	FROM
	(	
	select
	 pd.codPlantillaDeta
	,pd.codPlantilla
	,pd.codEmpleadoAprueba
	,ema.desNombre +', '+ema.desApellido [codEmpleadoResponNombre]
	,pd.gloDescripcion
	,pd.monEstimado
	,pd.cntCantidad
	,pd.codRegEstado
	,CASE WHEN pd.codRegEstado = 1 THEN 'PENDIENxAPROB'
		  WHEN pd.codRegEstado = 2 THEN 'APROBADO'
		  WHEN pd.codRegEstado = 3 THEN 'DESAPROBADO'
		  WHEN pd.codRegEstado = 4 THEN 'EN EJECUCION'
		  WHEN pd.codRegEstado = 5 THEN 'EJECUTADO'
	 END codRegEstadoNombre
	,pd.fecEjecucion
	,pd.codEmpleadoRespon
	,emr.desNombre +', '+emr.desApellido [codEmpleadoResponRespon]
	,pd.indPlantilla
	,CASE WHEN pd.indPlantilla = 'N' THEN 'NORMAL'
		  ELSE 'ADICIONAL'
	 END [indPlantillaTipo]
	,pd.codPartida
	,pd.numPartida
	,pd.segUsuarioCrea
	,pd.segUsuarioEdita
	,pd.segFechaCrea
	,pd.segFechaEdita
	,pd.segMaquinaOrigen
	,par.desNombre codPartidaNombre
	,par.codNumero
	,pl.codArea
	,are.desNombre codAreaNombre
	,COUNT(*) OVER() AS [TOTALROWS]
	    ,ROW_NUMBER() OVER (ORDER BY CASE WHEN @p_OrdenPor = 'numPartida'  and @p_OrdenTipo = 'ASC' 
										   THEN pd.[numPartida]
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'numPartida'  and @p_OrdenTipo = 'DESC' 
										   THEN pd.[numPartida]
									 END DESC,	  	   
									 CASE WHEN @p_OrdenPor = 'monEstimado'  and @p_OrdenTipo = 'ASC'  THEN
										pd.[monEstimado]  
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'monEstimado'  and @p_OrdenTipo = 'DESC'  THEN
										pd.[monEstimado]  
									 END DESC  
									 ) AS [ROWNUM]	
	from	Presupuesto.PlantillaDeta pd
	inner join Presupuesto.Plantilla pl on pl.codPlantilla = pd.codPlantilla
	inner join Presupuesto.Presupuesto pr on pl.codPresupuesto = pr.codPresupuesto 
	inner join RecursosHumanos.Area are on pl.codArea = are.codArea
	left join RecursosHumanos.Empleado ema on pd.codEmpleadoAprueba = ema.codEmpleado
	left join RecursosHumanos.Empleado emr on pd.codEmpleadoRespon = emr.codEmpleado
	inner join Presupuesto.Partida par on pd.codPartida = par.codPartida
	WHERE
	ISNULL(pr.numAnio,'')	=	(CASE WHEN ISNULL(@p_anio,'')	<>''	THEN  ISNULL(@p_anio,'')   	ELSE ISNULL(pr.numAnio,'')	END) AND
	ISNULL(pl.codArea,'')	=	(CASE WHEN ISNULL(@p_codArea,'')<>''	THEN  ISNULL(@p_codArea,'') ELSE ISNULL(pl.codArea,'')	END) AND
	ISNULL(pd.codRegEstado,'')=	(CASE WHEN ISNULL(@p_codRegEstado,'')<>''THEN  ISNULL(@p_codRegEstado,'') ELSE ISNULL(pd.codRegEstado,'')	END) AND
	pd.indEliminado = 0
)
	AS Tabla
	WHERE ROWNUM BETWEEN (@p_NumPagina*@p_TamPagina) - @p_TamPagina + 1 
					 AND (@p_NumPagina*@p_TamPagina)
					 
	SET NOCOUNT OFF
END
GO


IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_I_PlantillaDeta')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_I_PlantillaDeta] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_I_PlantillaDeta]
(@p_codPlantillaDeta			int OUTPUT
,@p_codPlantilla             	int 
,@p_gloDescripcion           	nvarchar(150)
,@p_monEstimado              	decimal(12,2)
,@p_cntCantidad              	decimal(10,2)
,@p_fecEjecucion             	datetime
,@p_indPlantilla             	nvarchar(1)
,@p_codPartida               	int
,@p_segUsuarioCrea           	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)

AS
BEGIN
	INSERT INTO [Presupuesto].[PlantillaDeta]
	([codPlantilla]
	,[gloDescripcion]
	,[monEstimado]
	,[cntCantidad]
	,[codRegEstado]
	,[fecEjecucion]
	,[indPlantilla]
	,[codPartida]
	,[numPartida]
	,[segUsuarioCrea]
	,[segFechaCrea]
	,[segMaquinaOrigen]
	)
	VALUES
	(@p_codPlantilla
	,@p_gloDescripcion
	,@p_monEstimado
	,@p_cntCantidad
	,1
	,@p_fecEjecucion
	,@p_indPlantilla
	,@p_codPartida
	,'5555'
	,@p_segUsuarioCrea
	,GETDATE()
	,@p_segMaquinaOrigen
	)
	SET @p_codPlantillaDeta  = @@IDENTITY
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_U_PlantillaDeta')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_U_PlantillaDeta] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_U_PlantillaDeta]
(
 @p_codPlantillaDeta         	int
,@p_gloDescripcion           	nvarchar(150)
,@p_monEstimado              	decimal(12,2)
,@p_cntCantidad              	decimal(10,2)
,@p_fecEjecucion             	datetime
,@p_codPartida               	int
,@p_segUsuarioEdita          	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[PlantillaDeta]
	SET 
	 [gloDescripcion]        = 	@p_gloDescripcion
	,[monEstimado]           = 	@p_monEstimado
	,[cntCantidad]           = 	@p_cntCantidad
	,[fecEjecucion]          = 	@p_fecEjecucion
	,[codPartida]            = 	@p_codPartida
	,[segUsuarioEdita]       = 	@p_segUsuarioEdita
	,[segFechaEdita]         = 	getdate()
	,[segMaquinaOrigen]      = 	@p_segMaquinaOrigen
	WHERE 
	[codPlantillaDeta]       = @p_codPlantillaDeta
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_U_PlantillaDetaAprob')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_U_PlantillaDetaAprob] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_U_PlantillaDetaAprob]
(
 @p_codPlantillaDeta         	int
,@p_codEmpleadoAprueba       	int
,@p_segUsuarioEdita          	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[PlantillaDeta]
	SET 
	 [codEmpleadoAprueba]    = 	@p_codEmpleadoAprueba
	,[codRegEstado]          = 	1
	,[segUsuarioEdita]       = 	@p_segUsuarioEdita
	,[segFechaEdita]         = 	getdate()
	,[segMaquinaOrigen]      = 	@p_segMaquinaOrigen
	WHERE 
	[codPlantillaDeta]       = 	@p_codPlantillaDeta
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_D_PlantillaDeta')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_D_PlantillaDeta] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_D_PlantillaDeta]
(
 @p_codPlantillaDeta         	int
,@p_segUsuarioEdita          	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[PlantillaDeta]
	SET 
	 [segUsuarioEdita]       = 	@p_segUsuarioEdita
	,[segFechaEdita]         = 	getdate()
	,[segMaquinaOrigen]      = 	@p_segMaquinaOrigen
	,[indEliminado]			 =  1 	
	WHERE 
	[codPlantillaDeta]       = @p_codPlantillaDeta
END
GO


IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Partida')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_Partida] AS RETURN')
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_Partida]

AS
BEGIN
	select 
	 codPartida 
	,cast(codNumero as varchar(10))+'-'+desNombre [desNombre]
	from Presupuesto.Partida pt 
	where
	indActivo = 1
	and [indEliminado]=0
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Presupuesto')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_Presupuesto] AS RETURN')
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_Presupuesto]
(
@p_numAnio		INT=null
)
AS
BEGIN
	SELECT 
	 p.codPresupuesto
	,p.desNombre
	,p.numAnio
	,p.fecInicio
	,p.fecCierre
	,p.codRegEstado
	,p.segUsuarioCrea
	,p.segUsuarioEdita
	,p.segFechaCrea
	,p.segFechaEdita
	,p.segMaquinaOrigen
	,p.indEliminado
	,(SELECT SUM(pa.monMaximo) 
	  FROM Presupuesto.PresupuestoArea pa
	  WHERE pa.codPresupuesto = p.codPresupuesto AND pa.indEliminado = 0
	 ) as monTotalPresupuesto
	,(SELECT sum(pd.cntCantidad*pd.monEstimado)
	  FROM Presupuesto.PlantillaDeta pd
	  INNER JOIN Presupuesto.Plantilla pg on pd.codPlantilla = pg.codPlantilla
	  WHERE pg.codPresupuesto = p.codPresupuesto AND pd.indEliminado = 0
	 )as monTotalSolicitado
	,(SELECT sum(gt.cntCantidad*gt.monTotal)
	  FROM Presupuesto.Gasto gt
	  INNER JOIN Presupuesto.PlantillaDeta pdx on pdx.codPlantillaDeta=gt.codPlantillaDeta
	  INNER JOIN Presupuesto.Plantilla pgx on pgx.codPlantilla = pdx.codPlantilla
	  WHERE pgx.codPresupuesto = p.codPresupuesto and pdx.codRegEstado in (1,2,4,5)
	  AND gt.indEliminado = 0
	 )as monTotalGastado
	FROM
	Presupuesto.Presupuesto p
	WHERE 
	ISNULL(p.numAnio,'')	=	(CASE WHEN ISNULL(@p_numAnio,'')<>''	
									 THEN  ISNULL(@p_numAnio,'') 
									 ELSE ISNULL(p.numAnio,'')	
									 END) 
	and p.indEliminado=0
		
END
GO


IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Gasto')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_Gasto] AS RETURN')
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_Gasto]
(
 @p_codGasto			INT=null
,@p_codPlantillaDeta	INT=null
)
AS
BEGIN
	SELECT 
	 gt.codGasto
	,gt.codPlantillaDeta
	,gt.monTotal
	,gt.cntCantidad
	,gt.numDocumento
	,gt.gloObservacion
	,gt.fecGasto
	,codEmpleadoResp
	,em.desNombre + ','+em.desApellido [codEmpleadoRespNombre]
	,gt.segUsuarioCrea
	,gt.segUsuarioEdita
	,gt.segFechaCrea
	,gt.segFechaEdita
	,gt.segMaquinaOrigen
	from Presupuesto.Gasto gt
	left join RecursosHumanos.Empleado em on gt.codEmpleadoResp = em.codEmpleado
	WHERE 
	ISNULL(gt.codGasto,'')	=	(CASE WHEN ISNULL(@p_codGasto,'')<>''	
									 THEN  ISNULL(@p_codGasto,'') 
									 ELSE ISNULL(gt.codGasto,'')	
								 END) 
	AND ISNULL(gt.codPlantillaDeta,'')	=	(CASE WHEN ISNULL(@p_codPlantillaDeta,'')<>''	
									 THEN  ISNULL(@p_codPlantillaDeta,'') 
									 ELSE ISNULL(gt.codPlantillaDeta,'')	
								 END) 									 
	AND gt.indEliminado	 = 0

END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_GastoPagina')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_GastoPagina] AS RETURN')
	--[Presupuesto].[pa_S_GastoPagina] 1,10,'codGasto','asc',null,153
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_GastoPagina]
(
	 @p_NumPagina			int
	,@p_TamPagina			int
	,@p_OrdenPor			varchar(30)=null
	,@p_OrdenTipo			varchar(4)=null
	,@p_codGasto			INT=null
	,@p_codPlantillaDeta	INT=null
)
AS
BEGIN
	SELECT
	*
	FROM
	(	
		SELECT 
		 gt.codGasto
		,gt.codPlantillaDeta
		,gt.monTotal
		,gt.cntCantidad
		,gt.numDocumento
		,gt.gloObservacion
		,gt.fecGasto
		,codEmpleadoResp
		,em.desNombre + ','+em.desApellido [codEmpleadoRespNombre]
		,gt.segUsuarioCrea
		,gt.segUsuarioEdita
		,gt.segFechaCrea
		,gt.segFechaEdita
		,gt.segMaquinaOrigen
		,COUNT(*) OVER() AS [TOTALROWS]
	    ,ROW_NUMBER() OVER (ORDER BY CASE WHEN @p_OrdenPor = 'fecGasto'  and @p_OrdenTipo = 'ASC' 
										   THEN gt.fecGasto
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'fecGasto'  and @p_OrdenTipo = 'DESC' 
										   THEN gt.fecGasto
									 END DESC,	  	   
									 CASE WHEN @p_OrdenPor = 'cntCantidad'  and @p_OrdenTipo = 'ASC'  THEN
										gt.cntCantidad  
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'cntCantidad'  and @p_OrdenTipo = 'DESC'  THEN
										gt.cntCantidad  
									 END DESC  
									 ) AS [ROWNUM]
		from Presupuesto.Gasto gt
		left join RecursosHumanos.Empleado em on gt.codEmpleadoResp = em.codEmpleado
		WHERE 
		ISNULL(gt.codGasto,'')	=	(CASE WHEN ISNULL(@p_codGasto,'')<>''	
									 THEN  ISNULL(@p_codGasto,'') 
									 ELSE ISNULL(gt.codGasto,'')	
									 END) 
		AND ISNULL(gt.codPlantillaDeta,'')	=	(CASE WHEN ISNULL(@p_codPlantillaDeta,'')<>''	
										 THEN  ISNULL(@p_codPlantillaDeta,'') 
										 ELSE ISNULL(gt.codPlantillaDeta,'')	
									 END) 									 
		AND gt.indEliminado	 = 0
	)
	AS Tabla
	WHERE ROWNUM BETWEEN (@p_NumPagina*@p_TamPagina) - @p_TamPagina + 1 
					 AND (@p_NumPagina*@p_TamPagina)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_I_Gasto')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_I_Gasto] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_I_Gasto]
(@p_codGasto					int output
,@p_codPlantillaDeta         	int
,@p_monTotal                 	decimal(10,2)
,@p_cntCantidad              	decimal(10,2)
,@p_numDocumento             	nvarchar(16)
,@p_gloObservacion           	nvarchar(120)
,@p_fecGasto                 	datetime
,@p_codEmpleadoResp          	int
,@p_segUsuarioCrea           	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	INSERT INTO [Presupuesto].[Gasto]
	([codPlantillaDeta]
	,[monTotal]
	,[cntCantidad]
	,[numDocumento]
	,[gloObservacion]
	,[fecGasto]
	,[codEmpleadoResp]
	,[segUsuarioCrea]
	,[segFechaCrea]
	,[segMaquinaOrigen]
	)
	VALUES
	(@p_codPlantillaDeta
	,@p_monTotal
	,@p_cntCantidad
	,@p_numDocumento
	,@p_gloObservacion
	,@p_fecGasto
	,@p_codEmpleadoResp
	,@p_segUsuarioCrea
	,getdate()
	,@p_segMaquinaOrigen
	)
	SET @p_codGasto  = @@IDENTITY
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_U_Gasto')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_U_Gasto] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_U_Gasto]
(
 @p_codGasto                 	int
,@p_monTotal                 	decimal(12,2)
,@p_cntCantidad              	decimal(10,2)
,@p_numDocumento             	nvarchar(16)
,@p_gloObservacion           	nvarchar(120)
,@p_fecGasto                 	datetime
,@p_codEmpleadoResp          	int
,@p_segUsuarioEdita          	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[Gasto]
	SET 
	 [monTotal]              = 	@p_monTotal
	,[cntCantidad]           = 	@p_cntCantidad
	,[numDocumento]          = 	@p_numDocumento
	,[gloObservacion]        = 	@p_gloObservacion
	,[fecGasto]              = 	@p_fecGasto
	,[codEmpleadoResp]       = 	@p_codEmpleadoResp
	,[segUsuarioEdita]       = 	@p_segUsuarioEdita
	,[segFechaEdita]         = 	getdate()
	,[segMaquinaOrigen]      = 	@p_segMaquinaOrigen
	WHERE 
	[codGasto]               = 	@p_codGasto
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_D_Gasto')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_D_Gasto] AS RETURN')
END
GO
ALTER PROCEDURE [Presupuesto].[pa_D_Gasto]
(
 @p_codGasto                 	int
,@p_segUsuarioElimina          	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[Gasto]
	SET
	 segUsuarioEdita  =@p_segUsuarioElimina  
	,segMaquinaOrigen =@p_segMaquinaOrigen 
	,indEliminado	  =1
	WHERE 
	[codGasto]        =@p_codGasto
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Area')
BEGIN
	EXEC('CREATE PROCEDURE [RecursosHumanos].[pa_S_Area] AS RETURN')
END
GO
ALTER PROCEDURE [RecursosHumanos].[pa_S_Area]
AS
BEGIN
	SELECT 
	codArea,
	desNombre,
	gloDescripcion,
	indActivo,
	segUsuarioCrea,
	segUsuarioEdita,
	segFechaCrea,
	segFechaEdita,
	segMaquinaOrigen,
	indEliminado
	FROM 
	RecursosHumanos.Area
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Empleado')
BEGIN
	EXEC('CREATE PROCEDURE [RecursosHumanos].[pa_S_Empleado] AS RETURN')
	-- [RecursosHumanos].[pa_S_Empleado] NULL,NULL,'OR'
END
GO
ALTER PROCEDURE [RecursosHumanos].[pa_S_Empleado]
(
 @p_codEmpleado	INT=NULL
,@p_codArea	  	INT=NULL
,@p_desNombre	VARCHAR(30)=NULL
,@p_desApellido	VARCHAR(30)=NULL
)
AS
BEGIN
	SELECT 
	em.codEmpleado,
	em.codPersona,
	em.codCargo,
	cr.desNombre codCargoNombre,
	em.codArea,
	ar.desNombre codAreaNombre,
	em.desNombre,
	em.desApellido,
	em.indActivo,
	em.segUsuarioCrea,
	em.segUsuarioEdita,
	em.segFechaCrea,
	em.segFechaEdita,
	em.segMaquinaOrigen,
	em.indEliminado
	FROM 
	RecursosHumanos.Empleado em
	INNER JOIN RecursosHumanos.Area  ar ON ar.codArea  = em.codArea 
	INNER JOIN RecursosHumanos.Cargo cr ON cr.codCargo = em.codCargo
	WHERE
	ISNULL(em.codEmpleado,'')	=	(CASE WHEN ISNULL(@p_codEmpleado,'')<>''	
										 THEN  ISNULL(@p_codEmpleado,'') 
										 ELSE ISNULL(em.codEmpleado,'')	
									 END) 
	AND ISNULL(em.codArea,'')	=	(CASE WHEN ISNULL(@p_codArea,'')<>''	
										 THEN  ISNULL(@p_codArea,'') 
										 ELSE ISNULL(em.codArea,'')	
									 END) 
	AND ISNULL(em.desNombre,'')LIKE	(CASE WHEN ISNULL(@p_desNombre,'')<>''	
										 THEN  '%' +ISNULL(@p_desNombre,'')+ '%' 
										 ELSE ISNULL(em.desNombre,'')	
									 END)
	AND ISNULL(em.desApellido,'')LIKE(CASE WHEN ISNULL(@p_desApellido,'')<>''	
										 THEN  '%' +ISNULL(@p_desApellido,'')+ '%' 
										 ELSE ISNULL(em.desApellido,'')	
									 END)		
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_I_PlantillaDetaRefer')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_I_PlantillaDetaRefer] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_I_PlantillaDetaRefer]
(@p_codPlantillaDeta			int OUTPUT
,@p_codPlantillaDetaRefer		int 
,@p_codPlantilla             	int 
,@p_segUsuarioCrea           	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)

AS
BEGIN
	DECLARE @v_gloDescripcion    	nvarchar(150)
	DECLARE @v_monEstimado       	decimal(12,2)
	DECLARE @v_cntCantidad       	decimal(10,2)
	DECLARE @v_fecEjecucion      	datetime
	DECLARE @v_codPartida        	int			  
	DECLARE @v_anios      			int
	
	SELECT
	 @v_gloDescripcion = gloDescripcion
	,@v_monEstimado    = monEstimado   
	,@v_cntCantidad    = cntCantidad   
	,@v_fecEjecucion   = fecEjecucion  
	,@v_codPartida     = codPartida    
	FROM
	[Presupuesto].[PlantillaDeta] dt
	WHERE
	dt.codPlantillaDeta = @p_codPlantillaDetaRefer
	
	SET @v_anios = (YEAR(GETDATE())- YEAR(@v_fecEjecucion)) + 1
	
	
	INSERT INTO [Presupuesto].[PlantillaDeta]
	([codPlantilla]
	,[gloDescripcion]
	,[monEstimado]
	,[cntCantidad]
	,[codRegEstado]
	,[fecEjecucion]
	,[indPlantilla]
	,[codPartida]
	,[numPartida]
	,[segUsuarioCrea]
	,[segFechaCrea]
	,[segMaquinaOrigen]
	)
	VALUES
	(@p_codPlantilla
	,@v_gloDescripcion
	,@v_monEstimado
	,@v_cntCantidad
	,1
	,DATEADD(day,360*@v_anios,@v_fecEjecucion)
	,'N'
	,@v_codPartida
	,'5555'
	,@p_segUsuarioCrea
	,GETDATE()
	,@p_segMaquinaOrigen
	)
	SET @p_codPlantillaDeta  = @@IDENTITY
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_U_Plantilla_Estado')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_U_Plantilla_Estado] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_U_Plantilla_Estado]
(
 @p_codPlantilla               	int
,@p_codRegEstado              	int
,@p_segUsuarioEdita          	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	Presupuesto.Plantilla
	SET 
	 codRegEstado		   = 	@p_codRegEstado
	,segUsuarioEdita       = 	@p_segUsuarioEdita
	,segFechaEdita         = 	getdate()
	,segMaquinaOrigen      = 	@p_segMaquinaOrigen
	WHERE 
	codPlantilla           = 	@p_codPlantilla
END
GO

/*2016-ENE-19*/
/*------------------------------------------------------------------------
  PROCEDIMIENTO ALMACENADOS PRA LAS TABLAS Maestros
*/------------------------------------------------------------------------
IF OBJECT_ID (N'[Maestros].[fcnCrearCodigo]', N'FN') IS NOT NULL
    DROP FUNCTION [Maestros].[fcnCrearCodigo];
GO
CREATE FUNCTION [Maestros].[fcnCrearCodigo]
(  
	@Length int,
	@MaxNumber varchar(10)
)
RETURNS varchar(100)
AS
BEGIN  
	DECLARE @Padded varchar(100)  
	DECLARE @BaseLen int  
	DECLARE @PadChar char(1)
	SET @PadChar = '0'
	SET @MaxNumber =  isnull(@MaxNumber,'0')
	SET @MaxNumber = convert(int,@MaxNumber)+1
	SET @BaseLen = LEN(@MaxNumber)
    IF @BaseLen >= @Length    
	BEGIN     
		SET @Padded = @MaxNumber    
	END
	ELSE    
	BEGIN      
		SET @Padded = REPLICATE(@PadChar, @Length - @BaseLen) + @MaxNumber    
	END 
	RETURN @Padded
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Solicitud')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_Solicitud] AS RETURN')
	--[Presupuesto].[pa_S_SolicitudPagina] 1,10,'codSolicitud','asc',null,153
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_Solicitud]
(
	 @p_codSolicitud		INT=null
	,@p_numSolicitud		varchar(10)=null
	,@p_fecSolicitadaIni	varchar(10)=null
	,@p_fecSolicitadaFin	varchar(10)=null
	,@p_codRegEstado		INT=null
	,@p_codPresupuesto 		INT=null
)
AS
BEGIN
		SELECT 
		 s.codSolicitud
		,s.numSolicitud
		,s.gloObservacion
		,s.fecSolicitada
		,s.indTipo
		,s.fecLimite
		,s.codEmpleadoGenera
		,eg.desApellido +', ' + eg.desNombre codEmpleadoGeneraNombre
		,s.codEmpleadoAprueba
		,ea.desApellido +', ' + ea.desNombre codEmpleadoApruebaNombre
		,s.codPresupuesto
		,pr.desNombre			codPresupuestoNombre
		,s.codRegEstado
		,s.segUsuarioCrea
		,s.segUsuarioEdita
		,s.segFechaCrea
		,s.segFechaEdita
		,s.segMaquinaOrigen
		from Presupuesto.Solicitud s
		inner join RecursosHumanos.Empleado eg on s.codEmpleadoGenera = eg.codEmpleado
		left  join RecursosHumanos.Empleado ea on s.codEmpleadoAprueba = ea.codEmpleado
		left  join Presupuesto.Presupuesto	pr on s.codPresupuesto	 = pr.codPresupuesto
		WHERE 
		ISNULL(s.codSolicitud,'')	=	(CASE WHEN ISNULL(@p_codSolicitud,'')<>''	
									 THEN  ISNULL(@p_codSolicitud,'') 
									 ELSE ISNULL(s.codSolicitud,'')	
									 END) 
		AND ISNULL(s.numSolicitud,'')	LIKE	(CASE WHEN ISNULL(@p_numSolicitud,'')<>''	
										 THEN  '%' + ISNULL(@p_numSolicitud,'') + '%' 
										 ELSE ISNULL(s.numSolicitud,'')	
									 END) 									 
		AND ISNULL(s.codPresupuesto,'')	=	(CASE WHEN ISNULL(@p_codPresupuesto,'')<>''	
										 THEN  ISNULL(@p_codPresupuesto,'') 
										 ELSE ISNULL(s.codPresupuesto,'')	
									 END) 
											 									 
		AND s.indEliminado	 = 0
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_SolicitudPagina')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_SolicitudPagina] AS RETURN')
	--[Presupuesto].[pa_S_SolicitudPagina] 1,10,'codSolicitud','asc'
	--Select * from Presupuesto.Solicitud s
	--Select * from Presupuesto.Presupuesto
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_SolicitudPagina]
(
	 @p_NumPagina			int
	,@p_TamPagina			int
	,@p_OrdenPor			varchar(30)=null
	,@p_OrdenTipo			varchar(4)=null
	,@p_codSolicitud		INT=null
	,@p_numSolicitud		varchar(10)=null
	,@p_fecSolicitadaIni	varchar(10)=null
	,@p_fecSolicitadaFin	varchar(10)=null
	,@p_codRegEstado		INT=null
	,@p_codPresupuesto 		INT=null
	,@p_codArea 			INT=null
)
AS
BEGIN
	SELECT
	*
	FROM
	(	
		SELECT 
		 s.codSolicitud
		,s.numSolicitud
		,s.gloObservacion
		,s.fecSolicitada
		,s.indTipo
		,s.fecLimite
		,s.codEmpleadoGenera
		,eg.desApellido +', ' + eg.desNombre codEmpleadoGeneraNombre
		,s.codEmpleadoAprueba
		,ea.desApellido +', ' + ea.desNombre codEmpleadoApruebaNombre
		,s.codPresupuesto
		,pr.desNombre			codPresupuestoNombre
		,s.codRegEstado
		,s.segUsuarioCrea
		,s.segUsuarioEdita
		,s.segFechaCrea
		,s.segFechaEdita
		,s.segMaquinaOrigen
		,COUNT(*) OVER() AS [TOTALROWS]
	    ,ROW_NUMBER() OVER (ORDER BY CASE WHEN @p_OrdenPor = 'fecSolicituda'  and @p_OrdenTipo = 'ASC' 
										   THEN s.fecSolicitada
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'fecSolicituda'  and @p_OrdenTipo = 'DESC' 
										   THEN s.fecSolicitada
									 END DESC,	  	   
									 CASE WHEN @p_OrdenPor = 'numSolicitud'  and @p_OrdenTipo = 'ASC'  
										  THEN s.numSolicitud 
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'numSolicitud'  and @p_OrdenTipo = 'DESC'  
										  THEN s.numSolicitud
									 END DESC  
									 ) AS [ROWNUM]
		from Presupuesto.Solicitud s
		inner join RecursosHumanos.Empleado eg on s.codEmpleadoGenera = eg.codEmpleado
		left  join RecursosHumanos.Empleado ea on s.codEmpleadoAprueba = ea.codEmpleado
		left  join Presupuesto.Presupuesto	pr on s.codPresupuesto	 = pr.codPresupuesto
		WHERE 
		ISNULL(s.codSolicitud,0)	=	(CASE WHEN ISNULL(@p_codSolicitud,0)<>0	
										 THEN  ISNULL(@p_codSolicitud,0) 
										 ELSE ISNULL(s.codSolicitud,0)	
										 END) 
		AND ISNULL(s.numSolicitud,'')	LIKE	(CASE WHEN ISNULL(@p_numSolicitud,'')<>''	
													 THEN  '%' + ISNULL(@p_numSolicitud,'') + '%' 
													 ELSE ISNULL(s.numSolicitud,'')	
												 END) 									 
		--AND ISNULL(s.numSolicitud,'')	=	(CASE WHEN ISNULL(@p_codPresupuesto,0)<>0	
		--								 THEN  ISNULL(@p_codPresupuesto,0) 
		--								 ELSE ISNULL(pr.numAnio,0)	
		--							 END) 
		AND ISNULL(eg.codArea,0)	=	(CASE WHEN ISNULL(@p_codArea,0)<>0	
										 THEN  ISNULL(@p_codArea,0) 
										 ELSE ISNULL(eg.codArea,0)	
									 END) 									 									 
		AND s.indEliminado	 = 0
	)
	AS Tabla
	WHERE ROWNUM BETWEEN (@p_NumPagina*@p_TamPagina) - @p_TamPagina + 1 
					 AND (@p_NumPagina*@p_TamPagina)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_I_Solicitud')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_I_Solicitud] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_I_Solicitud]
(@p_codSolicitud				int output
,@p_gloObservacion           	varchar(120)
,@p_fecSolicituda              	datetime
,@p_indTipo                 	varchar(1)
,@p_fecLimite         			datetime
,@p_codEmpleadoGenera          	int
,@p_codPresupuesto				int=null
,@p_codRegEstado              	int=null
,@p_segUsuarioCrea           	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	DECLARE @padAnio			varchar(4)
	DECLARE @p_numSolicitud		varchar(10)

	SET @padAnio = 	LTRIM(RTRIM(YEAR(GETDATE())))
	DECLARE @Codigo VARCHAR(10)

	SELECT @Codigo = MAX(SUBSTRING(numSolicitud,5,5)) 
	FROM Presupuesto.Solicitud
	WHERE 
	LEFT(numSolicitud,4) = 	@padAnio AND LEN(numSolicitud)=8
	
	SET @p_numSolicitud = @padAnio +[Maestros].[fcnCrearCodigo](5,@Codigo)

	INSERT INTO [Presupuesto].[Solicitud]
	(numSolicitud
	,gloObservacion
	,fecSolicitada
	,indTipo
	,fecLimite
	,codEmpleadoGenera
	,codPresupuesto
	,codRegEstado
	,segUsuarioCrea
	,segFechaCrea
	,segMaquinaOrigen
	)
	VALUES
	(@p_numSolicitud
	,@p_gloObservacion
	,@p_fecSolicituda
	,@p_indTipo
	,@p_fecLimite
	,@p_codEmpleadoGenera
	,@p_codPresupuesto
	,@p_codRegEstado
	,@p_segUsuarioCrea
	,getdate()
	,@p_segMaquinaOrigen
	)
	SET @p_codSolicitud  = @@IDENTITY
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_U_Solicitud')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_U_Solicitud] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_U_Solicitud]
(
 @p_codSolicitud				int
,@p_gloObservacion           	varchar(120)
,@p_fecSolicitada              	datetime
,@p_indTipo                 	varchar(1)
,@p_fecLimite         			datetime
,@p_codEmpleadoGenera          	int
,@p_codPresupuesto				int=null
,@p_codRegEstado              	int=null
,@p_segUsuarioEdita           	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[Solicitud]
	SET 
	 gloObservacion           = 	@p_gloObservacion    
	,fecSolicitada            = 	@p_fecSolicitada     
	,indTipo                  = 	@p_indTipo           
	,fecLimite         	      = 	@p_fecLimite         
	,codEmpleadoGenera        = 	@p_codEmpleadoGenera 
	,codPresupuesto		      = 	@p_codPresupuesto		
	,codRegEstado             = 	@p_codRegEstado      
	,segUsuarioEdita          = 	@p_segUsuarioEdita
	,segMaquinaOrigen         = 	@p_segMaquinaOrigen
	,segFechaEdita			  =		getdate()
	WHERE 
	codSolicitud              = 	@p_codSolicitud
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_D_Solicitud')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_D_Solicitud] AS RETURN')
END
GO
ALTER PROCEDURE [Presupuesto].[pa_D_Solicitud]
(
 @p_codSolicitud                int
,@p_segUsuarioElimina          	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[Solicitud]
	SET
	 segUsuarioEdita  =@p_segUsuarioElimina  
	,segMaquinaOrigen =@p_segMaquinaOrigen 
	,indEliminado	  =1
	WHERE 
	[codSolicitud]        =@p_codSolicitud
END
GO
/*
 Tabla : Presupuesto.SolicitudDeta
*/
 IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_SolicitudDeta')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_SolicitudDeta] AS RETURN')
	--[Presupuesto].[pa_S_SolicitudDeta] 1,10,'codSolicitudDeta','asc',null,153
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_SolicitudDeta]
(
	 @p_codSolicitudDeta		INT=null
	,@p_codSolicitud    		INT=null
	,@p_codPlantillaDeta		INT=null
	,@p_codRegEstado			INT=null
	,@p_codPresupuesto 			INT=null
)
AS
BEGIN
		SELECT 
		 d.codSolicitudDeta
		,d.codSolicitud
		,d.codPlantillaDeta
		,d.cntCantidad
		,d.gloDescripcion
		,d.segUsuarioCrea
		,d.segUsuarioEdita
		,d.segFechaCrea
		,d.segFechaEdita
		,d.segMaquinaOrigen
		from Presupuesto.SolicitudDeta d
		inner join Presupuesto.Solicitud		s on s.codSolicitud= d.codSolicitud
		left  join Presupuesto.PlantillaDeta	p on d.codPlantillaDeta	 = p.codPlantillaDeta
		WHERE 
		ISNULL(d.codSolicitudDeta,'')	=	(CASE WHEN ISNULL(@p_codSolicitudDeta,'')<>''	
											 THEN  ISNULL(@p_codSolicitudDeta,'') 
											 ELSE ISNULL(d.codSolicitudDeta,'')	
											 END) 
		AND ISNULL(d.codSolicitud,'')	LIKE	(CASE WHEN ISNULL(@p_codSolicitud,'')<>''	
												 THEN  '%' + ISNULL(@p_codSolicitud,'') + '%' 
												 ELSE ISNULL(d.codSolicitud,'')	
											 END) 									 
		AND ISNULL(d.codPlantillaDeta,'')	LIKE	(CASE WHEN ISNULL(@p_codPlantillaDeta,'')<>''	
												 THEN  '%' + ISNULL(@p_codPlantillaDeta,'') + '%' 
												 ELSE ISNULL(d.codPlantillaDeta,'')	
											 END) 									 
		AND ISNULL(s.codRegEstado,'')	LIKE	(CASE WHEN ISNULL(@p_codRegEstado,'')<>''	
												 THEN  '%' + ISNULL(@p_codRegEstado,'') + '%' 
												 ELSE ISNULL(s.codRegEstado,'')	
											 END) 									 
		AND ISNULL(s.codPresupuesto,'')	=	(CASE WHEN ISNULL(@p_codPresupuesto,'')<>''	
												 THEN  ISNULL(@p_codPresupuesto,'') 
												 ELSE ISNULL(s.codPresupuesto,'')	
											 END) 
											 									 
		AND s.indEliminado	 = 0
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_SolicitudDetaPagina')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_SolicitudDetaPagina] AS RETURN')
	--[Presupuesto].[pa_S_SolicitudDetaPagina] 1,10,'codSolicitudDeta','asc',null
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_SolicitudDetaPagina]
(
	 @p_NumPagina				int
	,@p_TamPagina				int
	,@p_OrdenPor				varchar(30)=null
	,@p_OrdenTipo				varchar(4)=null
	,@p_codSolicitudDeta		INT=null
	,@p_codSolicitud    		INT=null
	,@p_codPlantillaDeta		INT=null
	,@p_codRegEstado			INT=null
	,@p_codPresupuesto 			INT=null
)
AS
BEGIN
	SELECT
	*
	FROM
	(	
		SELECT 
		 d.codSolicitudDeta
		,d.codSolicitud
		,d.codPlantillaDeta
		,P.gloDescripcion	codPlantillaDetaDescri
		,p.fecEjecucion
		,d.cntCantidad
		,d.gloDescripcion
		,d.segUsuarioCrea
		,d.segUsuarioEdita
		,d.segFechaCrea
		,d.segFechaEdita
		,d.segMaquinaOrigen
		,p.codEmpleadoAprueba
		,e.desApellido+', ' + e.desNombre codEmpleadoApruebaNombre
		,p.cntCantidad		cntCantidadPlantilla
		,p.numPartida
		,p.monEstimado
		,COUNT(*) OVER() AS [TOTALROWS]
	    ,ROW_NUMBER() OVER (ORDER BY CASE WHEN @p_OrdenPor = 'codPlantillaDeta'  and @p_OrdenTipo = 'ASC' 
										   THEN s.fecSolicitada
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'codPlantillaDeta'  and @p_OrdenTipo = 'DESC' 
										   THEN s.fecSolicitada
									 END DESC,	  	   
									 CASE WHEN @p_OrdenPor = 'fecEjecucion'  and @p_OrdenTipo = 'ASC'  
										  THEN p.fecEjecucion 
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'fecEjecucion'  and @p_OrdenTipo = 'DESC'  
										  THEN p.fecEjecucion
									 END DESC  
							 ) AS [ROWNUM]
		
		from Presupuesto.SolicitudDeta d
		inner join Presupuesto.Solicitud		s on s.codSolicitud= d.codSolicitud
		inner  join Presupuesto.PlantillaDeta	p on d.codPlantillaDeta	 = p.codPlantillaDeta
		left join RecursosHumanos.Empleado e on p.codEmpleadoAprueba = e.codEmpleado
		WHERE 
		ISNULL(d.codSolicitudDeta,'')	=	(CASE WHEN ISNULL(@p_codSolicitudDeta,'')<>''	
											 THEN  ISNULL(@p_codSolicitudDeta,'') 
											 ELSE ISNULL(d.codSolicitudDeta,'')	
											 END) 
		AND ISNULL(d.codSolicitud,'')	LIKE	(CASE WHEN ISNULL(@p_codSolicitud,'')<>''	
												 THEN  '%' + ISNULL(@p_codSolicitud,'') + '%' 
												 ELSE ISNULL(d.codSolicitud,'')	
											 END) 									 
		AND ISNULL(d.codPlantillaDeta,'')	LIKE	(CASE WHEN ISNULL(@p_codPlantillaDeta,'')<>''	
												 THEN  '%' + ISNULL(@p_codPlantillaDeta,'') + '%' 
												 ELSE ISNULL(d.codPlantillaDeta,'')	
											 END) 									 
		AND ISNULL(s.codRegEstado,'')	LIKE	(CASE WHEN ISNULL(@p_codRegEstado,'')<>''	
												 THEN  '%' + ISNULL(@p_codRegEstado,'') + '%' 
												 ELSE ISNULL(s.codRegEstado,'')	
											 END) 									 
		AND ISNULL(s.codPresupuesto,'')	=	(CASE WHEN ISNULL(@p_codPresupuesto,'')<>''	
												 THEN  ISNULL(@p_codPresupuesto,'') 
												 ELSE ISNULL(s.codPresupuesto,'')	
											 END) 
											 									 
		AND s.indEliminado	 = 0
	)
	AS Tabla
	WHERE ROWNUM BETWEEN (@p_NumPagina*@p_TamPagina) - @p_TamPagina + 1 
					 AND (@p_NumPagina*@p_TamPagina)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_I_SolicitudDeta')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_I_SolicitudDeta] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_I_SolicitudDeta]
(@p_codSolicitudDeta			int output
,@p_codSolicitud           		int
,@p_codPlantillaDeta           	int
,@p_cntCantidad	    			decimal(10,2)
,@p_gloDescripcion       		varchar(120)
,@p_segUsuarioCrea           	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	INSERT INTO [Presupuesto].[SolicitudDeta]
	(codSolicitud    
	,codPlantillaDeta
	,cntCantidad	    
	,gloDescripcion 
	,segFechaCrea 
	,segUsuarioCrea  
	,segMaquinaOrigen
	)
	VALUES
	(@p_codSolicitud
	,@p_codPlantillaDeta       
	,@p_cntCantidad	    	
	,@p_gloDescripcion    
	,getdate()
	,@p_segUsuarioCrea    
	,@p_segMaquinaOrigen  
	)
	SET @p_codSolicitudDeta  = @@IDENTITY
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_U_SolicitudDeta')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_U_SolicitudDeta] AS RETURN')
END
GO
ALTER  PROCEDURE [Presupuesto].[pa_U_SolicitudDeta]
(
 @p_codSolicitudDeta			int
,@p_codSolicitud           		int
,@p_codPlantillaDeta           	int
,@p_cntCantidad	    			decimal(10,2)
,@p_gloDescripcion       		varchar(120)
,@p_segUsuarioEdita           	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[SolicitudDeta]
	SET 
	 codSolicitud           = 	@p_codSolicitud      
	,codPlantillaDeta       = 	@p_codPlantillaDeta  
	,cntCantidad	    	= 	@p_cntCantidad	     
	,gloDescripcion         = 	@p_gloDescripcion    
	,segUsuarioEdita        = 	@p_segUsuarioEdita   
	,segMaquinaOrigen       = 	@p_segMaquinaOrigen 	
	,segFechaEdita			=		getdate()
	WHERE 
	codSolicitudDeta        = 	@p_codSolicitudDeta
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_D_SolicitudDeta')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_D_SolicitudDeta] AS RETURN')
END
GO
ALTER PROCEDURE [Presupuesto].[pa_D_SolicitudDeta]
(
 @p_codSolicitudDeta            int
,@p_segUsuarioElimina          	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)
)
AS
BEGIN
	UPDATE 
	[Presupuesto].[SolicitudDeta]
	SET
	 segUsuarioEdita  =@p_segUsuarioElimina  
	,segMaquinaOrigen =@p_segMaquinaOrigen 
	,indEliminado	  =1
	WHERE 
	[codSolicitudDeta]        =@p_codSolicitudDeta
END
GO

/*numDiasExtemporaneo
select * from RecursosHumanos.Empleado
select * from Presupuesto.Presupuesto

select p.numPlantilla,p.codEmpleadoElabora,e.desApellido+', '+e.desNombre,
p.codPresupuesto,pr.desNombre,p.numDiasExtemporaneo 
from Presupuesto.Plantilla p 
inner join Presupuesto.Presupuesto pr on p.codPresupuesto = pr.codPresupuesto
inner join RecursosHumanos.Empleado e on e.codempleado = p.codEmpleadoElabora
where p.codEmpleadoElabora=1

--ACTUALIZA EL REGISTRO PARA LOS DIAS DE VENCIMIENTO
UPDATE Presupuesto.Plantilla 
SET numDiasExTemporaneo=0 where codEmpleadoElabora=1 AND codPresupuesto = 4

Estados del Presupuesto
            PENDIENTE		= 1,
            APROBADO		= 2,
            DESAPROBADO		= 3,
            EN_EJECUCION	= 4,
            EJECUTADO_CERRADO = 5,
Estados de la Plantilla
            PENDIENTE		= 1,
            TERMINADA_INGRESO = 2,
            APROBADA		= 3,
            DESAPROBADA		= 4,
            EJECUTADA		= 5
Estados de la PlantillaDeta
            POR_APROBAR		= 1,
            APROBADA		= 2,
            DESAPROBADA		= 3,
            EN_EJECUCION	= 4,
            EJECUTADA		= 5
*/

/**********************************************************************************************************/
/*************************************** Scripts de Trazabilidad ******************************************/
/**********************************************************************************************************/
IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_FichaTecnicaProductoFarmacia')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_S_FichaTecnicaProductoFarmacia] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_S_FichaTecnicaProductoFarmacia]
(
 @p_codProducto			VARCHAR(10)=null
)
AS
BEGIN
	SELECT 
	 pf.codigoFichaTecProducto
	,pf.aprobar
	,pf.codigoFichaTecProveedor 
	,pf.codigoProcedimiento
	,pf.descripcion
	,pf.etiquetado
	,pf.nombre
	,pf.posologia 
	,pf.procedimiemtoDistribucion
	,pf.procedimientoAlmacen
	,pf.procedimientoVenta
	,pf.quimicoFarmaceutico
	from Trazabilidad.FichaTecnicaProductoFarmacia pf
	WHERE 
	ISNULL(pf.codigoFichaTecProducto,'')	=	isnull(@p_codProducto,'0')
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_HojaMerma')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_S_HojaMerma] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_S_HojaMerma]
(
 @p_codProducto			VARCHAR(10)=null
,@p_fechaIni	        DATETIME
,@p_fechaFin			DATETIME
)
AS
BEGIN
	SELECT 
	 hm.codigoProducto 
	,hm.cantidadInsumo
	,hm.fecha
	,hm.motivo
	,hm.numeroHojaMerma	
	from Trazabilidad.HojaMerma hm
	WHERE 
	ISNULL(hm.codigoProducto,'')	=	(CASE WHEN ISNULL(@p_codProducto,'')<>''	
									 THEN  ISNULL(@p_codProducto,'') 
									 ELSE ISNULL(hm.codigoProducto,'')	
								 END) 
	AND convert(varchar(8),hm.fecha,112)>= CONVERT(varchar(8),@p_fechaIni,112)
	AND convert(varchar(8),hm.fecha,112)<= CONVERT(varchar(8),@p_fechaFin,112)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_InformeVenta')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_S_InformeVenta] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_S_InformeVenta]
(
 @p_codProducto			VARCHAR(10)=null
,@p_fechaIni	        DATETIME=null
,@p_fechaFin			DATETIME=null
)
AS
BEGIN
	SELECT 
	 iv.codigoVenta
	,iv.fechaVenta
	,iv.nombreProducto 
	,iv.cantidad
	,iv.codigoProducto
	,iv.precio
	,iv.nombreCliente	
	from Trazabilidad.InformeVenta iv
	WHERE 
	ISNULL(iv.codigoProducto,'')	=	(CASE WHEN ISNULL(@p_codProducto,'')<>''	
									 THEN  ISNULL(@p_codProducto,'') 
									 ELSE ISNULL(iv.codigoProducto,'')	
								 END) 
	AND convert(varchar(8),iv.fechaVenta,112)>= CONVERT(varchar(8),@p_fechaIni,112)
	AND convert(varchar(8),iv.fechaVenta,112)<= CONVERT(varchar(8),@p_fechaFin,112)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Kardex')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_S_Kardex] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_S_Kardex]
(
 @p_codProducto			VARCHAR(10)=null
,@p_fechaIni	        DATETIME
,@p_fechaFin			DATETIME
)
AS
BEGIN
	SELECT 
	 k.codigoProducto
	,k.fecha
	,k.ingreso 
	,k.numeroKardex
	,k.observaciones
	,k.saldos
	,k.salidas
	from Trazabilidad.Kardex k
	WHERE 
	ISNULL(k.codigoProducto,'')	=	(CASE WHEN ISNULL(@p_codProducto,'')<>''	
									 THEN  ISNULL(@p_codProducto,'') 
									 ELSE ISNULL(k.codigoProducto,'')	
								 END) 
	AND convert(varchar(8),k.fecha,112)>= CONVERT(varchar(8),@p_fechaIni,112)
	AND convert(varchar(8),k.fecha,112)<= CONVERT(varchar(8),@p_fechaFin,112)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_LibroReceta')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_S_LibroReceta] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_S_LibroReceta]
(
 @p_codProducto			VARCHAR(10)=null
,@p_fechaIni	        DATETIME
,@p_fechaFin			DATETIME
)
AS
BEGIN
	SELECT 
	 lr.codigoProducto 
	,lr.fechaProducto
	,lr.nombreProducto
	,lr.quimicoLaboratorista	
	from Trazabilidad.LibroReceta lr
	WHERE 
	ISNULL(lr.codigoProducto,'')	=	(CASE WHEN ISNULL(@p_codProducto,'')<>''	
									 THEN  ISNULL(@p_codProducto,'') 
									 ELSE ISNULL(lr.codigoProducto,'')	
								 END) 
	AND convert(varchar(8),lr.fechaproducto,112)>= CONVERT(varchar(8),@p_fechaIni,112)
	AND convert(varchar(8),lr.fechaProducto,112)<= CONVERT(varchar(8),@p_fechaFin,112)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_OrdendeCompra')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_S_OrdendeCompra] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_S_OrdendeCompra]
(
 @p_codProducto			VARCHAR(10)=null
,@p_fechaIni	        DATETIME
,@p_fechaFin			DATETIME
)
AS
BEGIN
	SELECT 
	 oc.cantidad 
	,oc.codigoCompra
	,oc.codigoProducto 
	,oc.costo 
	,oc.fechaCompra 
	,oc.nombreProducto 
	,oc.nombreProveedor 
	from Trazabilidad.OrdenDeCompra oc
	WHERE 
	ISNULL(oc.codigoProducto,'')	=	(CASE WHEN ISNULL(@p_codProducto,'')<>''	
									 THEN  ISNULL(@p_codProducto,'') 
									 ELSE ISNULL(oc.codigoProducto,'')	
								 END) 
	AND convert(varchar(8),oc.fechaCompra,112)>= CONVERT(varchar(8),@p_fechaIni,112)
	AND convert(varchar(8),oc.fechaCompra,112)<= CONVERT(varchar(8),@p_fechaFin,112)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_OrdenDeDespacho')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_S_OrdenDeDespacho] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_S_OrdenDeDespacho]
(
 @p_codProducto			VARCHAR(10)=null
,@p_fechaIni	        DATETIME
,@p_fechaFin			DATETIME
)
AS
BEGIN
	SELECT 
	 od.codigoProducto 
	,od.fecha
	,od.numeroOrden 
	,od.observaciones 
	,od.pesoTotal 
	,od.totalPedidos 
	from Trazabilidad.OrdenDeDespacho od
	WHERE 
	ISNULL(od.codigoProducto,'')	=	(CASE WHEN ISNULL(@p_codProducto,'')<>''	
									 THEN  ISNULL(@p_codProducto,'') 
									 ELSE ISNULL(od.codigoProducto,'')	
								 END) 
	AND convert(varchar(8),od.fecha,112)>= CONVERT(varchar(8),@p_fechaIni,112)
	AND convert(varchar(8),od.fecha,112)<= CONVERT(varchar(8),@p_fechaFin,112)
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_Producto')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_S_Producto] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_S_Producto]
(
 @p_codProducto			VARCHAR(10)=null
,@p_nomProducto	        VARCHAR(50)=null
)
AS
BEGIN
	SELECT 
	 p.codigoProducto
	,p.descripcion
	,p.nombreProducto 
	,p.pesoProducto
	,p.presentacion
	,p.tipoProducto	
	from Trazabilidad.Producto p
	WHERE 
	ISNULL(p.codigoProducto,'')	=	(CASE WHEN ISNULL(@p_codProducto,'')<>''	
									 THEN  ISNULL(@p_codProducto,'') 
									 ELSE ISNULL(p.codigoProducto,'')	
								 END) 
	OR P.nombreProducto LIKE '%' +@p_nomProducto +'%'
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_U_FichaTecnicaProductoFarmacia')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_U_FichaTecnicaProductoFarmacia] AS RETURN')
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_U_FichaTecnicaProductoFarmacia')
BEGIN
	EXEC('CREATE PROCEDURE [Trazabilidad].[pa_U_FichaTecnicaProductoFarmacia] AS RETURN')
END
GO

ALTER PROCEDURE [Trazabilidad].[pa_U_FichaTecnicaProductoFarmacia]
(
 @p_codigoFichaTecProducto		varchar(10)
,@p_nombre         				varchar(10)
,@p_descripcion           		varchar(10)
,@p_etiquetado              	varchar(10)
,@p_procedimientoAlmacen        varchar(255)
,@p_procedimientoVenta          varchar(255)
,@p_procedimiemtoDistribucion   varchar(255)
,@p_posologia          			varchar(50)
,@p_quimicoFarmaceutico        	varchar(10)
,@p_aprobar						varchar(10)
)
AS
BEGIN
	UPDATE 
	[Trazabilidad].[FichaTecnicaProductoFarmacia]
	SET 
	 nombre=@p_nombre    
	,descripcion=@p_descripcion           		
	,etiquetado=@p_etiquetado              	
	,procedimientoAlmacen=@p_procedimientoAlmacen        
	,procedimientoVenta=@p_procedimientoVenta          
	,procedimiemtoDistribucion=@p_procedimiemtoDistribucion   
	,posologia=@p_posologia          			
	,quimicoFarmaceutico =@p_quimicoFarmaceutico        	
	,aprobar=@p_aprobar						
	WHERE 
	codigoFichaTecProducto       = @p_codigoFichaTecProducto
END
GO

USE BD_ByS
GO

/*Select * from RecursosHumanos.Area*/
insert into RecursosHumanos.Area (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Contabilidad', 'CONTA', 1,'ocarril',getdate());
insert into RecursosHumanos.Area (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Marketing', 'MARKE', 1,'ocarril',getdate());
insert into RecursosHumanos.Area (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Recursos Humanos', 'RRHH', 1,'ocarril',getdate());
insert into RecursosHumanos.Area (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Logistica', 'LOGIS', 1,'ocarril',getdate());
insert into RecursosHumanos.Area (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Presupuesto', 'PRESU', 1,'ocarril',getdate());
insert into RecursosHumanos.Area (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Almacen', 'ALMC', 1,'ocarril',getdate());
GO

--Select * from RecursosHumanos.Area
--delete RecursosHumanos.Area
--DBCC CHECKIDENT ('[RecursosHumanos].[Area]', RESEED,0)

insert into RecursosHumanos.Cargo (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Responsable de Contabilidad', 'RESPCONTA', 1,'ocarril',getdate());
insert into RecursosHumanos.Cargo (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Responsable de Marketing', 'RESPMARKE', 1,'ocarril',getdate());
insert into RecursosHumanos.Cargo (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Responsable de Recursos Humanos', 'RESPRRHH', 1,'ocarril',getdate());
insert into RecursosHumanos.Cargo (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Responsable de Logistica', 'RESPLOGIS', 1,'ocarril',getdate());
insert into RecursosHumanos.Cargo (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Responsable de Presupuesto', 'RESPPRESU', 1,'ocarril',getdate());
insert into RecursosHumanos.Cargo (desNombre, gloDescripcion,indActivo,segUsuarioCrea,segFechaCrea) values
('Responsable de Almacen', 'RESPALMC', 1,'ocarril',getdate());
GO

/*
SELECT * FROM RecursosHumanos.Cargo
*/
/*
SELECT * FROM RecursosHumanos.Empleado

ALTER TABLE RecursosHumanos.Empleado
ALTER COLUMN desNombre VARCHAR(40);

ALTER TABLE RecursosHumanos.Empleado
ALTER COLUMN desApellido VARCHAR(40);

ALTER TABLE RecursosHumanos.Empleado
ADD desLogin VARCHAR(50);

ALTER TABLE RecursosHumanos.Empleado
ADD clvPassword nVARCHAR(250);

delete select * from RecursosHumanos.Empleado
*/
--DBCC CHECKIDENT ('[RecursosHumanos].[Empleado]', RESEED,0)

insert into RecursosHumanos.Empleado (codPersona,codCargo,codArea,desNombre,desApellido, indActivo,segUsuarioCrea,segFechaCrea,desLogin,clvPassword) values
(1,1,1,'Orlando','Carril', 1,'ocarril',getdate(),'ocr','ocr');
insert into RecursosHumanos.Empleado (codPersona,codCargo,codArea,desNombre, desApellido,indActivo,segUsuarioCrea,segFechaCrea,desLogin,clvPassword) values
(1,2,2,'Aarón', 'Sarmiento', 1,'ocarril',getdate(),'ass','ass');
insert into RecursosHumanos.Empleado (codPersona,codCargo,codArea,desNombre, desApellido,indActivo,segUsuarioCrea,segFechaCrea,desLogin,clvPassword) values
(1,3,3,'Walter', 'Rodriguez', 1,'ocarril',getdate(),'wrf','wrf');
insert into RecursosHumanos.Empleado (codPersona,codCargo,codArea,desNombre, desApellido,indActivo,segUsuarioCrea,segFechaCrea,desLogin,clvPassword) values
(1,4,4,'Henry', 'Vásquez', 1,'ocarril',getdate(),'hvt','hvt');
insert into RecursosHumanos.Empleado (codPersona,codCargo,codArea,desNombre, desApellido,indActivo,segUsuarioCrea,segFechaCrea,desLogin,clvPassword) values
(1,5,5,'Hector', 'Caiguaraico', 1,'ocarril',getdate(),'hcc','123');
insert into RecursosHumanos.Empleado (codPersona,codCargo,codArea,desNombre, desApellido,indActivo,segUsuarioCrea,segFechaCrea,desLogin,clvPassword) values
(1,6,6,'Danielito', 'Collazos', 1,'ocarril',getdate(),'dcm','dcm');
GO

--UPDATE RecursosHumanos.Empleado SET desLogin='ocarril', clvPassword='ocarril'WHERE codEmpleado=1
--UPDATE RecursosHumanos.Empleado SET desLogin='joncebay', clvPassword='joncebay'WHERE codEmpleado=2
--UPDATE RecursosHumanos.Empleado SET desLogin='wrodriguez', clvPassword='wrodriguez'WHERE codEmpleado=3
--UPDATE RecursosHumanos.Empleado SET desLogin='hvasquez', clvPassword='hvasquez'WHERE codEmpleado=4
--UPDATE RecursosHumanos.Empleado SET desLogin='crivas', clvPassword='crivas'WHERE codEmpleado=5
--UPDATE RecursosHumanos.Empleado SET desLogin='dcollazos', clvPassword='dcollazos'WHERE codEmpleado=6
--GO

/*Presupuesto.Partida
select * from Presupuesto.Partida
*/
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Gastos de Personal','100501',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Construcciones','100502',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Mobiliario','100503',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Materiales de Oficina','100504',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Comunicacion Inst. Publicidad','100505',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Sumninistros de Agua','200601',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Sumninistros de Luz','200602',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Limpieza y Aseo','200603',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Mensajeria','200604',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Reuniones Conferencias cursos','200605',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Gastos Financieros','300501',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Telecomunaciones','300502',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Sistemas informáticos','300503',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Pasajes al interior','300504',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Espec. Culturales y sociales','300505',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Honorarios','500501',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Transporte de personal','500502',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Vehiculos','500503',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Servicio de auditoria','500504',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Compra de mercaderias','500505',1,'ocarril',getdate());
INSERT INTO Presupuesto.Partida(desNombre,codNumero,indActivo,segUsuarioCrea,segFechaCrea)values
('Seguros','600108',1,'ocarril',getdate());
GO

/*Presupuesto.Presupuesto
select * from Presupuesto.Presupuesto
delete Presupuesto.Presupuesto
DBCC CHECKIDENT ('Presupuesto.Presupuesto', RESEED,0)
*/
INSERT INTO Presupuesto.Presupuesto
(desNombre,numAnio,fecInicio,fecCierre,codRegEstado,segUsuarioCrea,segFechaCrea) values
('Presupuesto 2013',2013,cast('06/06/2012' as datetime),cast('11/11/2012' as datetime),5,'ocarril',getdate());

INSERT INTO Presupuesto.Presupuesto
(desNombre,numAnio,fecInicio,fecCierre,codRegEstado,segUsuarioCrea,segFechaCrea) values
('Presupuesto 2014',2014,cast('06/06/2013' as datetime),cast('11/11/2013' as datetime),5,'ocarril',getdate());

INSERT INTO Presupuesto.Presupuesto
(desNombre,numAnio,fecInicio,fecCierre,codRegEstado,segUsuarioCrea,segFechaCrea) values
('Presupuesto 2015',2015,cast('06/06/2014' as datetime),cast('11/11/2014' as datetime),5,'ocarril',getdate());

INSERT INTO Presupuesto.Presupuesto
(desNombre,numAnio,fecInicio,fecCierre,codRegEstado,segUsuarioCrea,segFechaCrea) values
('Presupuesto 2016',2016,cast('06/06/2015' as datetime),cast('12/12/2015' as datetime),4,'ocarril',getdate());
GO

INSERT INTO Presupuesto.Presupuesto
(desNombre,numAnio,fecInicio,fecCierre,codRegEstado,segUsuarioCrea,segFechaCrea) values
('Presupuesto 2017',2017,cast('01/01/2016' as datetime),cast('03/10/2016' as datetime),1,'ocarril',getdate());
GO

/*
select * from Presupuesto.Presupuesto
Presupuesto.PresupuestoArea
SELECT * FROM Presupuesto.PresupuestoArea*/
/*2013*/
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(1,1,15000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(1,2,35000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(1,3,30000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(1,4,21000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(1,5,22000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(1,6,25000,1,'OCARRIL', GETDATE());
/*2014*/
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(2,1,22000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(2,2,31000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(2,3,33000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(2,4,24000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(2,5,26000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(2,6,28000,1,'OCARRIL', GETDATE());
/*2015*/
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(3,1,27000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(3,2,32000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(3,3,36000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(3,4,27000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(3,5,29000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(3,6,32000,1,'OCARRIL', GETDATE());
/*2016*/
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(4,1,18000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(4,2,33000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(4,3,37000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(4,4,23000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(4,5,27000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(4,6,29000,1,'OCARRIL', GETDATE());
GO

/*2017*/
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(5,1,35000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(5,2,31000,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(5,3,39500,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(5,4,37800,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(5,5,37080,1,'OCARRIL', GETDATE());
INSERT INTO Presupuesto.PresupuestoArea
(codPresupuesto,codArea,monMaximo,indActivo,segUsuarioCrea,segFechaCrea) VALUES
(5,6,39700,1,'OCARRIL', GETDATE());
GO

/*
drop table Presupuesto.Solicitud
select * from recursoshumanos.empleado
select * from Presupuesto.Solicitud
*/
INSERT INTO Presupuesto.Solicitud
(numSolicitud,gloObservacion,fecSolicitada,codEmpleadoGenera,indTipo,fecLimite,codRegEstado,segUsuarioCrea,segFechaCrea) VALUES
('2012-01','Se solicita la elaboracion del presupuesto para 2013',cast('05/06/2012' as datetime),1,'E',cast('06/06/2013' as datetime),3,'ocarril',getdate());
INSERT INTO Presupuesto.Solicitud
(numSolicitud,gloObservacion,fecSolicitada,codEmpleadoGenera,indTipo,fecLimite,codRegEstado,segUsuarioCrea,segFechaCrea) VALUES
('2013-01','Se solicita la elaboracion del presupuesto para 2014',cast('05/06/2013' as datetime),1,'E',cast('06/06/2013' as datetime),3,'ocarril',getdate());
INSERT INTO Presupuesto.Solicitud
(numSolicitud,gloObservacion,fecSolicitada,codEmpleadoGenera,indTipo,fecLimite,codRegEstado,segUsuarioCrea,segFechaCrea) VALUES
('2014-01','Se solicita la elaboracion del presupuesto para 2015',cast('05/06/2014' as datetime),1,'E',cast('06/06/2014' as datetime),3,'ocarril',getdate());
INSERT INTO Presupuesto.Solicitud
(numSolicitud,gloObservacion,fecSolicitada,codEmpleadoGenera,indTipo,fecLimite,codRegEstado,segUsuarioCrea,segFechaCrea) VALUES
('2015-01','Se solicita la elaboracion del presupuesto para 2016',cast('05/06/2015' as datetime),1,'E',cast('06/06/2015' as datetime),3,'ocarril',getdate());
INSERT INTO Presupuesto.Solicitud
(numSolicitud,gloObservacion,fecSolicitada,codEmpleadoGenera,indTipo,fecLimite,codRegEstado,segUsuarioCrea,segFechaCrea) VALUES
('2016-01','Se solicita la elaboracion del presupuesto para 2017',cast('01/01/2016' as datetime),1,'E',cast('02/03/2015' as datetime),3,'ocarril',getdate());
GO

/*PLANTILLAS DE AÑOS ANTERIORES: Presupuesto.Plantilla
SELECT * FROM Presupuesto.Plantilla 
SELECT * FROM Presupuesto.PlantillaDeta
TRUNCATE TABLE Presupuesto.Plantilla
TRUNCATE TABLE Presupuesto.PlantillaDeta*/
/*AÑO : 2013*/
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2013CONT01',5,1,1,1,3,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2013MARK01',5,2,1,1,2,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2013RRHH01',5,3,1,1,3,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2013LOGI01',5,4,1,1,4,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2013PRES01',5,5,1,1,5,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2013ALMC01',5,6,1,1,6,'ocarril',getdate());
GO

/*Area01*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 001',4200,1,5,cast('09/06/2013' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 002',4600,1,5,cast('01/06/2013' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 003',4700,1,5,cast('02/06/2013' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 004',3070,1,5,cast('03/06/2013' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 005',2090,1,5,cast('04/06/2013' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 006',3070,1,5,cast('05/06/2013' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 007',1080,1,5,cast('06/06/2013' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 008',8080,1,5,cast('07/06/2013' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 009',2080,1,5,cast('08/06/2013' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 010',3500,1,5,cast('10/06/2013' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 011',4520,1,5,cast('11/06/2013' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(1,1,'Glosa Descripcion 012',2500,1,5,cast('12/06/2013' as datetime),'N',1,'5567788','ocarril',getdate());
GO
/*Area02*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 001',4000,1,5,cast('09/06/2013' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 002',6000,1,5,cast('01/06/2013' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 003',5000,1,5,cast('02/06/2013' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 004',6000,1,5,cast('03/06/2013' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 005',3000,1,5,cast('04/06/2013' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 006',4000,1,5,cast('05/06/2013' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 007',7000,1,5,cast('06/06/2013' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 008',2000,1,5,cast('07/06/2013' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 009',3000,1,5,cast('08/06/2013' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 010',5000,1,5,cast('10/06/2013' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 011',6000,1,5,cast('11/06/2013' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(2,2,'Glosa Descripcion 012',7000,1,5,cast('12/06/2013' as datetime),'N',1,'5567788','ocarril',getdate());
GO
/*Area03*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 001',4000,1,5,cast('09/06/2013' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 002',6000,1,5,cast('01/06/2013' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 003',5000,1,5,cast('02/06/2013' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 004',6000,1,5,cast('03/06/2013' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 005',3000,1,5,cast('04/06/2013' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 006',4000,1,5,cast('05/06/2013' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 007',7000,1,5,cast('06/06/2013' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 008',2000,1,5,cast('07/06/2013' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 009',3000,1,5,cast('08/06/2013' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 010',5000,1,5,cast('10/06/2013' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 011',6000,1,5,cast('11/06/2013' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(3,3,'Glosa Descripcion 012',7000,1,5,cast('12/06/2013' as datetime),'N',1,'5567788','ocarril',getdate());
/*Area04 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 001',4000,1,5,cast('09/06/2013' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 002',6000,1,5,cast('01/06/2013' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 003',5000,1,5,cast('02/06/2013' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 004',6070,1,5,cast('03/06/2013' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 005',3070,1,5,cast('04/06/2013' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 006',4080,1,5,cast('05/06/2013' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 007',7800,1,5,cast('06/06/2013' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 008',2000,1,5,cast('07/06/2013' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 009',3000,1,5,cast('08/06/2013' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 010',5500,1,5,cast('10/06/2013' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 011',6000,1,5,cast('11/06/2013' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(4,4,'Glosa Descripcion 012',7000,1,5,cast('12/06/2013' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area05 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 001',4000,1,5,cast('09/06/2013' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 002',6090,1,5,cast('01/06/2013' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 003',5070,1,5,cast('02/06/2013' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 004',60340,1,5,cast('03/06/2013' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 005',3020,1,5,cast('04/06/2013' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 006',4040,1,5,cast('05/06/2013' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 007',7060,1,5,cast('06/06/2013' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 008',2050,1,5,cast('07/06/2013' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 009',3030,1,5,cast('08/06/2013' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 010',5030,1,5,cast('10/06/2013' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 011',6040,1,5,cast('11/06/2013' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(5,5,'Glosa Descripcion 012',7030,1,5,cast('12/06/2013' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area06 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 001',4800,1,5,cast('09/06/2013' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 002',6700,1,5,cast('01/06/2013' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 003',5040,1,5,cast('02/06/2013' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 004',6040,1,5,cast('03/06/2013' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 005',3030,1,5,cast('04/06/2013' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 006',4070,1,5,cast('05/06/2013' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 007',7040,1,5,cast('06/06/2013' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 008',2000,1,5,cast('07/06/2013' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 009',3000,1,5,cast('08/06/2013' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 010',5040,1,5,cast('10/06/2013' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 011',6060,1,5,cast('11/06/2013' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(6,6,'Glosa Descripcion 012',7050,1,5,cast('12/06/2013' as datetime),'N',1,'5567788','ocarril',getdate());

/*AÑO : 2014*/
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2014CONT01',5,1,2,2,3,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2014MARK01',5,2,2,2,2,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2014RRHH01',5,3,2,2,3,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2014LOGI01',5,4,2,2,4,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2014PRES01',5,5,2,2,5,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2014ALMC01',5,6,2,2,6,'ocarril',getdate());
GO
/*Area01*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 001',4050,1,5,cast('09/06/2014' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 002',5500,1,5,cast('01/06/2014' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 003',4040,1,5,cast('02/06/2014' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 004',4700,1,5,cast('03/06/2014' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 005',6030,1,5,cast('04/06/2014' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 006',4800,1,5,cast('05/06/2014' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 007',5600,1,5,cast('06/06/2014' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 008',8300,1,5,cast('07/06/2014' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 009',7200,1,5,cast('08/06/2014' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 010',8020,1,5,cast('10/06/2014' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 011',5200,1,5,cast('11/06/2014' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(7,1,'Glosa Descripcion 012',7600,1,5,cast('12/06/2014' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area02*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 001',4000,1,5,cast('09/06/2014' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 002',6000,1,5,cast('01/06/2014' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 003',5000,1,5,cast('02/06/2014' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 004',6000,1,5,cast('03/06/2014' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 005',3000,1,5,cast('04/06/2014' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 006',4000,1,5,cast('05/06/2014' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 007',7000,1,5,cast('06/06/2014' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 008',2000,1,5,cast('07/06/2014' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 009',3000,1,5,cast('08/06/2014' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 010',5000,1,5,cast('10/06/2014' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 011',6000,1,5,cast('11/06/2014' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(8,2,'Glosa Descripcion 012',7000,1,5,cast('12/06/2014' as datetime),'N',1,'5567788','ocarril',getdate());
/*Area03*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 001',4000,1,5,cast('09/06/2014' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 002',6000,1,5,cast('01/06/2014' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 003',5000,1,5,cast('02/06/2014' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 004',6000,1,5,cast('03/06/2014' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 005',3000,1,5,cast('04/06/2014' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 006',4000,1,5,cast('05/06/2014' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 007',7000,1,5,cast('06/06/2014' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 008',2000,1,5,cast('07/06/2014' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 009',3000,1,5,cast('08/06/2014' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 010',5000,1,5,cast('10/06/2014' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 011',6000,1,5,cast('11/06/2014' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(9,3,'Glosa Descripcion 012',7000,1,5,cast('12/06/2014' as datetime),'N',1,'5567788','ocarril',getdate());
/*Area04 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 001',4000,1,5,cast('09/06/2014' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 002',6000,1,5,cast('01/06/2014' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 003',5000,1,5,cast('02/06/2014' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 004',6000,1,5,cast('03/06/2014' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 005',3000,1,5,cast('04/06/2014' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 006',4000,1,5,cast('05/06/2014' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 007',7000,1,5,cast('06/06/2014' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 008',2000,1,5,cast('07/06/2014' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 009',3000,1,5,cast('08/06/2014' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 010',5000,1,5,cast('10/06/2014' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 011',6000,1,5,cast('11/06/2014' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(10,4,'Glosa Descripcion 012',7000,1,5,cast('12/06/2014' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area05 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 001',4000,1,5,cast('09/06/2014' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 002',6000,1,5,cast('01/06/2014' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 003',5000,1,5,cast('02/06/2014' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 004',6000,1,5,cast('03/06/2014' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 005',3000,1,5,cast('04/06/2014' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 006',4000,1,5,cast('05/06/2014' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 007',7000,1,5,cast('06/06/2014' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 008',2000,1,5,cast('07/06/2014' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 009',3000,1,5,cast('08/06/2014' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 010',5000,1,5,cast('10/06/2014' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 011',6000,1,5,cast('11/06/2014' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(11,5,'Glosa Descripcion 012',7000,1,5,cast('12/06/2014' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area06 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 001',4000,1,5,cast('09/06/2014' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 002',6000,1,5,cast('01/06/2014' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 003',5000,1,5,cast('02/06/2014' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 004',6000,1,5,cast('03/06/2014' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 005',3000,1,5,cast('04/06/2014' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 006',4000,1,5,cast('05/06/2014' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 007',7000,1,5,cast('06/06/2014' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 008',2000,1,5,cast('07/06/2014' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 009',3000,1,5,cast('08/06/2014' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 010',5000,1,5,cast('10/06/2014' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 011',6000,1,5,cast('11/06/2014' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(12,6,'Glosa Descripcion 012',7000,1,5,cast('12/06/2014' as datetime),'N',1,'5567788','ocarril',getdate());

/*AÑO : 2015*/
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015CONT01',3,1,3,3,3,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015MARK01',3,2,3,3,2,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015RRHH01',3,3,3,3,3,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015LOGI01',3,4,3,3,4,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015PRES01',3,5,3,3,5,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015ALMC01',3,6,3,3,6,'ocarril',getdate());
GO

/*Area01*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 001',4200,1,5,cast('09/06/2015' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 002',4600,1,5,cast('01/06/2015' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 003',4700,1,5,cast('02/06/2015' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 004',3070,1,5,cast('03/06/2015' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 005',2090,1,5,cast('04/06/2015' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 006',3070,1,5,cast('05/06/2015' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 007',1080,1,5,cast('06/06/2015' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 008',8080,1,5,cast('07/06/2015' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 009',2080,1,5,cast('08/06/2015' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 010',3500,1,5,cast('10/06/2015' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 011',4520,1,5,cast('11/06/2015' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(13,1,'Glosa Descripcion 012',2500,1,5,cast('12/06/2015' as datetime),'N',1,'5567788','ocarril',getdate());
GO
/*Area02*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 001',4050,1,5,cast('09/06/2015' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 002',6090,1,5,cast('01/06/2015' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 003',5010,1,5,cast('02/06/2015' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 004',6080,1,5,cast('03/06/2015' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 005',3030,1,5,cast('04/06/2015' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 006',4020,1,5,cast('05/06/2015' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 007',7000,1,5,cast('06/06/2015' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 008',2000,1,5,cast('07/06/2015' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 009',3033,1,5,cast('08/06/2015' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 010',5023,1,5,cast('10/06/2015' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 011',6056,1,5,cast('11/06/2015' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(14,2,'Glosa Descripcion 012',7022,1,5,cast('12/06/2015' as datetime),'N',1,'5567788','ocarril',getdate());
GO
/*Area03*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 001',4000,1,5,cast('09/06/2015' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 002',6000,1,5,cast('01/06/2015' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 003',5000,1,5,cast('02/06/2015' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 004',6000,1,5,cast('03/06/2015' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 005',3000,1,5,cast('04/06/2015' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 006',4000,1,5,cast('05/06/2015' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 007',7000,1,5,cast('06/06/2015' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 008',2000,1,5,cast('07/06/2015' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 009',3000,1,5,cast('08/06/2015' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 010',5000,1,5,cast('10/06/2015' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 011',6000,1,5,cast('11/06/2015' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(15,3,'Glosa Descripcion 012',7000,1,5,cast('12/06/2015' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area04 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 001',4000,1,5,cast('09/06/2015' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 002',6600,1,5,cast('01/06/2015' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 003',5100,1,5,cast('02/06/2015' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 004',6010,1,5,cast('03/06/2015' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 005',3070,1,5,cast('04/06/2015' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 006',4070,1,5,cast('05/06/2015' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 007',7300,1,5,cast('06/06/2015' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 008',2200,1,5,cast('07/06/2015' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 009',3050,1,5,cast('08/06/2015' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 010',5020,1,5,cast('10/06/2015' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 011',6030,1,5,cast('11/06/2015' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(16,4,'Glosa Descripcion 012',7000,1,5,cast('12/06/2015' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area05 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 001',4030,1,5,cast('09/06/2015' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 002',6700,1,5,cast('01/06/2015' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 003',5010,1,5,cast('02/06/2015' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 004',62000,1,5,cast('03/06/2015' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 005',3080,1,5,cast('04/06/2015' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 006',4020,1,5,cast('05/06/2015' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 007',7060,1,5,cast('06/06/2015' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 008',2030,1,5,cast('07/06/2015' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 009',3700,1,5,cast('08/06/2015' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 010',5100,1,5,cast('10/06/2015' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 011',6040,1,5,cast('11/06/2015' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(17,5,'Glosa Descripcion 012',7060,1,5,cast('12/06/2015' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area06 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 001',4900,1,5,cast('09/06/2015' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 002',6600,1,5,cast('01/06/2015' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 003',5400,1,5,cast('02/06/2015' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 004',6500,1,5,cast('03/06/2015' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 005',3200,1,5,cast('04/06/2015' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 006',4500,1,5,cast('05/06/2015' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 007',7400,1,5,cast('06/06/2015' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 008',2300,1,5,cast('07/06/2015' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 009',3200,1,5,cast('08/06/2015' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 010',5020,1,5,cast('10/06/2015' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 011',6030,1,5,cast('11/06/2015' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(18,6,'Glosa Descripcion 012',7040,1,5,cast('12/06/2015' as datetime),'N',1,'5567788','ocarril',getdate());

/*
select * from [RecursosHumanos].[Empleado]
select * from [Presupuesto].[Plantilla]
*/
/*AÑO : 2016*/
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015CONT01',3,1,4,4,1,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015MARK01',3,2,4,4,2,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015RRHH01',3,3,4,4,3,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015LOGI01',3,4,4,4,4,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015PRES01',3,5,4,4,5,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2015ALMC01',3,6,4,4,6,'ocarril',getdate());
GO

/*Area01*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 001',8500,1,5,cast('09/06/2016' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 002',1600,1,5,cast('01/06/2016' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 003',2700,1,5,cast('02/06/2016' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 004',4070,1,5,cast('03/06/2016' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 005',1090,1,5,cast('04/06/2016' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 006',2070,1,5,cast('05/06/2016' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 007',8080,1,5,cast('06/06/2016' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 008',1080,1,2,cast('07/06/2016' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 009',3080,1,4,cast('08/06/2016' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 010',1500,1,2,cast('10/06/2016' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 011',3520,1,4,cast('11/06/2016' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(19,1,'Glosa Descripcion 012',3500,1,2,cast('12/06/2016' as datetime),'N',1,'5567788','ocarril',getdate());
GO
/*Area02*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 001',4050,1,5,cast('09/06/2016' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 002',6090,1,5,cast('01/06/2016' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 003',5010,1,5,cast('02/06/2016' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 004',6080,1,5,cast('03/06/2016' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 005',3030,1,5,cast('04/06/2016' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 006',4020,1,5,cast('05/06/2016' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 007',7000,1,5,cast('06/06/2016' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 008',2000,1,4,cast('07/06/2016' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 009',3033,1,2,cast('08/06/2016' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 010',5023,1,2,cast('10/06/2016' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 011',6056,1,4,cast('11/06/2016' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(20,2,'Glosa Descripcion 012',7022,1,2,cast('12/06/2016' as datetime),'N',1,'5567788','ocarril',getdate());
GO
/*Area03*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 001',4000,1,5,cast('09/06/2016' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 002',6000,1,5,cast('01/06/2016' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 003',5000,1,5,cast('02/06/2016' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 004',6000,1,5,cast('03/06/2016' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 005',3000,1,5,cast('04/06/2016' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 006',4000,1,5,cast('05/06/2016' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 007',7000,1,5,cast('06/06/2016' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 008',2000,1,4,cast('07/06/2016' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 009',3000,1,2,cast('08/06/2016' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 010',5000,1,4,cast('10/06/2016' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 011',6000,1,2,cast('11/06/2016' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(21,3,'Glosa Descripcion 012',7000,1,2,cast('12/06/2016' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area04 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 001',4000,1,5,cast('09/06/2016' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 002',6600,1,5,cast('01/06/2016' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 003',5100,1,5,cast('02/06/2016' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 004',6010,1,5,cast('03/06/2016' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 005',3070,1,5,cast('04/06/2016' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 006',4070,1,5,cast('05/06/2016' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 007',7300,1,5,cast('06/06/2016' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 008',2200,1,4,cast('07/06/2016' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 009',3050,1,2,cast('08/06/2016' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 010',5020,1,4,cast('10/06/2016' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 011',6030,1,2,cast('11/06/2016' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(22,4,'Glosa Descripcion 012',7000,1,2,cast('12/06/2016' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area05 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 001',4030,1,5,cast('09/06/2016' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 002',6700,1,5,cast('01/06/2016' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 003',5010,1,5,cast('02/06/2016' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 004',6200,1,5,cast('03/06/2016' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 005',3080,1,5,cast('04/06/2016' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 006',4020,1,5,cast('05/06/2016' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 007',7060,1,5,cast('06/06/2016' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 008',2030,1,2,cast('07/06/2016' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 009',3700,1,4,cast('08/06/2016' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 010',5100,1,4,cast('10/06/2016' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 011',6040,1,2,cast('11/06/2016' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(23,5,'Glosa Descripcion 012',7060,1,2,cast('12/06/2016' as datetime),'N',1,'5567788','ocarril',getdate());

/*Area06 select * from Presupuesto.PlantillaDeta*/
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 001',4900,1,5,cast('09/06/2016' as datetime),'N',1,'5253003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 002',6600,1,5,cast('01/06/2016' as datetime),'N',1,'5245003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 003',5400,1,5,cast('02/06/2016' as datetime),'N',1,'5355003','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 004',6500,1,5,cast('03/06/2016' as datetime),'N',1,'5259863','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 005',3200,1,5,cast('04/06/2016' as datetime),'N',1,'5224503','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 006',4500,1,5,cast('05/06/2016' as datetime),'N',1,'2366366','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 007',7400,1,5,cast('06/06/2016' as datetime),'N',1,'3578553','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 008',2300,1,4,cast('07/06/2016' as datetime),'N',1,'4567884','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 009',3200,1,4,cast('08/06/2016' as datetime),'N',1,'6788906','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 010',5020,1,4,cast('10/06/2016' as datetime),'N',1,'5556788','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 011',6030,1,2,cast('11/06/2016' as datetime),'N',1,'4455667','ocarril',getdate());
Insert into Presupuesto.PlantillaDeta(codPlantilla,codEmpleadoAprueba,gloDescripcion,monEstimado,cntCantidad,codRegEstado,fecEjecucion,indPlantilla,codPartida,numPartida,segUsuarioCrea,segFechaCrea) values
(24,6,'Glosa Descripcion 012',7040,1,2,cast('12/06/2016' as datetime),'N',1,'5567788','ocarril',getdate());

/*INICIO DEL CASO DE USO
4.1.1 El actualizador de plantilla presupuestal apertura la 
Plantilla Presupuestal. [PRE_RN001]
select * from RecursosHumanos.empleado
4.1.2 El sistema muestra el número de planilla (Año + Código 
de área + correlativo), y la opción para ingresar partidas.
select * from Presupuesto.Plantilla
select * from RecursosHumanos.Area
*/
/*AÑO : 2017 - APERTURA DE PLANTILLAS PARA EL 2017*/
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2017CONT01',1,1,5,5,1,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2017MARK01',1,2,5,5,2,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2017RRHH01',1,3,5,5,3,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2017LOGI01',1,4,5,5,4,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2017PRES01',1,5,5,5,5,'ocarril',getdate());
INSERt into Presupuesto.Plantilla 
(numPlantilla,codRegEstado,codArea,codPresupuesto,codSolicitud,codEmpleadoElabora,segUsuarioCrea,segFechaCrea) values
('2017ALMC01',1,6,5,5,6,'ocarril',getdate());
GO

/**********************************************************************************************************/
/*************************************** Scripts de Trazabilidad ******************************************/
/**********************************************************************************************************/
INSERT INTO [Trazabilidad].[FichaTecnicaProductoProveedor] 
([codigoFichaTecProveedor], [nombre], [nomTecnico], [modoUso], [contraIndicacion], [condicionesUso], [condicionesAlmacen], [condicionesComercial], [temperaturaMinima], [temperaturaMaxima], [laboratorioOrigen]) 
VALUES (N'1', N'FICHA LG', N'LG', N'USO', NULL, NULL, NULL, NULL, NULL, N'10', NULL)
INSERT INTO [Trazabilidad].[Procedimiento] 
([codigoProcedimiento], [version], [fechIniVigencia], [fechFinVigencia], [responsable], [unidadPlazo], [observaciones]) 
VALUES (N'1', N'1', CAST(0xDB3A0B00 AS Date), CAST(0x2E3E0B00 AS Date), N'ROSA ', N'UN', N'OBS')
INSERT INTO [Trazabilidad].[FichaTecnicaProductoFarmacia] 
([codigoFichaTecProducto], [nombre], [descripcion], [etiquetado], [procedimientoAlmacen], [procedimientoVenta], [procedimiemtoDistribucion], [posologia], [quimicoFarmaceutico], [aprobar], [codigoProcedimiento], [codigoFichaTecProveedor]) 
VALUES (N'1', N'FICHA', N'FICHAC', N'etiq2', N'PROC', N'PROC', N'PROC', N'', N'', N'A', N'1', N'1')
INSERT INTO [Trazabilidad].[Producto] 
([codigoProducto], [nombreProducto], [descripcion], [tipoProducto], [presentacion], [pesoProducto]) 
VALUES (N'1', N'CELULAR', N'S6', N'CELULARES', N'S6 GALAXY', N'10')
INSERT INTO [Trazabilidad].[HojaMerma] 
([numeroHojaMerma], [cantidadInsumo], [fecha], [motivo], [codigoProducto]) 
VALUES (N'1', N'3', CAST(0xDB3A0B00 AS Date), N'COMPRA', N'1')
INSERT INTO [Trazabilidad].[InformeVenta] 
([codigoVenta], [fechaVenta], [nombreProducto], [cantidad], [nombreCliente], [precio], [codigoProducto]) 
VALUES (N'1', CAST(0xDB3A0B00 AS Date), N'CELULAR', N'3', N'JUAN PEREZ', N'10', N'1')
INSERT INTO [Trazabilidad].[Kardex] 
([numeroKardex], [fecha], [ingreso], [salidas], [saldos], [observaciones], [codigoProducto]) 
VALUES (N'1', CAST(0xDB3A0B00 AS Date), N'0', N'3', N'100', NULL, N'1')
INSERT INTO [Trazabilidad].[LibroReceta] 
([nombreProducto], [fechaProducto], [quimicoLaboratorista], [codigoProducto]) 
VALUES (N'CELULAR', CAST(0xDB3A0B00 AS Date), N'Q', N'1')
INSERT INTO [Trazabilidad].[OrdenDeCompra] 
([codigoCompra], [fechaCompra], [nombreProducto], [cantidad], [nombreProveedor], [costo], [codigoProducto]) 
VALUES (N'1', CAST(0xDB3A0B00 AS Date), N'CELULAR', N'50', N'LG', N'1000', N'1')
INSERT INTO [Trazabilidad].[OrdenDeDespacho] 
([numeroOrden], [fecha], [totalPedidos], [pesoTotal], [observaciones], [codigoProducto]) 
VALUES (N'1', CAST(0xDB3A0B00 AS Date), N'5', N'300', NULL, N'1')
INSERT INTO [Trazabilidad].[Trazabilidad] 
([codigoTraza], [fechaTraza], [producto], [descripcion], [codigoVenta], [numeroKardex], [codigoCompra], [numeroOrden], [numeroHojaMerma], [nombreProducto], [codigoFichaTecProducto]) 
VALUES (N'1', CAST(0xDB3A0B00 AS Date), N'1', N'CELULAR', N'1', N'1', N'1', N'1', N'1', N'CELULAR', N'1')
INSERT INTO [Trazabilidad].[InformeTrazabilidad] 
([codigoInformeTrazabilidad], [producto], [detalleAnalisis], [anexo], [codigoTraza]) 
VALUES (N'1', N'1', N'PRUEBA', N'155', N'1')
GO

/*
SELECT 'Select * from ' + s.name+'.'+t.name FROM sys.tables t 
inner join sys.schemas s on t.schema_id = s.schema_id
GO

[Presupuesto].[pa_S_Presupuesto] 2016

Select * from RecursosHumanos.Cargo
Select * from RecursosHumanos.Empleado
Select * from Presupuesto.Gasto
Select * from Presupuesto.Partida
Select * from Maestros.Persona
Select * from Presupuesto.Plantilla
Select * from Presupuesto.PlantillaDeta
Select * from Presupuesto.PresupuestoArea
Select * from Presupuesto.Presupuesto
Select * from Presupuesto.Solicitud
Select * from Presupuesto.SolicitudDeta
Select * from RecursosHumanos.Area

SELECT * FROM [Trazabilidad].[FichaTecnicaProductoProveedor] 
SELECT * FROM [Trazabilidad].[Procedimiento] 
SELECT * FROM [Trazabilidad].[FichaTecnicaProductoFarmacia] 
SELECT * FROM [Trazabilidad].[Producto] 
SELECT * FROM [Trazabilidad].[HojaMerma] 
SELECT * FROM [Trazabilidad].[InformeVenta] 
SELECT * FROM [Trazabilidad].[Kardex] 
SELECT * FROM [Trazabilidad].[LibroReceta] 
SELECT * FROM [Trazabilidad].[OrdenDeCompra] 
SELECT * FROM [Trazabilidad].[OrdenDeDespacho] 
SELECT * FROM [Trazabilidad].[Trazabilidad] 
SELECT * FROM [Trazabilidad].[InformeTrazabilidad] 

TRUNCATE TABLE RecursosHumanos.Cargo
TRUNCATE TABLE RecursosHumanos.Empleado
TRUNCATE TABLE Presupuesto.Gasto
TRUNCATE TABLE Presupuesto.Partida
TRUNCATE TABLE Maestros.Persona
TRUNCATE TABLE Presupuesto.Plantilla
TRUNCATE TABLE Presupuesto.PlantillaDeta
TRUNCATE TABLE Presupuesto.PresupuestoArea
TRUNCATE TABLE Presupuesto.Presupuesto
TRUNCATE TABLE Presupuesto.Solicitud
TRUNCATE TABLE Presupuesto.SolicitudDeta
TRUNCATE TABLE RecursosHumanos.Area
GO
*/

USE BD_ByS
GO
-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on codArea in table 'Plantilla'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Plantilla_FK01_codArea') 
	ALTER TABLE Presupuesto.Plantilla
	WITH CHECK 	ADD  CONSTRAINT [Plantilla_FK01_codArea] 
	FOREIGN KEY(codArea)
	REFERENCES RecursosHumanos.Area (codArea)
GO
ALTER TABLE Presupuesto.Plantilla
CHECK CONSTRAINT [Plantilla_FK01_codArea]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Plantilla_FK04_codSolicitud') 
	ALTER TABLE Presupuesto.Plantilla
	WITH CHECK 	ADD  CONSTRAINT Plantilla_FK04_codSolicitud 
	FOREIGN KEY(codSolicitud)
	REFERENCES Presupuesto.Solicitud (codSolicitud)
GO
ALTER TABLE Presupuesto.Plantilla
CHECK CONSTRAINT Plantilla_FK04_codSolicitud
GO

-- Creating foreign key on codArea in table 'Empleado'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Empleado_FK01_codArea') 
	ALTER TABLE RecursosHumanos.Empleado
	WITH CHECK 	ADD  CONSTRAINT [Empleado_FK01_codArea] 
	FOREIGN KEY(codArea)
	REFERENCES RecursosHumanos.Area (codArea)
GO
ALTER TABLE RecursosHumanos.Empleado
CHECK CONSTRAINT [Empleado_FK01_codArea]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Plantilla_FK03_codEmpleadoElabora') 
	ALTER TABLE Presupuesto.Plantilla
	WITH CHECK 	ADD  CONSTRAINT Plantilla_FK03_codEmpleadoElabora 
	FOREIGN KEY(codEmpleadoElabora)
	REFERENCES RecursosHumanos.Empleado (codEmpleado)
GO
ALTER TABLE Presupuesto.Plantilla
CHECK CONSTRAINT Plantilla_FK03_codEmpleadoElabora
GO

-- Creating foreign key on codCargo in table 'Empleado'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Empleado_FK02_codCargo') 
	ALTER TABLE RecursosHumanos.Empleado
	WITH CHECK 	ADD  CONSTRAINT Empleado_FK02_codCargo
	FOREIGN KEY(codCargo)
	REFERENCES RecursosHumanos.Cargo (codCargo)
GO
ALTER TABLE RecursosHumanos.Empleado
CHECK CONSTRAINT Empleado_FK02_codCargo
GO

-- Creating foreign key on codArea in table 'PresupuestoArea'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'PresupuestoArea_FK01_codArea') 
	ALTER TABLE Presupuesto.PresupuestoArea
	WITH CHECK 	ADD  CONSTRAINT [PresupuestoArea_FK01_codArea] 
	FOREIGN KEY(codArea)
	REFERENCES RecursosHumanos.Area (codArea)
GO
ALTER TABLE Presupuesto.PresupuestoArea
CHECK CONSTRAINT [PresupuestoArea_FK01_codArea]
GO


-- Creating foreign key on codPersona in table 'Empleado'
--IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Empleado_FK03_codPersona') 
--	ALTER TABLE RecursosHumanos.Empleado
--	WITH CHECK 	ADD  CONSTRAINT [Empleado_FK03_codPersona] 
--	FOREIGN KEY(codPersona)
--	REFERENCES Maestros.Persona (codPersona)
--GO
--ALTER TABLE RecursosHumanos.Empleado
--CHECK CONSTRAINT [Empleado_FK03_codPersona]
--GO

-- Creating foreign key on codEmpleadoResponsable in table 'Gasto'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Gasto_FK01_codEmpleado') 
	ALTER TABLE Presupuesto.Gasto
	WITH CHECK 	ADD  CONSTRAINT Gasto_FK01_codEmpleado 
	FOREIGN KEY(codEmpleadoResp)
	REFERENCES RecursosHumanos.Empleado (codEmpleado)
GO
ALTER TABLE Presupuesto.Gasto
CHECK CONSTRAINT Gasto_FK01_codEmpleado
GO


-- Creating foreign key on codEmpleadoAprueba in table 'PlantillaDeta'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'PlantillaDeta_FK01_codEmpleadoAprueba') 
	ALTER TABLE Presupuesto.PlantillaDeta
	WITH CHECK 	ADD  CONSTRAINT PlantillaDeta_FK01_codEmpleadoAprueba
	FOREIGN KEY(codEmpleadoAprueba)
	REFERENCES RecursosHumanos.Empleado (codEmpleado) not for replication
GO
ALTER TABLE Presupuesto.PlantillaDeta
check CONSTRAINT PlantillaDeta_FK01_codEmpleadoAprueba
GO


-- Creating foreign key on codEmpleadoAprueba in table 'PlantillaDeta'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'PlantillaDeta_FK01_codEmpleadoRespon') 
	ALTER TABLE Presupuesto.PlantillaDeta
	WITH CHECK 	ADD  CONSTRAINT PlantillaDeta_FK01_codEmpleadoRespon
	FOREIGN KEY(codEmpleadoRespon)
	REFERENCES RecursosHumanos.Empleado (codEmpleado) not for replication
GO
ALTER TABLE Presupuesto.PlantillaDeta
check CONSTRAINT PlantillaDeta_FK01_codEmpleadoRespon
GO


-- Creating foreign key on codPlantillaPresupuestalDeta in table 'Gasto'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Gasto_FK02_PlantillaDeta') 
	ALTER TABLE Presupuesto.Gasto
	WITH CHECK 	ADD  CONSTRAINT Gasto_FK02_PlantillaDeta
	FOREIGN KEY(codPlantillaDeta)
	REFERENCES Presupuesto.PlantillaDeta (codPlantillaDeta)
GO
ALTER TABLE Presupuesto.Gasto
CHECK CONSTRAINT Gasto_FK02_PlantillaDeta
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'PlantillaDeta_FK02_codPartida') 
	ALTER TABLE Presupuesto.PlantillaDeta
	WITH CHECK 	ADD  CONSTRAINT PlantillaDeta_FK02_codPartida
	FOREIGN KEY(codPartida)
	REFERENCES Presupuesto.Partida (codPartida)
GO
ALTER TABLE Presupuesto.PlantillaDeta
CHECK CONSTRAINT PlantillaDeta_FK02_codPartida
GO


-- Creating foreign key on codPresupuestoGeneral in table 'Plantilla'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Plantilla_FK02_codPresupuesto') 
	ALTER TABLE Presupuesto.Plantilla
	WITH CHECK 	ADD  CONSTRAINT Plantilla_FK02_codPresupuesto
	FOREIGN KEY(codPresupuesto)
	REFERENCES Presupuesto.Presupuesto (codPresupuesto)
GO
ALTER TABLE Presupuesto.Plantilla
CHECK CONSTRAINT Plantilla_FK02_codPresupuesto
GO

-- Creating foreign key on codPlantillaPresupuestal in table 'PlantillaDeta'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'PlantillaDeta_FK03_codPlantilla') 
	ALTER TABLE Presupuesto.PlantillaDeta
	WITH CHECK 	ADD  CONSTRAINT PlantillaDeta_FK03_codPlantilla
	FOREIGN KEY(codPlantilla)
	REFERENCES Presupuesto.Plantilla (codPlantilla)
GO
ALTER TABLE Presupuesto.PlantillaDeta
CHECK CONSTRAINT PlantillaDeta_FK03_codPlantilla
GO

-- Creating foreign key on codPlantillaDeta in table 'SolicitudDeta'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'SolicitudDeta_FK01_codPlantillaDeta') 
	ALTER TABLE Presupuesto.SolicitudDeta
	WITH CHECK 	ADD  CONSTRAINT SolicitudDeta_FK01_codPlantillaDeta
	FOREIGN KEY(codPlantillaDeta)
	REFERENCES Presupuesto.PlantillaDeta (codPlantillaDeta)
GO
ALTER TABLE Presupuesto.SolicitudDeta
CHECK CONSTRAINT SolicitudDeta_FK01_codPlantillaDeta
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'PresupuestoArea_FK02_codPresupuesto') 
	ALTER TABLE Presupuesto.PresupuestoArea
	WITH CHECK 	ADD  CONSTRAINT [PresupuestoArea_FK02_codPresupuesto] 
	FOREIGN KEY(codPresupuesto)
	REFERENCES Presupuesto.Presupuesto (codPresupuesto)
GO
ALTER TABLE Presupuesto.PresupuestoArea
CHECK CONSTRAINT [PresupuestoArea_FK02_codPresupuesto]
GO

-- Creating foreign key on codSolicitud in table 'Solicitud'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Solicitud_FK01_codPresupuesto') 
	ALTER TABLE Presupuesto.Solicitud
	WITH CHECK 	ADD  CONSTRAINT Solicitud_FK01_codPresupuesto
	FOREIGN KEY(codPresupuesto)
	REFERENCES Presupuesto.Presupuesto(codPresupuesto) NOT FOR REPLICATION
GO
ALTER TABLE Presupuesto.Solicitud
CHECK CONSTRAINT Solicitud_FK01_codPresupuesto
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Solicitud_FK02_codEmpleadoGenera') 
	ALTER TABLE Presupuesto.Solicitud
	WITH CHECK 	ADD  CONSTRAINT Solicitud_FK02_codEmpleadoGenera
	FOREIGN KEY(codEmpleadoGenera)
	REFERENCES RecursosHumanos.Empleado(codEmpleado)
GO
ALTER TABLE Presupuesto.Solicitud
CHECK CONSTRAINT Solicitud_FK02_codEmpleadoGenera
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Solicitud_FK03_codEmpleadoAprueba') 
	ALTER TABLE Presupuesto.Solicitud
	WITH CHECK 	ADD  CONSTRAINT Solicitud_FK03_codEmpleadoAprueba
	FOREIGN KEY(codEmpleadoAprueba)
	REFERENCES RecursosHumanos.Empleado(codEmpleado) NOT FOR REPLICATION
GO
ALTER TABLE Presupuesto.Solicitud
CHECK CONSTRAINT Solicitud_FK03_codEmpleadoAprueba
GO

-- Creating foreign key on codSolicitud in table 'SolicitudDeta'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'SolicitudDeta_FK02_codSolicitud') 
	ALTER TABLE Presupuesto.SolicitudDeta
	WITH CHECK 	ADD  CONSTRAINT SolicitudDeta_FK02_codSolicitud
	FOREIGN KEY(codSolicitud)
	REFERENCES Presupuesto.Solicitud(codSolicitud)
GO
ALTER TABLE Presupuesto.SolicitudDeta
CHECK CONSTRAINT SolicitudDeta_FK02_codSolicitud
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'SolicitudDeta_FK01_codPlantillaDeta') 
	ALTER TABLE Presupuesto.SolicitudDeta
	WITH CHECK 	ADD  CONSTRAINT SolicitudDeta_FK01_codPlantillaDeta
	FOREIGN KEY(codPlantillaDeta)
	REFERENCES Presupuesto.PlantillaDeta(codPlantillaDeta)
GO
ALTER TABLE Presupuesto.SolicitudDeta
CHECK CONSTRAINT SolicitudDeta_FK01_codPlantillaDeta
GO

/**********************************************************************************************************/
/*************************************** Scripts de Trazabilidad ******************************************/
/**********************************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_FichaTecnicaProductoFarmacia_FichaTecnicaProductoProveedor') 
BEGIN
	ALTER TABLE [Trazabilidad].[FichaTecnicaProductoFarmacia]  WITH CHECK ADD  CONSTRAINT [FK_FichaTecnicaProductoFarmacia_FichaTecnicaProductoProveedor] FOREIGN KEY([codigoFichaTecProveedor])
	REFERENCES [Trazabilidad].[FichaTecnicaProductoProveedor] ([codigoFichaTecProveedor])
	
	ALTER TABLE [Trazabilidad].[FichaTecnicaProductoFarmacia] CHECK CONSTRAINT [FK_FichaTecnicaProductoFarmacia_FichaTecnicaProductoProveedor]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_FichaTecnicaProductoFarmacia_Procedimiento') 
BEGIN
	ALTER TABLE [Trazabilidad].[FichaTecnicaProductoFarmacia]  WITH CHECK ADD  CONSTRAINT [FK_FichaTecnicaProductoFarmacia_Procedimiento] FOREIGN KEY([codigoProcedimiento])
	REFERENCES [Trazabilidad].[Procedimiento] ([codigoProcedimiento])

	ALTER TABLE [Trazabilidad].[FichaTecnicaProductoFarmacia] CHECK CONSTRAINT [FK_FichaTecnicaProductoFarmacia_Procedimiento]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_HojaMerma_Producto') 
BEGIN
	ALTER TABLE [Trazabilidad].[HojaMerma]  WITH CHECK ADD  CONSTRAINT [FK_HojaMerma_Producto] FOREIGN KEY([codigoProducto])
	REFERENCES [Trazabilidad].[Producto] ([codigoProducto])

	ALTER TABLE [Trazabilidad].[HojaMerma] CHECK CONSTRAINT [FK_HojaMerma_Producto]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_InformeTrazabilidad_Trazabilidad') 
BEGIN
	ALTER TABLE [Trazabilidad].[InformeTrazabilidad]  WITH CHECK ADD  CONSTRAINT [FK_InformeTrazabilidad_Trazabilidad] FOREIGN KEY([codigoTraza])
	REFERENCES [Trazabilidad].[Trazabilidad] ([codigoTraza])

	ALTER TABLE [Trazabilidad].[InformeTrazabilidad] CHECK CONSTRAINT [FK_InformeTrazabilidad_Trazabilidad]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_LibroReceta_Producto') 
BEGIN
	ALTER TABLE [Trazabilidad].[LibroReceta]  WITH CHECK ADD  CONSTRAINT [FK_LibroReceta_Producto] FOREIGN KEY([codigoProducto])
	REFERENCES [Trazabilidad].[Producto] ([codigoProducto])

	ALTER TABLE [Trazabilidad].[LibroReceta] CHECK CONSTRAINT [FK_LibroReceta_Producto]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_OrdenDeCompra_Producto') 
BEGIN
	ALTER TABLE [Trazabilidad].[OrdenDeCompra]  WITH CHECK ADD  CONSTRAINT [FK_OrdenDeCompra_Producto] FOREIGN KEY([codigoProducto])
	REFERENCES [Trazabilidad].[Producto] ([codigoProducto])

	ALTER TABLE [Trazabilidad].[OrdenDeCompra] CHECK CONSTRAINT [FK_OrdenDeCompra_Producto]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_OrdenDeDespacho_Producto') 
BEGIN
	ALTER TABLE [Trazabilidad].[OrdenDeDespacho]  WITH CHECK ADD  CONSTRAINT [FK_OrdenDeDespacho_Producto] FOREIGN KEY([codigoProducto])
	REFERENCES [Trazabilidad].[Producto] ([codigoProducto])

	ALTER TABLE [Trazabilidad].[OrdenDeDespacho] CHECK CONSTRAINT [FK_OrdenDeDespacho_Producto]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_Trazabilidad_FichaTecnicaProductoFarmacia') 
BEGIN
	ALTER TABLE [Trazabilidad].[Trazabilidad]  WITH CHECK ADD  CONSTRAINT [FK_Trazabilidad_FichaTecnicaProductoFarmacia] FOREIGN KEY([codigoFichaTecProducto])
	REFERENCES [Trazabilidad].[FichaTecnicaProductoFarmacia] ([codigoFichaTecProducto])

	ALTER TABLE [Trazabilidad].[Trazabilidad] CHECK CONSTRAINT [FK_Trazabilidad_FichaTecnicaProductoFarmacia]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_Trazabilidad_HojaMerma') 
BEGIN
	ALTER TABLE [Trazabilidad].[Trazabilidad]  WITH CHECK ADD  CONSTRAINT [FK_Trazabilidad_HojaMerma] FOREIGN KEY([numeroHojaMerma])
	REFERENCES [Trazabilidad].[HojaMerma] ([numeroHojaMerma])

	ALTER TABLE [Trazabilidad].[Trazabilidad] CHECK CONSTRAINT [FK_Trazabilidad_HojaMerma]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_Trazabilidad_InformeVenta') 
BEGIN
	ALTER TABLE [Trazabilidad].[Trazabilidad]  WITH CHECK ADD  CONSTRAINT [FK_Trazabilidad_InformeVenta] FOREIGN KEY([codigoVenta])
	REFERENCES [Trazabilidad].[InformeVenta] ([codigoVenta])

	ALTER TABLE [Trazabilidad].[Trazabilidad] CHECK CONSTRAINT [FK_Trazabilidad_InformeVenta]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_Trazabilidad_Kardex') 
BEGIN
	ALTER TABLE [Trazabilidad].[Trazabilidad]  WITH CHECK ADD  CONSTRAINT [FK_Trazabilidad_Kardex] FOREIGN KEY([numeroKardex])
	REFERENCES [Trazabilidad].[Kardex] ([numeroKardex])

	ALTER TABLE [Trazabilidad].[Trazabilidad] CHECK CONSTRAINT [FK_Trazabilidad_Kardex]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_Trazabilidad_LibroReceta') 
BEGIN
	ALTER TABLE [Trazabilidad].[Trazabilidad]  WITH CHECK ADD  CONSTRAINT [FK_Trazabilidad_LibroReceta] FOREIGN KEY([nombreProducto])
	REFERENCES [Trazabilidad].[LibroReceta] ([nombreProducto])

	ALTER TABLE [Trazabilidad].[Trazabilidad] CHECK CONSTRAINT [FK_Trazabilidad_LibroReceta]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_Trazabilidad_OrdenDeCompra') 
BEGIN
	ALTER TABLE [Trazabilidad].[Trazabilidad]  WITH CHECK ADD  CONSTRAINT [FK_Trazabilidad_OrdenDeCompra] FOREIGN KEY([codigoCompra])
	REFERENCES [Trazabilidad].[OrdenDeCompra] ([codigoCompra])

	ALTER TABLE [Trazabilidad].[Trazabilidad] CHECK CONSTRAINT [FK_Trazabilidad_OrdenDeCompra]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'FK_Trazabilidad_OrdenDeDespacho') 
BEGIN
	ALTER TABLE [Trazabilidad].[Trazabilidad]  WITH CHECK ADD  CONSTRAINT [FK_Trazabilidad_OrdenDeDespacho] FOREIGN KEY([numeroOrden])
	REFERENCES [Trazabilidad].[OrdenDeDespacho] ([numeroOrden])

	ALTER TABLE [Trazabilidad].[Trazabilidad] CHECK CONSTRAINT [FK_Trazabilidad_OrdenDeDespacho]
END
GO

--- MODULO DE INVENTARIOS
USE [BD_ByS]
GO
/****** Object:  Schema [Inventario]    Script Date: 01/20/2016 11:48:48 ******/
CREATE SCHEMA [Inventario] AUTHORIZATION [dbo]
GO
/****** Object:  Table [Inventario].[Sucursal]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Inventario].[Sucursal](
	[idSucursal] [int] NOT NULL,
	[nombreSurcursal] [varchar](50) NULL,
	[direccion] [varchar](50) NULL,
	[ruc] [varchar](50) NULL,
	[telefono] [varchar](50) NULL,
	[responsable] [varchar](50) NULL,
 CONSTRAINT [PK_Sucursal] PRIMARY KEY CLUSTERED 
(
	[idSucursal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Inventario].[Proveedor]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Inventario].[Proveedor](
	[idProveedor] [int] NOT NULL,
	[nombreProveedor] [varchar](50) NULL,
	[nRuc] [varchar](15) NULL,
	[direccion] [varchar](50) NULL,
 CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Inventario].[DetalleKardex]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[DetalleKardex](
	[NumeroKardex] [int] NOT NULL,
	[NumeroDocumento] [nchar](10) NOT NULL,
	[TipodeMovimiento] [int] NULL,
	[NumeroNotaIngreso] [nchar](10) NULL,
	[NumeroSalida] [nchar](10) NULL,
	[Fecha] [datetime] NULL,
	[Cantidad] [decimal](18, 2) NULL,
 CONSTRAINT [PK_DetalleKardex] PRIMARY KEY CLUSTERED 
(
	[NumeroKardex] ASC,
	[NumeroDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[Almacen]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[Almacen](
	[IdAlmacen] [int] NOT NULL,
	[NombreAlmacen] [nvarchar](50) NULL,
	[Direccion] [nvarchar](150) NULL,
	[UsuarioRegistro] [nchar](10) NULL,
	[FechaRegsitro] [datetime] NULL,
 CONSTRAINT [PK_Almacen] PRIMARY KEY CLUSTERED 
(
	[IdAlmacen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[Empleado]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Inventario].[Empleado](
	[idEmpleado] [int] NOT NULL,
	[apellidoPaterno] [varchar](50) NULL,
	[apellidoMaterno] [varchar](50) NULL,
	[nDni] [varchar](8) NULL,
	[telefono] [varchar](50) NULL,
	[foto] [varchar](50) NULL,
	[fechaIngreso] [date] NULL,
	[nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[idEmpleado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Inventario].[Producto]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[Producto](
	[idProducto] [int] NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[UnidadMedida] [nvarchar](20) NULL,
	[Presentacion] [nvarchar](100) NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[Pedido]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[Pedido](
	[NumeroPedido] [nchar](10) NOT NULL,
	[Fecha] [datetime] NULL,
	[IdSucursal] [int] NULL,
	[Estado] [int] NULL,
	[FechaRegistro] [datetime] NULL,
	[UsuarioRegistro] [nchar](20) NULL,
	[UsuarioAsignado] [nchar](20) NULL,
	[idProducto] [int] NULL,
 CONSTRAINT [PK_Pedido] PRIMARY KEY CLUSTERED 
(
	[NumeroPedido] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[OrdenCompra]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Inventario].[OrdenCompra](
	[nOrdenCompra] [varchar](50) NOT NULL,
	[fecha] [date] NULL,
	[transportista] [varchar](50) NULL,
	[direccionEntrega] [varchar](50) NULL,
	[idProducto] [int] NULL,
	[idProveedor] [int] NULL,
 CONSTRAINT [PK_OrdenCompra] PRIMARY KEY CLUSTERED 
(
	[nOrdenCompra] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Inventario].[Ubicacion]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[Ubicacion](
	[idUbicacion] [int] NOT NULL,
	[IdAlmacen] [int] NULL,
	[Fila] [nchar](10) NULL,
	[Columna] [nchar](10) NULL,
	[Nivel] [nchar](10) NULL,
	[posicion] [nchar](10) NULL,
 CONSTRAINT [PK_Ubicacion] PRIMARY KEY CLUSTERED 
(
	[idUbicacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[ProgramacionInventario]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Inventario].[ProgramacionInventario](
	[idProgramacionInventario] [int] NOT NULL,
	[idSucursal] [int] NULL,
	[IdAlmacen] [int] NULL,
	[fechaInventario] [date] NULL,
	[descripcionInventario] [varchar](50) NULL,
	[fechaRegistro] [date] NULL,
 CONSTRAINT [PK_ProgramacionInventario] PRIMARY KEY CLUSTERED 
(
	[idProgramacionInventario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Inventario].[ProgramacionPicking]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Inventario].[ProgramacionPicking](
	[idProgramacionPicking] [int] NOT NULL,
	[idEmpleado] [int] NULL,
	[NumeroPedido] [nchar](10) NULL,
	[idProducto] [int] NULL,
	[idUbicacion] [int] NULL,
	[descripcion] [varchar](50) NULL,
	[fecha] [date] NULL,
	[turno] [varchar](50) NULL,
	[cantidadPedido] [int] NULL,
	[cantidadAtendida] [int] NULL,
 CONSTRAINT [PK_ProgramacionPicking] PRIMARY KEY CLUSTERED 
(
	[idProgramacionPicking] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Inventario].[NotaIngreso]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Inventario].[NotaIngreso](
	[NumeroNotaIngreso] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[NumeroOrdenCompra] [varchar](50) NULL,
	[idEmpleado] [int] NULL,
	[UsuarioRecibo] [nchar](10) NULL,
	[idAlmacen] [int] NULL,
	[GuiaRemsion] [nchar](20) NULL,
	[Observaciones] [text] NULL,
	[EstadoNotaIngreso] [text] NULL,
 CONSTRAINT [PK_NotaIngreso] PRIMARY KEY CLUSTERED 
(
	[NumeroNotaIngreso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Inventario].[UbicacionProducto]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[UbicacionProducto](
	[idUbicacion] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idUbicacion] ASC,
	[IdProducto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[DetallePedido]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[DetallePedido](
	[Item] [int] NOT NULL,
	[NumeroPedido] [nchar](10) NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [decimal](18, 2) NULL,
 CONSTRAINT [PK_DetallePedido] PRIMARY KEY CLUSTERED 
(
	[Item] ASC,
	[NumeroPedido] ASC,
	[IdProducto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[NotaSalida]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[NotaSalida](
	[NumeroSalida] [int] NOT NULL,
	[NumeroPedido] [nchar](10) NOT NULL,
	[idEmpleado] [int] NULL,
	[idProgramacionPicking] [int] NULL,
	[FechaSalida] [nchar](10) NULL,
	[idAlmacen] [int] NULL,
	[UsuarioPicking] [nchar](20) NULL,
	[Observaciones] [text] NULL,
	[EstadoNotaSalida] [text] NULL,
 CONSTRAINT [PK_NotaSalida] PRIMARY KEY CLUSTERED 
(
	[NumeroSalida] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[DetalleNotaIngreso]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[DetalleNotaIngreso](
	[NumeroNotaIngreso] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [decimal](18, 2) NULL,
 CONSTRAINT [PK_DetalleNotaIngreso] PRIMARY KEY CLUSTERED 
(
	[NumeroNotaIngreso] ASC,
	[IdProducto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[Kardex]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[Kardex](
	[NumeroKardex] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[IdAlmacen] [int] NOT NULL,
	[Observaciones] [text] NULL,
	[SaldoActual] [decimal](18, 2) NULL,
	[idNotaIngreso] [int] NULL,
	[idNotaSalida] [int] NULL,
 CONSTRAINT [PK_Kardex] PRIMARY KEY CLUSTERED 
(
	[NumeroKardex] ASC,
	[IdProducto] ASC,
	[IdAlmacen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Inventario].[DetalleNotaSalida]    Script Date: 01/20/2016 11:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventario].[DetalleNotaSalida](
	[NumeroSalida] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [decimal](18, 2) NULL,
 CONSTRAINT [PK_DetalleNotaSalida] PRIMARY KEY CLUSTERED 
(
	[NumeroSalida] ASC,
	[IdProducto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_Pedido_Producto]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_Producto] FOREIGN KEY([idProducto])
REFERENCES [Inventario].[Producto] ([idProducto])
GO
ALTER TABLE [Inventario].[Pedido] CHECK CONSTRAINT [FK_Pedido_Producto]
GO
/****** Object:  ForeignKey [FK_Pedido_Sucursal]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_Sucursal] FOREIGN KEY([IdSucursal])
REFERENCES [Inventario].[Sucursal] ([idSucursal])
GO
ALTER TABLE [Inventario].[Pedido] CHECK CONSTRAINT [FK_Pedido_Sucursal]
GO
/****** Object:  ForeignKey [FK_OrdenCompra_OrdenCompra]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[OrdenCompra]  WITH CHECK ADD  CONSTRAINT [FK_OrdenCompra_OrdenCompra] FOREIGN KEY([idProveedor])
REFERENCES [Inventario].[Proveedor] ([idProveedor])
GO
ALTER TABLE [Inventario].[OrdenCompra] CHECK CONSTRAINT [FK_OrdenCompra_OrdenCompra]
GO
/****** Object:  ForeignKey [FK_OrdenCompra_Producto]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[OrdenCompra]  WITH CHECK ADD  CONSTRAINT [FK_OrdenCompra_Producto] FOREIGN KEY([idProducto])
REFERENCES [Inventario].[Producto] ([idProducto])
GO
ALTER TABLE [Inventario].[OrdenCompra] CHECK CONSTRAINT [FK_OrdenCompra_Producto]
GO
/****** Object:  ForeignKey [FK_Ubicacion_Almacen]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[Ubicacion]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_Almacen] FOREIGN KEY([IdAlmacen])
REFERENCES [Inventario].[Almacen] ([IdAlmacen])
GO
ALTER TABLE [Inventario].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_Almacen]
GO
/****** Object:  ForeignKey [FK_ProgramacionInventario_ProgramacionInventario]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[ProgramacionInventario]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionInventario_ProgramacionInventario] FOREIGN KEY([IdAlmacen])
REFERENCES [Inventario].[Almacen] ([IdAlmacen])
GO
ALTER TABLE [Inventario].[ProgramacionInventario] CHECK CONSTRAINT [FK_ProgramacionInventario_ProgramacionInventario]
GO
/****** Object:  ForeignKey [FK_ProgramacionInventario_Sucursal]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[ProgramacionInventario]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionInventario_Sucursal] FOREIGN KEY([idSucursal])
REFERENCES [Inventario].[Sucursal] ([idSucursal])
GO
ALTER TABLE [Inventario].[ProgramacionInventario] CHECK CONSTRAINT [FK_ProgramacionInventario_Sucursal]
GO
/****** Object:  ForeignKey [FK_ProgramacionPicking_Empleado]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[ProgramacionPicking]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionPicking_Empleado] FOREIGN KEY([idEmpleado])
REFERENCES [Inventario].[Empleado] ([idEmpleado])
GO
ALTER TABLE [Inventario].[ProgramacionPicking] CHECK CONSTRAINT [FK_ProgramacionPicking_Empleado]
GO
/****** Object:  ForeignKey [FK_ProgramacionPicking_Pedido]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[ProgramacionPicking]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionPicking_Pedido] FOREIGN KEY([NumeroPedido])
REFERENCES [Inventario].[Pedido] ([NumeroPedido])
GO
ALTER TABLE [Inventario].[ProgramacionPicking] CHECK CONSTRAINT [FK_ProgramacionPicking_Pedido]
GO
/****** Object:  ForeignKey [FK_ProgramacionPicking_Ubicacion]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[ProgramacionPicking]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionPicking_Ubicacion] FOREIGN KEY([idUbicacion])
REFERENCES [Inventario].[Ubicacion] ([idUbicacion])
GO
ALTER TABLE [Inventario].[ProgramacionPicking] CHECK CONSTRAINT [FK_ProgramacionPicking_Ubicacion]
GO
/****** Object:  ForeignKey [FK_NotaIngreso_Almacen]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[NotaIngreso]  WITH CHECK ADD  CONSTRAINT [FK_NotaIngreso_Almacen] FOREIGN KEY([idAlmacen])
REFERENCES [Inventario].[Almacen] ([IdAlmacen])
GO
ALTER TABLE [Inventario].[NotaIngreso] CHECK CONSTRAINT [FK_NotaIngreso_Almacen]
GO
/****** Object:  ForeignKey [FK_NotaIngreso_Empleado]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[NotaIngreso]  WITH CHECK ADD  CONSTRAINT [FK_NotaIngreso_Empleado] FOREIGN KEY([idEmpleado])
REFERENCES [Inventario].[Empleado] ([idEmpleado])
GO
ALTER TABLE [Inventario].[NotaIngreso] CHECK CONSTRAINT [FK_NotaIngreso_Empleado]
GO
/****** Object:  ForeignKey [FK_NotaIngreso_OrdenCompra]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[NotaIngreso]  WITH CHECK ADD  CONSTRAINT [FK_NotaIngreso_OrdenCompra] FOREIGN KEY([NumeroOrdenCompra])
REFERENCES [Inventario].[OrdenCompra] ([nOrdenCompra])
GO
ALTER TABLE [Inventario].[NotaIngreso] CHECK CONSTRAINT [FK_NotaIngreso_OrdenCompra]
GO
/****** Object:  ForeignKey [FK_UbicacionProducto_Producto]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[UbicacionProducto]  WITH CHECK ADD  CONSTRAINT [FK_UbicacionProducto_Producto] FOREIGN KEY([IdProducto])
REFERENCES [Inventario].[Producto] ([idProducto])
GO
ALTER TABLE [Inventario].[UbicacionProducto] CHECK CONSTRAINT [FK_UbicacionProducto_Producto]
GO
/****** Object:  ForeignKey [FK_UbicacionProducto_Ubicacion]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[UbicacionProducto]  WITH CHECK ADD  CONSTRAINT [FK_UbicacionProducto_Ubicacion] FOREIGN KEY([idUbicacion])
REFERENCES [Inventario].[Ubicacion] ([idUbicacion])
GO
ALTER TABLE [Inventario].[UbicacionProducto] CHECK CONSTRAINT [FK_UbicacionProducto_Ubicacion]
GO
/****** Object:  ForeignKey [FK__DetallePe__Numer__2C3393D0]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[DetallePedido]  WITH CHECK ADD FOREIGN KEY([NumeroPedido])
REFERENCES [Inventario].[Pedido] ([NumeroPedido])
GO
/****** Object:  ForeignKey [FK_NotaSalida_Almacen]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[NotaSalida]  WITH CHECK ADD  CONSTRAINT [FK_NotaSalida_Almacen] FOREIGN KEY([idAlmacen])
REFERENCES [Inventario].[Almacen] ([IdAlmacen])
GO
ALTER TABLE [Inventario].[NotaSalida] CHECK CONSTRAINT [FK_NotaSalida_Almacen]
GO
/****** Object:  ForeignKey [FK_NotaSalida_Empleado]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[NotaSalida]  WITH CHECK ADD  CONSTRAINT [FK_NotaSalida_Empleado] FOREIGN KEY([idEmpleado])
REFERENCES [Inventario].[Empleado] ([idEmpleado])
GO
ALTER TABLE [Inventario].[NotaSalida] CHECK CONSTRAINT [FK_NotaSalida_Empleado]
GO
/****** Object:  ForeignKey [FK_NotaSalida_Pedido]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[NotaSalida]  WITH CHECK ADD  CONSTRAINT [FK_NotaSalida_Pedido] FOREIGN KEY([NumeroPedido])
REFERENCES [Inventario].[Pedido] ([NumeroPedido])
GO
ALTER TABLE [Inventario].[NotaSalida] CHECK CONSTRAINT [FK_NotaSalida_Pedido]
GO
/****** Object:  ForeignKey [FK_NotaSalida_ProgPicking]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[NotaSalida]  WITH CHECK ADD  CONSTRAINT [FK_NotaSalida_ProgPicking] FOREIGN KEY([idProgramacionPicking])
REFERENCES [Inventario].[ProgramacionPicking] ([idProgramacionPicking])
GO
ALTER TABLE [Inventario].[NotaSalida] CHECK CONSTRAINT [FK_NotaSalida_ProgPicking]
GO
/****** Object:  ForeignKey [FK_DetalleNotaIngreso_NotaIngreso]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[DetalleNotaIngreso]  WITH CHECK ADD  CONSTRAINT [FK_DetalleNotaIngreso_NotaIngreso] FOREIGN KEY([NumeroNotaIngreso])
REFERENCES [Inventario].[NotaIngreso] ([NumeroNotaIngreso])
GO
ALTER TABLE [Inventario].[DetalleNotaIngreso] CHECK CONSTRAINT [FK_DetalleNotaIngreso_NotaIngreso]
GO
/****** Object:  ForeignKey [FK__Kardex__idNotaIng]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[Kardex]  WITH CHECK ADD  CONSTRAINT [FK__Kardex__idNotaIng] FOREIGN KEY([idNotaIngreso])
REFERENCES [Inventario].[NotaIngreso] ([NumeroNotaIngreso])
GO
ALTER TABLE [Inventario].[Kardex] CHECK CONSTRAINT [FK__Kardex__idNotaIng]
GO
/****** Object:  ForeignKey [FK__Kardex__idNotaSal]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[Kardex]  WITH CHECK ADD  CONSTRAINT [FK__Kardex__idNotaSal] FOREIGN KEY([idNotaSalida])
REFERENCES [Inventario].[NotaSalida] ([NumeroSalida])
GO
ALTER TABLE [Inventario].[Kardex] CHECK CONSTRAINT [FK__Kardex__idNotaSal]
GO
/****** Object:  ForeignKey [FK_DetalleNotaSalida_NotaSalida]    Script Date: 01/20/2016 11:48:49 ******/
ALTER TABLE [Inventario].[DetalleNotaSalida]  WITH CHECK ADD  CONSTRAINT [FK_DetalleNotaSalida_NotaSalida] FOREIGN KEY([NumeroSalida])
REFERENCES [Inventario].[NotaSalida] ([NumeroSalida])
GO
ALTER TABLE [Inventario].[DetalleNotaSalida] CHECK CONSTRAINT [FK_DetalleNotaSalida_NotaSalida]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Presupuesto].[pa_S_InformeSeguimiento]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Presupuesto].[pa_S_InformeSeguimiento]
GO

USE [BD_ByS]
GO

/****** Object:  StoredProcedure [Presupuesto].[pa_S_InformeSeguimiento]    Script Date: 01/31/2016 13:02:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Presupuesto].[pa_S_InformeSeguimiento] 
(
	 @p_NumPagina			int
	,@p_TamPagina			int
	,@p_OrdenPor			varchar(30)=null
	,@p_OrdenTipo			varchar(4)=null
	,@p_anio       			INT=null
	,@p_codArea        		INT=null
	,@p_codRegEstado		INT=null
	,@p_mesini		INT=null
	,@p_mesfin		INT=null
)
AS
BEGIN
SET NOCOUNT ON
	SELECT
	*
	
	FROM
	(	
	select
	 pd.codPlantillaDeta
	,pd.codPlantilla
	,pd.codEmpleadoAprueba
	,ema.desNombre +', '+ema.desApellido [codEmpleadoResponNombre]
	,pd.gloDescripcion
	,pd.monEstimado
	,pd.cntCantidad
	,pd.codRegEstado
	,CASE WHEN pd.codRegEstado = 1 THEN 'PENDIENxAPROB'
		  WHEN pd.codRegEstado = 2 THEN 'APROBADO'
		  WHEN pd.codRegEstado = 3 THEN 'DESAPROBADO'
		  WHEN pd.codRegEstado = 4 THEN 'EN EJECUCION'
		  WHEN pd.codRegEstado = 5 THEN 'EJECUTADO'
	 END codRegEstadoNombre
	,pd.fecEjecucion
	,pd.codEmpleadoRespon
	,emr.desNombre +', '+emr.desApellido [codEmpleadoResponRespon]
	,pd.indPlantilla
	,CASE WHEN pd.indPlantilla = 'N' THEN 'NORMAL'
		  ELSE 'ADICIONAL'
	 END [indPlantillaTipo]
	,pd.codPartida
	,pd.numPartida
	,pd.segUsuarioCrea
	,pd.segUsuarioEdita
	,pd.segFechaCrea
	,pd.segFechaEdita
	,pd.segMaquinaOrigen
	,par.desNombre codPartidaNombre
	,par.codNumero
	,pl.codArea
	,are.desNombre codAreaNombre
	,COUNT(*) OVER() AS [TOTALROWS]
	    ,ROW_NUMBER() OVER (ORDER BY CASE WHEN @p_OrdenPor = 'numPartida'  and @p_OrdenTipo = 'ASC' 
										   THEN pd.[numPartida]
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'numPartida'  and @p_OrdenTipo = 'DESC' 
										   THEN pd.[numPartida]
									 END DESC,	  	   
									 CASE WHEN @p_OrdenPor = 'monEstimado'  and @p_OrdenTipo = 'ASC'  THEN
										pd.[monEstimado]  
									 END ASC,
									 CASE WHEN @p_OrdenPor = 'monEstimado'  and @p_OrdenTipo = 'DESC'  THEN
										pd.[monEstimado]  
									 END DESC  
									 ) AS [ROWNUM]	
	from	Presupuesto.PlantillaDeta pd
	inner join Presupuesto.Plantilla pl on pl.codPlantilla = pd.codPlantilla
	inner join Presupuesto.Presupuesto pr on pl.codPresupuesto = pr.codPresupuesto 
	inner join RecursosHumanos.Area are on pl.codArea = are.codArea
	left join RecursosHumanos.Empleado ema on pd.codEmpleadoAprueba = ema.codEmpleado
	left join RecursosHumanos.Empleado emr on pd.codEmpleadoRespon = emr.codEmpleado
	inner join Presupuesto.Partida par on pd.codPartida = par.codPartida
	WHERE
	ISNULL(pr.numAnio,'')	=	(CASE WHEN ISNULL(@p_anio,'')	<>''	THEN  ISNULL(@p_anio,'')   	ELSE ISNULL(pr.numAnio,'')	END) AND
	ISNULL(pl.codArea,'')	=	(CASE WHEN ISNULL(@p_codArea,'')<>''	THEN  ISNULL(@p_codArea,'') ELSE ISNULL(pl.codArea,'')	END) AND
	ISNULL(pd.codRegEstado,'')=	(CASE WHEN ISNULL(@p_codRegEstado,'')<>''THEN  ISNULL(@p_codRegEstado,'') ELSE ISNULL(pd.codRegEstado,'')	END) AND
	MONTH(pd.fecEjecucion)  between @p_mesini and @p_mesfin and 
	pd.indEliminado = 0
)
	AS Tabla
	WHERE ROWNUM BETWEEN (@p_NumPagina*@p_TamPagina) - @p_TamPagina + 1 
					 AND (@p_NumPagina*@p_TamPagina)
					 
	SET NOCOUNT OFF
END

GO