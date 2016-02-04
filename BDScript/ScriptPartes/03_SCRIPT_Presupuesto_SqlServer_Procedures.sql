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
	--[Presupuesto].[pa_S_PlantillaDetaPagina] 2,15,'codPlantilla','asc',2016
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
	--[Presupuesto].[pa_S_Gasto] null, null, 2016
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_Gasto]
(
 @p_codGasto			INT=null
,@p_codPlantillaDeta	INT=null
,@p_codArea				INT=null
,@p_anio				INT=null
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
	,pl.codArea
	,ar.desNombre codAreaNombre
	,pl.codPresupuesto
	,pr.desNombre codPresupuestoNombre
	from Presupuesto.Gasto gt
	left join RecursosHumanos.Empleado em on gt.codEmpleadoResp = em.codEmpleado
	left join Presupuesto.PlantillaDeta pd on gt.codPlantillaDeta = pd.codPlantillaDeta
	left join Presupuesto.Plantilla pl on pd.codPlantilla = pl.codPlantilla
	left join Presupuesto.Presupuesto pr on pl.codPresupuesto = pr.codPresupuesto
	left join RecursosHumanos.Area ar on pl.codArea = ar.codArea
	WHERE 
	ISNULL(gt.codGasto,'')	=	(CASE WHEN ISNULL(@p_codGasto,'')<>''	
									 THEN  ISNULL(@p_codGasto,'') 
									 ELSE ISNULL(gt.codGasto,'')	
								 END) 
	AND ISNULL(gt.codPlantillaDeta,'')	=	(CASE WHEN ISNULL(@p_codPlantillaDeta,'')<>''	
									 THEN  ISNULL(@p_codPlantillaDeta,'') 
									 ELSE ISNULL(gt.codPlantillaDeta,'')	
								 END) 									 
	AND ISNULL(pr.numAnio,0)	=	(CASE WHEN ISNULL(@p_anio,0)<>0	
										 THEN  ISNULL(@p_anio,0) 
										 ELSE ISNULL(pr.numAnio,0)	
									 END) 									 
	AND ISNULL(pl.codArea,0)	=	(CASE WHEN ISNULL(@p_codArea,0)<>0	
										 THEN  ISNULL(@p_codArea,0) 
										 ELSE ISNULL(pl.codArea,0)	
									 END) 									 
	AND gt.indEliminado	 = 0

END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_GastoPagina')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_GastoPagina] AS RETURN')
	--[Presupuesto].[pa_S_GastoPagina] 1,10,'codGasto','asc',null,null,2016
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
	,@p_codArea				INT=null
	,@p_anio				INT=null
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
		,pl.codArea
		,ar.desNombre codAreaNombre
		,pl.codPresupuesto
		,pr.desNombre codPresupuestoNombre
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
		left join Presupuesto.PlantillaDeta pd on gt.codPlantillaDeta = pd.codPlantillaDeta
		left join Presupuesto.Plantilla pl on pd.codPlantilla = pl.codPlantilla
		left join Presupuesto.Presupuesto pr on pl.codPresupuesto = pr.codPresupuesto
		left join RecursosHumanos.Area ar on pl.codArea = ar.codArea
		WHERE 
		ISNULL(gt.codGasto,0)	=	(CASE WHEN ISNULL(@p_codGasto,0)<>0	
									 THEN  ISNULL(@p_codGasto,0) 
									 ELSE ISNULL(gt.codGasto,0)	
									 END) 
		AND ISNULL(gt.codPlantillaDeta,0)	=	(CASE WHEN ISNULL(@p_codPlantillaDeta,0)<>0	
										 THEN  ISNULL(@p_codPlantillaDeta,0) 
										 ELSE ISNULL(gt.codPlantillaDeta,0)	
									 END) 									 
		AND ISNULL(pr.numAnio,0)	=	(CASE WHEN ISNULL(@p_anio,0)<>0	
										 THEN  ISNULL(@p_anio,0) 
										 ELSE ISNULL(pr.numAnio,0)	
									 END) 									 
		AND ISNULL(pl.codArea,0)	=	(CASE WHEN ISNULL(@p_codArea,0)<>0	
										 THEN  ISNULL(@p_codArea,0) 
										 ELSE ISNULL(pl.codArea,0)	
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

/*2016-ENE-19
select [Maestros].[fcnCrearCodigo](4,7)
*/
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
	--[Presupuesto].[pa_S_Solicitud] null,null,null,null,null,null,null,'j'
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
	,@p_codArea 			INT=null
	,@p_indTipo				varchar(1)=null
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
		,CASE WHEN S.codRegEstado = 1 THEN 'SOLICITADO'
		  WHEN s.codRegEstado = 2 THEN 'APROBADA'
		  WHEN s.codRegEstado = 3 THEN 'DESAPROBADO'
		  WHEN s.codRegEstado = 4 THEN 'EJECUTADA'
		END codRegEstadoNombre
		,s.segUsuarioCrea
		,s.segUsuarioEdita
		,s.segFechaCrea
		,s.segFechaEdita
		,s.segMaquinaOrigen
		,eg.codArea
		,ar.desNombre codAreaNombre
		from Presupuesto.Solicitud s
		inner join RecursosHumanos.Empleado eg on s.codEmpleadoGenera = eg.codEmpleado
		left  join RecursosHumanos.Empleado ea on s.codEmpleadoAprueba = ea.codEmpleado
		left  join Presupuesto.Presupuesto	pr on s.codPresupuesto	 = pr.codPresupuesto
		inner join RecursosHumanos.Area ar ON eg.codArea= ar.codArea
		WHERE 
		ISNULL(s.codSolicitud,0)	=	(CASE WHEN ISNULL(@p_codSolicitud,0)<>0	
									 THEN  ISNULL(@p_codSolicitud,0) 
									 ELSE ISNULL(s.codSolicitud,0)	
									 END) 
		AND ISNULL(s.numSolicitud,'')	LIKE	(CASE WHEN ISNULL(@p_numSolicitud,'')<>''	
										 THEN  '%' + ISNULL(@p_numSolicitud,'') + '%' 
										 ELSE ISNULL(s.numSolicitud,'')	
									 END) 									 
		AND ISNULL(s.codPresupuesto,0)	=	(CASE WHEN ISNULL(@p_codPresupuesto,0)<>0	
										 THEN  ISNULL(@p_codPresupuesto,0) 
										 ELSE ISNULL(s.codPresupuesto,0)	
									 END) 
											 									 
		AND ISNULL(eg.codArea,0)	=	(CASE WHEN ISNULL(@p_codArea,0)<>0	
										 THEN  ISNULL(@p_codArea,0) 
										 ELSE ISNULL(eg.codArea,0)	
									 END) 	
		AND ISNULL(s.indTipo,'')	LIKE	(CASE WHEN ISNULL(@p_indTipo,'')<>''	
													 THEN  '%' + ISNULL(@p_indTipo,'') + '%' 
													 ELSE ISNULL(s.indTipo,'')	
												 END) 									 
		AND s.indEliminado	 = 0
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_SolicitudPagina')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_SolicitudPagina] AS RETURN')
	--[Presupuesto].[pa_S_SolicitudPagina] 1,10,'codSolicitud','asc',null,null,null,null,null,null,null,'j'
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
	,@p_indTipo				varchar(1)=null
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
		,CASE WHEN S.codRegEstado = 1 THEN 'SOLICITADO'
		  WHEN s.codRegEstado = 2 THEN 'APROBADA'
		  WHEN s.codRegEstado = 3 THEN 'DESAPROBADO'
		  WHEN s.codRegEstado = 4 THEN 'EJECUTADA'
		END codRegEstadoNombre
		,s.segUsuarioCrea
		,s.segUsuarioEdita
		,s.segFechaCrea
		,s.segFechaEdita
		,s.segMaquinaOrigen
		,eg.codArea
		,ar.desNombre codAreaNombre
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
		inner join RecursosHumanos.Area ar ON eg.codArea= ar.codArea
		WHERE 
		ISNULL(s.codSolicitud,0)	=	(CASE WHEN ISNULL(@p_codSolicitud,0)<>0	
										 THEN  ISNULL(@p_codSolicitud,0) 
										 ELSE ISNULL(s.codSolicitud,0)	
										 END) 
		AND ISNULL(s.numSolicitud,'')	LIKE	(CASE WHEN ISNULL(@p_numSolicitud,'')<>''	
													 THEN  '%' + ISNULL(@p_numSolicitud,'') + '%' 
													 ELSE ISNULL(s.numSolicitud,'')	
												 END) 									 
		AND ISNULL(pr.numAnio,0)=	(CASE WHEN ISNULL(@p_codPresupuesto,0)<>0	
										 THEN  ISNULL(@p_codPresupuesto,0) 
										 ELSE ISNULL(pr.numAnio,0)	
										END) 
											 									 
		AND ISNULL(eg.codArea,0)	=	(CASE WHEN ISNULL(@p_codArea,0)<>0	
										 THEN  ISNULL(@p_codArea,0) 
										 ELSE ISNULL(eg.codArea,0)	
									 END) 	
		AND ISNULL(s.indTipo,'')	LIKE	(CASE WHEN ISNULL(@p_indTipo,'')<>''	
													 THEN  '%' + ISNULL(@p_indTipo,'') + '%' 
													 ELSE ISNULL(s.indTipo,'')	
											 END) 									 
		AND s.indEliminado	 = 0
	)
	AS Tabla
	WHERE ROWNUM BETWEEN (@p_NumPagina*@p_TamPagina) - @p_TamPagina + 1 
					 AND (@p_NumPagina*@p_TamPagina)
END
GO

	--SELECT (SUBSTRING(numSolicitud,5,5)), numSolicitud
	--FROM Presupuesto.Solicitud
	--WHERE 
	--LEFT(numSolicitud,4) = 	2016 AND LEN(numSolicitud)=9

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

	SELECT @Codigo = (SUBSTRING(numSolicitud,5,5)) 
	FROM Presupuesto.Solicitud
	WHERE 
	LEFT(numSolicitud,4) = 	@padAnio AND LEN(numSolicitud)=9
	
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
	--[Presupuesto].[pa_S_SolicitudDeta] 4
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
		,p.codPartida
		,t.desNombre		codPartidaNombre
		,p.gloDescripcion	gloDescripcionOrig
		from Presupuesto.SolicitudDeta d
		inner join Presupuesto.Solicitud		s  on s.codSolicitud= d.codSolicitud
		left  join Presupuesto.PlantillaDeta	p  on d.codPlantillaDeta	 = p.codPlantillaDeta
		inner join Presupuesto.Partida			t  on p.codPartida = t.codPartida
		left join RecursosHumanos.Empleado		e  on p.codEmpleadoAprueba = e.codEmpleado
		left join RecursosHumanos.Empleado		er on p.codEmpleadoRespon = er.codEmpleado
		WHERE 
		ISNULL(d.codSolicitudDeta,0)	=	(CASE WHEN ISNULL(@p_codSolicitudDeta,0)<>0	
											 THEN  ISNULL(@p_codSolicitudDeta,0) 
											 ELSE ISNULL(d.codSolicitudDeta,0)	
											 END) 
		AND ISNULL(d.codSolicitud,0)	=	(CASE WHEN ISNULL(@p_codSolicitud,0)<>0
												 THEN  ISNULL(@p_codSolicitud,0)
												 ELSE ISNULL(d.codSolicitud,0)	
											 END) 									 
		AND ISNULL(d.codPlantillaDeta,0)=	(CASE WHEN ISNULL(@p_codPlantillaDeta,0)<>0	
												 THEN  ISNULL(@p_codPlantillaDeta,0) 
												 ELSE ISNULL(d.codPlantillaDeta,0)	
											 END) 									 
		AND ISNULL(s.codRegEstado,0)	=	(CASE WHEN ISNULL(@p_codRegEstado,0)<>0	
												 THEN  ISNULL(@p_codRegEstado,0) 
												 ELSE ISNULL(s.codRegEstado,0)	
											 END) 									 
		AND ISNULL(s.codPresupuesto,0)	=	(CASE WHEN ISNULL(@p_codPresupuesto,0)<>0	
												 THEN  ISNULL(@p_codPresupuesto,0) 
												 ELSE ISNULL(s.codPresupuesto,0)	
											 END) 
											 									 
		AND s.indEliminado	 = 0
END
GO

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_SolicitudDetaPagina')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_SolicitudDetaPagina] AS RETURN')
	--[Presupuesto].[pa_S_SolicitudDetaPagina] 1,10,'codSolicitudDeta','asc',0,-1,null,null,0
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
		,p.codPartida
		,t.desNombre		codPartidaNombre
		,p.gloDescripcion	gloDescripcionOrig
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
		inner join Presupuesto.PlantillaDeta	p on d.codPlantillaDeta	 = p.codPlantillaDeta
		inner join Presupuesto.Partida			t on p.codPartida = t.codPartida
		left join RecursosHumanos.Empleado		e  on p.codEmpleadoAprueba = e.codEmpleado
		left join RecursosHumanos.Empleado		er on p.codEmpleadoRespon = er.codEmpleado
		WHERE 
		ISNULL(d.codSolicitudDeta,0)	=	(CASE WHEN ISNULL(@p_codSolicitudDeta,0)<>0	
											 THEN  ISNULL(@p_codSolicitudDeta,0) 
											 ELSE ISNULL(d.codSolicitudDeta,0)	
											 END) 
		AND ISNULL(d.codSolicitud,0)	=	(CASE WHEN ISNULL(@p_codSolicitud,0)<>0
												 THEN  ISNULL(@p_codSolicitud,0)
												 ELSE ISNULL(d.codSolicitud,0)	
											 END) 									 
		AND ISNULL(d.codPlantillaDeta,0)=	(CASE WHEN ISNULL(@p_codPlantillaDeta,0)<>0	
												 THEN  ISNULL(@p_codPlantillaDeta,0) 
												 ELSE ISNULL(d.codPlantillaDeta,0)	
											 END) 									 
		AND ISNULL(s.codRegEstado,0)	=	(CASE WHEN ISNULL(@p_codRegEstado,0)<>0	
												 THEN  ISNULL(@p_codRegEstado,0) 
												 ELSE ISNULL(s.codRegEstado,0)	
											 END) 									 
		AND ISNULL(s.codPresupuesto,0)	=	(CASE WHEN ISNULL(@p_codPresupuesto,0)<>0	
												 THEN  ISNULL(@p_codPresupuesto,0) 
												 ELSE ISNULL(s.codPresupuesto,0)	
											 END) 
											 									 
		AND d.indEliminado	 = 0
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
	-- codSolicitud           = 	@p_codSolicitud      
	--,codPlantillaDeta       = 	@p_codPlantillaDeta,  
	cntCantidad	    	= 	@p_cntCantidad	     
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

IF NOT EXISTS (SELECT NAME FROM sys.objects WHERE TYPE = 'P' AND NAME = 'pa_S_PlantillaDetaPendPagina')
BEGIN
	EXEC('CREATE PROCEDURE [Presupuesto].[pa_S_PlantillaDetaPendPagina] AS RETURN')
	--[Presupuesto].[pa_S_PlantillaDetaPendPagina] 1,72,'codPlantilla','asc',2016,1,2
END
GO
ALTER PROCEDURE [Presupuesto].[pa_S_PlantillaDetaPendPagina] 
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
	pd.codPlantillaDeta NOT IN (SELECT gt.codPlantillaDeta FROM Presupuesto.SolicitudDeta gt WHERE gt.indEliminado=0) AND
	pd.indEliminado = 0
)
	AS Tabla
	WHERE ROWNUM BETWEEN (@p_NumPagina*@p_TamPagina) - @p_TamPagina + 1 
					 AND (@p_NumPagina*@p_TamPagina)
					 
	SET NOCOUNT OFF
END
GO

/*numDiasExtemporaneo
Presupuesto.pa_S_Plantilla
select * from RecursosHumanos.Empleado
select * from Presupuesto.Presupuesto
select * from Presupuesto.Solicitud
select * from Presupuesto.SolicitudDeta
select * from Presupuesto.PlantillaDeta
select * from [Presupuesto].[Gasto]

TRUNCATE TABLE Presupuesto.SolicitudDeta
DELETE Presupuesto.Solicitud WHERE CODSOLICITUD>5

select p.numPlantilla,pr.fecInicio, pr.fecCierre,p.codEmpleadoElabora,e.desApellido+', '+e.desNombre,
p.codPresupuesto,pr.desNombre,p.numDiasExtemporaneo 
from Presupuesto.Plantilla p 
inner join Presupuesto.Presupuesto pr on p.codPresupuesto = pr.codPresupuesto
inner join RecursosHumanos.Empleado e on e.codempleado = p.codEmpleadoElabora
where p.codEmpleadoElabora=1

--ACTUALIZA EL REGISTRO PARA LOS DIAS DE VENCIMIENTO
UPDATE Presupuesto.Plantilla 
SET numDiasExTemporaneo=0 where codEmpleadoElabora=1 AND codPresupuesto = 4

UPDATE  Presupuesto.Solicitud SET codEmpleadoAprueba=4

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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Presupuesto].[pa_U_SolicitudEjecucion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Presupuesto].[pa_U_SolicitudEjecucion]
GO
USE [BD_ByS]
GO
/****** Object:  StoredProcedure [Presupuesto].[pa_U_SolicitudEjecucion]    Script Date: 01/30/2016 13:02:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [Presupuesto].[pa_U_SolicitudEjecucion]
(
 @p_codSolicitud				int
,@p_indTipo                 	varchar(1)
,@p_codRegEstado				int
--,@p_codEmpleadoAprueba         int
,@p_segUsuarioEdita           	varchar(25)
,@p_segMaquinaOrigen         	varchar(25)

)
AS
BEGIN
	UPDATE 
	[Presupuesto].[Solicitud] 
	SET    
	indTipo                     = 	@p_indTipo     		
	,codRegEstado               = 	@p_codRegEstado     
	,segUsuarioEdita            = 	@p_segUsuarioEdita
	,segMaquinaOrigen           = 	@p_segMaquinaOrigen
	,segFechaEdita			    =	getdate()
	WHERE exists (select codSolicitud 
	             from Presupuesto.SolicitudDeta sold 
				 where sold.codSolicitudDeta = @p_codSolicitud
				 and   [Presupuesto].[Solicitud].codSolicitud = sold.codSolicitud );


   UPDATE 
	[Presupuesto].SolicitudDeta
	SET    
    segUsuarioEdita            = 	@p_segUsuarioEdita
	,segMaquinaOrigen           = 	@p_segMaquinaOrigen
	,segFechaEdita			    =	getdate()
	WHERE codSolicitudDeta = @p_codSolicitud;

END
GO
