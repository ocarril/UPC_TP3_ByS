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
