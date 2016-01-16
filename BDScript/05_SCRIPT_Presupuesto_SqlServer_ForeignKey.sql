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

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'Plantilla_FK04_codSolicitudPresupuesto') 
	ALTER TABLE Presupuesto.Plantilla
	WITH CHECK 	ADD  CONSTRAINT Plantilla_FK04_codSolicitudPresupuesto 
	FOREIGN KEY(codSolicitudPresupuesto)
	REFERENCES Presupuesto.SolicitudPresupuesto (codSolicitudPresupuesto)
GO
ALTER TABLE Presupuesto.Plantilla
CHECK CONSTRAINT Plantilla_FK04_codSolicitudPresupuesto
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

-- Creating foreign key on codPlantillaPresupuestalDeta in table 'SolicitudPresupuestoDeta'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'SolicitudPresupuestoDeta_FK01_codPlantillaDeta') 
	ALTER TABLE Presupuesto.SolicitudPresupuestoDeta
	WITH CHECK 	ADD  CONSTRAINT SolicitudPresupuestoDeta_FK01_codPlantillaDeta
	FOREIGN KEY(codPlantillaDeta)
	REFERENCES Presupuesto.PlantillaDeta (codPlantillaDeta)
GO
ALTER TABLE Presupuesto.SolicitudPresupuestoDeta
CHECK CONSTRAINT SolicitudPresupuestoDeta_FK01_codPlantillaDeta
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


-- Creating foreign key on codSolicitudPresupuesto in table 'SolicitudPresupuestoDeta'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE NAME = 'SolicitudPresupuestoDeta_FK02_codSolicitudPresupuesto') 
	ALTER TABLE Presupuesto.SolicitudPresupuestoDeta
	WITH CHECK 	ADD  CONSTRAINT SolicitudPresupuestoDeta_FK02_codSolicitudPresupuesto 
	FOREIGN KEY(codSolicitudPresupuesto)
	REFERENCES Presupuesto.SolicitudPresupuesto (codSolicitudPresupuesto)
GO
ALTER TABLE Presupuesto.SolicitudPresupuestoDeta
CHECK CONSTRAINT SolicitudPresupuestoDeta_FK02_codSolicitudPresupuesto
GO
