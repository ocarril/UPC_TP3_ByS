/* MODULO DE PRESUPUESTO para prueba :*/
USE [master]
GO

CREATE DATABASE [BD_ByS] ON  
PRIMARY 
(	NAME		= N'BoticaSalud_Primary', 
	FILENAME	= N'D:\Tp03\BD\BD_BoticaSalud_Primary2.mdf' , 
	SIZE		= 20MB , 
	MAXSIZE		= 150MB, 
	FILEGROWTH	= 10%
), 
FILEGROUP [DATABASE01] 
(	NAME		= N'BoticaSalud_Data', 
    FILENAME	= N'D:\Tp03\BD\BD_BoticaSalud_Data2.ndf' ,
  	SIZE		= 50MB , 
	MAXSIZE		= 800MB,
	FILEGROWTH	= 10%
), 
FILEGROUP [INDICES] 
(	NAME		= N'BoticaSalud_Index', 
    FILENAME	= N'D:\Tp03\BD\BD_Botica_Index2.ndf' , 
  	SIZE		= 50MB , 
	MAXSIZE		= 500MB,
	FILEGROWTH	= 10%
), 
FILEGROUP [MULTIMEDIA] 
(	NAME		= N'BoticaSalud_Multimedia', 
    FILENAME	= N'D:\Tp03\BD\BD_BoticaS_Multimedia2.ndf' , 
  	SIZE		= 15MB , 
	MAXSIZE		= 200MB, 
	FILEGROWTH	= 10%
), 
FILEGROUP [HISTORIA] 
(
    NAME		= N'BoticaSalud_Historia',
    FILENAME	= 'D:\Tp03\BD\BD_BoticaS_Historiaz2.ndf',
    SIZE		= 15MB,
    MAXSIZE		= 300MB,
    FILEGROWTH	= 15MB
)
LOG ON 
(	NAME		= N'BoticaSalud_Logs', 
    FILENAME	= N'D:\Tp03\BD\BD_BoticaS_Logs2.ldf' , 
  	SIZE		= 5MB, 
	MAXSIZE		= 200MB , 
	FILEGROWTH	= 5%
)
GO
