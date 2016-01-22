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
