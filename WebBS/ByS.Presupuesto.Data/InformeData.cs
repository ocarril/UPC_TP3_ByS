using System;
using System.Collections.Generic;
using System.Configuration;
using ByS.Presupuesto.Entities;
using ByS.Presupuesto.Entities.DTO;
using log4net;

namespace ByS.Presupuesto.Data
{
    /// <summary>
    /// Proyecto    :  Modulo de Mantenimiento de : 
    /// Creacion    : WRF - Walter Rodriguez
    /// Fecha       : 26/01/2016-12:29:08 a.m.
    /// Descripcion : Capa de Lógica 
    /// Archivo     : [Presupuesto.InformeData.cs]
    /// </summary>
    public class InformeData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(InformeData));
        private string conexion = string.Empty;

        //Informe data


        public InformeData()
        {
            conexion = Util.ConexionBD();
        }
   
      

      
    }
} 
