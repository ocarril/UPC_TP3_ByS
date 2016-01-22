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

