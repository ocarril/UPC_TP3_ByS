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
