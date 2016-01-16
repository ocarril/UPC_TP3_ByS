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

--left join Presupuesto.PlantillaDeta pd gt on pd.codPlantillaDeta = gt.codPlantillaDeta

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