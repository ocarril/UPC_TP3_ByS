﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.34209
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ByS.Trazabilidad.Data
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="BD_ByS")]
	public partial class _DBMLTrazabilidadDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Definiciones de métodos de extensibilidad
    partial void OnCreated();
    #endregion
		
		public _DBMLTrazabilidadDataContext() : 
				base(global::ByS.Trazabilidad.Data.Properties.Settings.Default.BD_BySConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public _DBMLTrazabilidadDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public _DBMLTrazabilidadDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public _DBMLTrazabilidadDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public _DBMLTrazabilidadDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_S_Kardex")]
		public ISingleResult<pa_S_KardexResult> pa_S_Kardex([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaIni, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaFin)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codProducto, p_fechaIni, p_fechaFin);
			return ((ISingleResult<pa_S_KardexResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_S_LibroReceta")]
		public ISingleResult<pa_S_LibroRecetaResult> pa_S_LibroReceta([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaIni, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaFin)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codProducto, p_fechaIni, p_fechaFin);
			return ((ISingleResult<pa_S_LibroRecetaResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_S_OrdendeCompra")]
		public ISingleResult<pa_S_OrdendeCompraResult> pa_S_OrdendeCompra([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaIni, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaFin)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codProducto, p_fechaIni, p_fechaFin);
			return ((ISingleResult<pa_S_OrdendeCompraResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_S_OrdenDeDespacho")]
		public ISingleResult<pa_S_OrdenDeDespachoResult> pa_S_OrdenDeDespacho([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaIni, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaFin)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codProducto, p_fechaIni, p_fechaFin);
			return ((ISingleResult<pa_S_OrdenDeDespachoResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_S_HojaMerma")]
		public ISingleResult<pa_S_HojaMermaResult> pa_S_HojaMerma([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaIni, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaFin)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codProducto, p_fechaIni, p_fechaFin);
			return ((ISingleResult<pa_S_HojaMermaResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_S_InformeVenta")]
		public ISingleResult<pa_S_InformeVentaResult> pa_S_InformeVenta([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaIni, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> p_fechaFin)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codProducto, p_fechaIni, p_fechaFin);
			return ((ISingleResult<pa_S_InformeVentaResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_S_FichaTecnicaProductoFarmacia")]
		public ISingleResult<pa_S_FichaTecnicaProductoFarmaciaResult> pa_S_FichaTecnicaProductoFarmacia([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codProducto)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codProducto);
			return ((ISingleResult<pa_S_FichaTecnicaProductoFarmaciaResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_U_FichaTecnicaProductoFarmacia")]
		public int pa_U_FichaTecnicaProductoFarmacia([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codigoFichaTecProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_nombre, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_descripcion, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_etiquetado, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(255)")] string p_procedimientoAlmacen, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(255)")] string p_procedimientoVenta, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(255)")] string p_procedimiemtoDistribucion, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(50)")] string p_posologia, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_quimicoFarmaceutico, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_aprobar)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codigoFichaTecProducto, p_nombre, p_descripcion, p_etiquetado, p_procedimientoAlmacen, p_procedimientoVenta, p_procedimiemtoDistribucion, p_posologia, p_quimicoFarmaceutico, p_aprobar);
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_I_OrdenRetiro")]
		public int pa_I_OrdenRetiro([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="NVarChar(10)")] string codigoProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="DateTime")] System.Nullable<System.DateTime> fecha, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="NVarChar(50)")] string autorizado, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="NVarChar(100)")] string motivo, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="NVarChar(100)")] string riesgo)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), codigoProducto, fecha, autorizado, motivo, riesgo);
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="Trazabilidad.pa_S_Producto")]
		public ISingleResult<pa_S_ProductoResult> pa_S_Producto([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(10)")] string p_codProducto, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(50)")] string p_nomProducto)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), p_codProducto, p_nomProducto);
			return ((ISingleResult<pa_S_ProductoResult>)(result.ReturnValue));
		}
	}
	
	public partial class pa_S_KardexResult
	{
		
		private string _codigoProducto;
		
		private System.Nullable<System.DateTime> _fecha;
		
		private string _ingreso;
		
		private string _numeroKardex;
		
		private string _observaciones;
		
		private string _saldos;
		
		private string _salidas;
		
		public pa_S_KardexResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoProducto", DbType="VarChar(10)")]
		public string codigoProducto
		{
			get
			{
				return this._codigoProducto;
			}
			set
			{
				if ((this._codigoProducto != value))
				{
					this._codigoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_fecha", DbType="Date")]
		public System.Nullable<System.DateTime> fecha
		{
			get
			{
				return this._fecha;
			}
			set
			{
				if ((this._fecha != value))
				{
					this._fecha = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ingreso", DbType="VarChar(10)")]
		public string ingreso
		{
			get
			{
				return this._ingreso;
			}
			set
			{
				if ((this._ingreso != value))
				{
					this._ingreso = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_numeroKardex", DbType="VarChar(10) NOT NULL", CanBeNull=false)]
		public string numeroKardex
		{
			get
			{
				return this._numeroKardex;
			}
			set
			{
				if ((this._numeroKardex != value))
				{
					this._numeroKardex = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_observaciones", DbType="VarChar(255)")]
		public string observaciones
		{
			get
			{
				return this._observaciones;
			}
			set
			{
				if ((this._observaciones != value))
				{
					this._observaciones = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_saldos", DbType="VarChar(10)")]
		public string saldos
		{
			get
			{
				return this._saldos;
			}
			set
			{
				if ((this._saldos != value))
				{
					this._saldos = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_salidas", DbType="VarChar(10)")]
		public string salidas
		{
			get
			{
				return this._salidas;
			}
			set
			{
				if ((this._salidas != value))
				{
					this._salidas = value;
				}
			}
		}
	}
	
	public partial class pa_S_LibroRecetaResult
	{
		
		private string _codigoProducto;
		
		private System.Nullable<System.DateTime> _fechaProducto;
		
		private string _nombreProducto;
		
		private string _quimicoLaboratorista;
		
		public pa_S_LibroRecetaResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoProducto", DbType="VarChar(10)")]
		public string codigoProducto
		{
			get
			{
				return this._codigoProducto;
			}
			set
			{
				if ((this._codigoProducto != value))
				{
					this._codigoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_fechaProducto", DbType="Date")]
		public System.Nullable<System.DateTime> fechaProducto
		{
			get
			{
				return this._fechaProducto;
			}
			set
			{
				if ((this._fechaProducto != value))
				{
					this._fechaProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nombreProducto", DbType="VarChar(10) NOT NULL", CanBeNull=false)]
		public string nombreProducto
		{
			get
			{
				return this._nombreProducto;
			}
			set
			{
				if ((this._nombreProducto != value))
				{
					this._nombreProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_quimicoLaboratorista", DbType="VarChar(10)")]
		public string quimicoLaboratorista
		{
			get
			{
				return this._quimicoLaboratorista;
			}
			set
			{
				if ((this._quimicoLaboratorista != value))
				{
					this._quimicoLaboratorista = value;
				}
			}
		}
	}
	
	public partial class pa_S_OrdendeCompraResult
	{
		
		private string _cantidad;
		
		private string _codigoCompra;
		
		private string _codigoProducto;
		
		private string _costo;
		
		private System.Nullable<System.DateTime> _fechaCompra;
		
		private string _nombreProducto;
		
		private string _nombreProveedor;
		
		public pa_S_OrdendeCompraResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_cantidad", DbType="VarChar(10)")]
		public string cantidad
		{
			get
			{
				return this._cantidad;
			}
			set
			{
				if ((this._cantidad != value))
				{
					this._cantidad = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoCompra", DbType="VarChar(10) NOT NULL", CanBeNull=false)]
		public string codigoCompra
		{
			get
			{
				return this._codigoCompra;
			}
			set
			{
				if ((this._codigoCompra != value))
				{
					this._codigoCompra = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoProducto", DbType="VarChar(10)")]
		public string codigoProducto
		{
			get
			{
				return this._codigoProducto;
			}
			set
			{
				if ((this._codigoProducto != value))
				{
					this._codigoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_costo", DbType="VarChar(10)")]
		public string costo
		{
			get
			{
				return this._costo;
			}
			set
			{
				if ((this._costo != value))
				{
					this._costo = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_fechaCompra", DbType="Date")]
		public System.Nullable<System.DateTime> fechaCompra
		{
			get
			{
				return this._fechaCompra;
			}
			set
			{
				if ((this._fechaCompra != value))
				{
					this._fechaCompra = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nombreProducto", DbType="VarChar(10)")]
		public string nombreProducto
		{
			get
			{
				return this._nombreProducto;
			}
			set
			{
				if ((this._nombreProducto != value))
				{
					this._nombreProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nombreProveedor", DbType="VarChar(10)")]
		public string nombreProveedor
		{
			get
			{
				return this._nombreProveedor;
			}
			set
			{
				if ((this._nombreProveedor != value))
				{
					this._nombreProveedor = value;
				}
			}
		}
	}
	
	public partial class pa_S_OrdenDeDespachoResult
	{
		
		private string _codigoProducto;
		
		private System.Nullable<System.DateTime> _fecha;
		
		private string _numeroOrden;
		
		private string _observaciones;
		
		private string _pesoTotal;
		
		private string _totalPedidos;
		
		public pa_S_OrdenDeDespachoResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoProducto", DbType="VarChar(10)")]
		public string codigoProducto
		{
			get
			{
				return this._codigoProducto;
			}
			set
			{
				if ((this._codigoProducto != value))
				{
					this._codigoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_fecha", DbType="Date")]
		public System.Nullable<System.DateTime> fecha
		{
			get
			{
				return this._fecha;
			}
			set
			{
				if ((this._fecha != value))
				{
					this._fecha = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_numeroOrden", DbType="VarChar(10) NOT NULL", CanBeNull=false)]
		public string numeroOrden
		{
			get
			{
				return this._numeroOrden;
			}
			set
			{
				if ((this._numeroOrden != value))
				{
					this._numeroOrden = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_observaciones", DbType="VarChar(255)")]
		public string observaciones
		{
			get
			{
				return this._observaciones;
			}
			set
			{
				if ((this._observaciones != value))
				{
					this._observaciones = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_pesoTotal", DbType="VarChar(10)")]
		public string pesoTotal
		{
			get
			{
				return this._pesoTotal;
			}
			set
			{
				if ((this._pesoTotal != value))
				{
					this._pesoTotal = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_totalPedidos", DbType="VarChar(10)")]
		public string totalPedidos
		{
			get
			{
				return this._totalPedidos;
			}
			set
			{
				if ((this._totalPedidos != value))
				{
					this._totalPedidos = value;
				}
			}
		}
	}
	
	public partial class pa_S_HojaMermaResult
	{
		
		private string _codigoProducto;
		
		private string _cantidadInsumo;
		
		private System.Nullable<System.DateTime> _fecha;
		
		private string _motivo;
		
		private string _numeroHojaMerma;
		
		public pa_S_HojaMermaResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoProducto", DbType="VarChar(10)")]
		public string codigoProducto
		{
			get
			{
				return this._codigoProducto;
			}
			set
			{
				if ((this._codigoProducto != value))
				{
					this._codigoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_cantidadInsumo", DbType="VarChar(10)")]
		public string cantidadInsumo
		{
			get
			{
				return this._cantidadInsumo;
			}
			set
			{
				if ((this._cantidadInsumo != value))
				{
					this._cantidadInsumo = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_fecha", DbType="Date")]
		public System.Nullable<System.DateTime> fecha
		{
			get
			{
				return this._fecha;
			}
			set
			{
				if ((this._fecha != value))
				{
					this._fecha = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_motivo", DbType="VarChar(50)")]
		public string motivo
		{
			get
			{
				return this._motivo;
			}
			set
			{
				if ((this._motivo != value))
				{
					this._motivo = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_numeroHojaMerma", DbType="VarChar(10) NOT NULL", CanBeNull=false)]
		public string numeroHojaMerma
		{
			get
			{
				return this._numeroHojaMerma;
			}
			set
			{
				if ((this._numeroHojaMerma != value))
				{
					this._numeroHojaMerma = value;
				}
			}
		}
	}
	
	public partial class pa_S_InformeVentaResult
	{
		
		private string _codigoVenta;
		
		private System.Nullable<System.DateTime> _fechaVenta;
		
		private string _nombreProducto;
		
		private string _cantidad;
		
		private string _codigoProducto;
		
		private string _precio;
		
		private string _nombreCliente;
		
		public pa_S_InformeVentaResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoVenta", DbType="VarChar(10) NOT NULL", CanBeNull=false)]
		public string codigoVenta
		{
			get
			{
				return this._codigoVenta;
			}
			set
			{
				if ((this._codigoVenta != value))
				{
					this._codigoVenta = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_fechaVenta", DbType="Date")]
		public System.Nullable<System.DateTime> fechaVenta
		{
			get
			{
				return this._fechaVenta;
			}
			set
			{
				if ((this._fechaVenta != value))
				{
					this._fechaVenta = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nombreProducto", DbType="VarChar(10)")]
		public string nombreProducto
		{
			get
			{
				return this._nombreProducto;
			}
			set
			{
				if ((this._nombreProducto != value))
				{
					this._nombreProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_cantidad", DbType="VarChar(10)")]
		public string cantidad
		{
			get
			{
				return this._cantidad;
			}
			set
			{
				if ((this._cantidad != value))
				{
					this._cantidad = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoProducto", DbType="VarChar(10)")]
		public string codigoProducto
		{
			get
			{
				return this._codigoProducto;
			}
			set
			{
				if ((this._codigoProducto != value))
				{
					this._codigoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_precio", DbType="VarChar(10)")]
		public string precio
		{
			get
			{
				return this._precio;
			}
			set
			{
				if ((this._precio != value))
				{
					this._precio = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nombreCliente", DbType="VarChar(10)")]
		public string nombreCliente
		{
			get
			{
				return this._nombreCliente;
			}
			set
			{
				if ((this._nombreCliente != value))
				{
					this._nombreCliente = value;
				}
			}
		}
	}
	
	public partial class pa_S_FichaTecnicaProductoFarmaciaResult
	{
		
		private string _codigoFichaTecProducto;
		
		private string _aprobar;
		
		private string _codigoFichaTecProveedor;
		
		private string _codigoProcedimiento;
		
		private string _descripcion;
		
		private string _etiquetado;
		
		private string _nombre;
		
		private string _posologia;
		
		private string _procedimiemtoDistribucion;
		
		private string _procedimientoAlmacen;
		
		private string _procedimientoVenta;
		
		private string _quimicoFarmaceutico;
		
		public pa_S_FichaTecnicaProductoFarmaciaResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoFichaTecProducto", DbType="VarChar(10) NOT NULL", CanBeNull=false)]
		public string codigoFichaTecProducto
		{
			get
			{
				return this._codigoFichaTecProducto;
			}
			set
			{
				if ((this._codigoFichaTecProducto != value))
				{
					this._codigoFichaTecProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_aprobar", DbType="VarChar(10)")]
		public string aprobar
		{
			get
			{
				return this._aprobar;
			}
			set
			{
				if ((this._aprobar != value))
				{
					this._aprobar = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoFichaTecProveedor", DbType="VarChar(10)")]
		public string codigoFichaTecProveedor
		{
			get
			{
				return this._codigoFichaTecProveedor;
			}
			set
			{
				if ((this._codigoFichaTecProveedor != value))
				{
					this._codigoFichaTecProveedor = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoProcedimiento", DbType="VarChar(10)")]
		public string codigoProcedimiento
		{
			get
			{
				return this._codigoProcedimiento;
			}
			set
			{
				if ((this._codigoProcedimiento != value))
				{
					this._codigoProcedimiento = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_descripcion", DbType="VarChar(10)")]
		public string descripcion
		{
			get
			{
				return this._descripcion;
			}
			set
			{
				if ((this._descripcion != value))
				{
					this._descripcion = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_etiquetado", DbType="VarChar(10)")]
		public string etiquetado
		{
			get
			{
				return this._etiquetado;
			}
			set
			{
				if ((this._etiquetado != value))
				{
					this._etiquetado = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nombre", DbType="VarChar(10)")]
		public string nombre
		{
			get
			{
				return this._nombre;
			}
			set
			{
				if ((this._nombre != value))
				{
					this._nombre = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_posologia", DbType="VarChar(50)")]
		public string posologia
		{
			get
			{
				return this._posologia;
			}
			set
			{
				if ((this._posologia != value))
				{
					this._posologia = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_procedimiemtoDistribucion", DbType="VarChar(255)")]
		public string procedimiemtoDistribucion
		{
			get
			{
				return this._procedimiemtoDistribucion;
			}
			set
			{
				if ((this._procedimiemtoDistribucion != value))
				{
					this._procedimiemtoDistribucion = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_procedimientoAlmacen", DbType="VarChar(255)")]
		public string procedimientoAlmacen
		{
			get
			{
				return this._procedimientoAlmacen;
			}
			set
			{
				if ((this._procedimientoAlmacen != value))
				{
					this._procedimientoAlmacen = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_procedimientoVenta", DbType="VarChar(255)")]
		public string procedimientoVenta
		{
			get
			{
				return this._procedimientoVenta;
			}
			set
			{
				if ((this._procedimientoVenta != value))
				{
					this._procedimientoVenta = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_quimicoFarmaceutico", DbType="VarChar(10)")]
		public string quimicoFarmaceutico
		{
			get
			{
				return this._quimicoFarmaceutico;
			}
			set
			{
				if ((this._quimicoFarmaceutico != value))
				{
					this._quimicoFarmaceutico = value;
				}
			}
		}
	}
	
	public partial class pa_S_ProductoResult
	{
		
		private string _codigoProducto;
		
		private string _descripcion;
		
		private string _nombreProducto;
		
		private string _pesoProducto;
		
		private string _presentacion;
		
		private string _tipoProducto;
		
		private System.DateTime _fecha;
		
		private string _autorizado;
		
		private string _motivo;
		
		private string _riesgo;
		
		public pa_S_ProductoResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_codigoProducto", DbType="VarChar(10) NOT NULL", CanBeNull=false)]
		public string codigoProducto
		{
			get
			{
				return this._codigoProducto;
			}
			set
			{
				if ((this._codigoProducto != value))
				{
					this._codigoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_descripcion", DbType="VarChar(50)")]
		public string descripcion
		{
			get
			{
				return this._descripcion;
			}
			set
			{
				if ((this._descripcion != value))
				{
					this._descripcion = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nombreProducto", DbType="VarChar(50)")]
		public string nombreProducto
		{
			get
			{
				return this._nombreProducto;
			}
			set
			{
				if ((this._nombreProducto != value))
				{
					this._nombreProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_pesoProducto", DbType="VarChar(10)")]
		public string pesoProducto
		{
			get
			{
				return this._pesoProducto;
			}
			set
			{
				if ((this._pesoProducto != value))
				{
					this._pesoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_presentacion", DbType="VarChar(10)")]
		public string presentacion
		{
			get
			{
				return this._presentacion;
			}
			set
			{
				if ((this._presentacion != value))
				{
					this._presentacion = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_tipoProducto", DbType="VarChar(50)")]
		public string tipoProducto
		{
			get
			{
				return this._tipoProducto;
			}
			set
			{
				if ((this._tipoProducto != value))
				{
					this._tipoProducto = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_fecha", DbType="Date NOT NULL")]
		public System.DateTime fecha
		{
			get
			{
				return this._fecha;
			}
			set
			{
				if ((this._fecha != value))
				{
					this._fecha = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_autorizado", DbType="NVarChar(50)")]
		public string autorizado
		{
			get
			{
				return this._autorizado;
			}
			set
			{
				if ((this._autorizado != value))
				{
					this._autorizado = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_motivo", DbType="NVarChar(100)")]
		public string motivo
		{
			get
			{
				return this._motivo;
			}
			set
			{
				if ((this._motivo != value))
				{
					this._motivo = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_riesgo", DbType="NVarChar(100)")]
		public string riesgo
		{
			get
			{
				return this._riesgo;
			}
			set
			{
				if ((this._riesgo != value))
				{
					this._riesgo = value;
				}
			}
		}
	}
}
#pragma warning restore 1591
