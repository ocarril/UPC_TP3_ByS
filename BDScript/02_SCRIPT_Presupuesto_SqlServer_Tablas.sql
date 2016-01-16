USE BD_ByS
GO

CREATE SCHEMA Presupuesto
GO

CREATE SCHEMA RecursosHumanos
GO

CREATE SCHEMA Maestros
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
  codSolicitudPresupuesto 	int  NOT NULL,
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
* CREACION DE LA TABLA : Presupuesto.Presupuesto
* Tabla para almacenar los presupuestos por año
****************************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.SolicitudPresupuesto') AND type in (N'U'))
BEGIN
-- Creating table 'SolicitudPresupuesto'
	CREATE TABLE Presupuesto.SolicitudPresupuesto 
	(
    codSolicitudPresupuesto int		IDENTITY(1,1)NOT NULL,
    numSolicitud			nvarchar(10)		NOT NULL,
    gloObservacion			nvarchar(100)		NULL,
    fecSolicitada			datetime			NULL,
    indTipo					nvarchar(1)			NOT NULL,
    fecLimite				datetime			NULL,
	segUsuarioCrea    		VARCHAR(25)			NOT NULL CONSTRAINT DEF_SolicitudPresupuesto_segUsuarioCrea DEFAULT USER_NAME(),
	segUsuarioEdita   		VARCHAR(25)			NULL,
	segFechaCrea      		DATETIME			NOT NULL CONSTRAINT DEF_SolicitudPresupuesto_segFechaCrea   DEFAULT GETDATE(),
	segFechaEdita     		DATETIME			NULL,
	segMaquinaOrigen  		VARCHAR(25)			NOT NULL CONSTRAINT DEF_SolicitudPresupuesto_segMaquina	  DEFAULT (host_name()),
	indEliminado      		BIT					NOT NULL CONSTRAINT DEF_SolicitudPresupuesto_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_SolicitudPresupuesto_codPresupuesto PRIMARY KEY CLUSTERED 
	(
		codSolicitudPresupuesto ASC
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Presupuesto.SolicitudPresupuestoDeta') AND type in (N'U'))
BEGIN
-- Creating table 'SolicitudPresupuestoDeta'
CREATE TABLE Presupuesto.SolicitudPresupuestoDeta (

    codSolicitudPresupuestoDeta		int IDENTITY(1,1)	NOT NULL,
    codSolicitudPresupuesto			int					NOT NULL,
    codPlantillaDeta				int					NOT NULL,
    cntCantidad						DECIMAL(10,2)		NOT NULL,
    gloDescripcion					nvarchar(120)		NOT NULL,
	segUsuarioCrea    				VARCHAR(25)			NOT NULL CONSTRAINT DEF_SolicitudPresupuestoDeta_segUsuarioCrea DEFAULT USER_NAME(),
	segUsuarioEdita   				VARCHAR(25)			NULL,
	segFechaCrea      				DATETIME			NOT NULL CONSTRAINT DEF_SolicitudPresupuestoDeta_segFechaCrea   DEFAULT GETDATE(),
	segFechaEdita     				DATETIME			NULL,
	segMaquinaOrigen  				VARCHAR(25)			NOT NULL CONSTRAINT DEF_SolicitudPresupuestoDeta_segMaquina	  DEFAULT (host_name()),
	indEliminado      				BIT					NOT NULL CONSTRAINT DEF_SolicitudPresupuestoDeta_indEliminado	  DEFAULT (0),
   CONSTRAINT PK_SolicitudPresupuestoDeta_codSolicitudPresupuestoDeta PRIMARY KEY CLUSTERED 
	(
		codSolicitudPresupuestoDeta ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) 
	ON [DATABASE01]
) 
ON [DATABASE01]
END
GO

