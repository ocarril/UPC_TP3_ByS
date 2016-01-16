USE [master]
GO


CREATE DATABASE [BD_ByS] ON  
PRIMARY 
(	NAME		= N'BoticaSalud_Primary', 
	FILENAME	= N'E:\CROM_DataBases\BD_CLIENTES\ByS\BD_BoticaSalud_Primary2.mdf' , 
	SIZE		= 20MB , 
	MAXSIZE		= 150MB, 
	FILEGROWTH	= 10%
), 
FILEGROUP [DATABASE01] 
(	NAME		= N'BoticaSalud_Data', 
    FILENAME	= N'E:\CROM_DataBases\BD_CLIENTES\ByS\BD_BoticaSalud_Data2.ndf' ,
  	SIZE		= 50MB , 
	MAXSIZE		= 800MB,
	FILEGROWTH	= 10%
), 
FILEGROUP [INDICES] 
(	NAME		= N'BoticaSalud_Index', 
    FILENAME	= N'E:\CROM_DataBases\BD_CLIENTES\ByS\BD_Botica_Index2.ndf' , 
  	SIZE		= 50MB , 
	MAXSIZE		= 500MB,
	FILEGROWTH	= 10%
), 
FILEGROUP [MULTIMEDIA] 
(	NAME		= N'BoticaSalud_Multimedia', 
    FILENAME	= N'E:\CROM_DataBases\BD_CLIENTES\ByS\BD_BoticaS_Multimedia2.ndf' , 
  	SIZE		= 15MB , 
	MAXSIZE		= 200MB, 
	FILEGROWTH	= 10%
), 
FILEGROUP [HISTORIA] 
(
    NAME		= N'BoticaSalud_Historia',
    FILENAME	= 'E:\CROM_DataBases\BD_CLIENTES\ByS\BD_BoticaS_Historiaz2.ndf',
    SIZE		= 15MB,
    MAXSIZE		= 300MB,
    FILEGROWTH	= 15MB
)
LOG ON 
(	NAME		= N'BoticaSalud_Logs', 
    FILENAME	= N'E:\CROM_DataBases\BD_CLIENTES\ByS\BD_BoticaS_Logs2.ldf' , 
  	SIZE		= 5MB, 
	MAXSIZE		= 200MB , 
	FILEGROWTH	= 5%
)
GO