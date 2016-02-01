/***********************************************************************
Método     : Informe.js
Propósito  : Manejo de la pagina de generación de informes de Presupuestos 
Se asume   : N/A
Efectos    : N/A
Notas      : N/A
Autor      : (WRF) Walter Rodriguez.
Fecha/Hora de Creación : 24/01/2016- 13:22hr
Modificado : N/A
Fecha/Hora : N/A
***********************************************************************/
$(document).ready(function () {
    'use strict';

   
    $('#btnBuscar').bind('click', function (event) {
        
        $.fnu_buscar();
    });


    $('#txtAnio').val($('#hddnumAnio').val());
});

/**********************************************************************
Nombre: fnu_buscar
Funcion: Configuración de grilla para el presupuesto en ejecucion
**********************************************************************/
(function ($) {

    $.fnu_buscar = function () {
            'use strict';
            var  paginador;
        var gridWidth = window.screen.width * 0.9 - 55;
        $('[id*=gridTabla]').jqGrid({
            width: gridWidth,
            autowidth: true,
            shrinkToFit: false,
            datatype: $.getDataTablaEjec,
            jsonReader:
            {
                root: "Items",
                page: "CurrentPage",
                total: "PageCount",
                records: "RecordCount",
                repeatitems: true,
                cell: "Row",
                id: "ID"
            },
            mtype: 'POST',
            colNames: ['Area', 'Partida', 'Descripcion', 'Cantidad', 'Estimado Total', 'Fecha Ejecución', 'Estado', 'Tipo', 'Editado el ', 'Editado por'],
            colModel: [
               { name: 'Nombre de Area', index: 'codAreaNombre', editable: true, width: 140, align: 'left' },
                { name: 'Partida', index: 'codPartidaNombre', editable: true, width: 140, align: 'left' },
                { name: 'Descripcion', index: 'gloDescripcion', editable: false, width: 210, align: 'left' },
                { name: 'Cantidad', index: 'cntCantidad', editable: false, width: 80, align: 'right' },
                { name: 'Monto Estimado', index: 'monEstimado', editable: false, width: 90, align: 'right' },
                { name: 'Fecha Ejecucion', index: 'fecEjecucion', editable: false, width: 100, align: 'center' },
                { name: 'Estado', index: 'codRegEstadoNombre', editable: false, width: 120, align: 'left' },
                { name: 'Tipo de partida', index: 'indPlantillaNombre', editable: false, width: 100, align: 'left' },
                { name: 'Editado', index: 'segFechaEdita', editable: true, width: 150, align: 'left' },
                { name: 'Usuario', index: 'segUsuarioEdita', editable: true, width: 110, align: 'left' }
            ],
            pager: 'pagerTabla',
            pagerpos: "center",
            loadtext: 'Cargando datos',
            recordtext: "{0} - {1} de {2}",
            emptyrecords: 'vacío',
            pgtext: 'Pág: {0} de {1}',
            rowNum: 10,
            rowList: [10, 20, 40, 80],
            sortname: 'codPartidaNombre',
            sortorder: "asc",
            viewrecords: true,
            caption: 'Listado',
            height: 'auto',
            rownumbers: true,
            altRows: true,
         
            subGrid: true,
        subGridOptions: {
            expandOnLoad: false,
            selectOnExpand: false,
            reloadOnExpand: false
        },
        subGridRowExpanded: function (idSubgrid, rowID) {
            var pIdSubGrid = idSubgrid + "_t";
            var pIdSubPager = "p_" + pIdSubGrid;
            $("#" + idSubgrid).html("<table id='" + pIdSubGrid + "'></table><div id='" + pIdSubPager + "'></div>");
            $.configuraGrillaGasto(pIdSubGrid, pIdSubPager, rowID);
        }
        });
        //Agregar el Boton Exportar a Excel//
        paginador = $("#gridTabla").getGridParam('pager');
        jQuery("#gridTabla").navGrid(paginador, {
            edit: false,
            add: false,
            del: false,
            search: false,
            refresh: false
        }).navButtonAdd(paginador, {
            caption: "Exportar Excel",
            buttonicon: "ui-icon-export",
            onClickButton: function () {
                $("#gridTabla").jqGrid('exportarExcelCliente', { nombre: "HOJATEST", formato: "excel" });
                //console.log($("#tb_ejemplo").jqGrid('exportarTextoCliente'));
            },
            position: "last"
        });

    $(".ui-jqgrid-titlebar").hide();
    }
})(jQuery);


/**********************************************************************
  Nombre: $.getDataTablaEjec
  Funcion: Se dispara para realizar una petición de la data actualizada 
           del jQGrid de Datos
 ***********************************************************************/
(function ($) {
    $.getDataTablaEjec = function (postData) {
        'use strict';

        
        // Leer los datos para la petición
        var vnumAnio = $('#txtAnio').val();
        var vcodArea = $('#cboAreas').val();
        var vcodEstado = $('#cboEstado').val();
        var vmesIni = $('#cboMesIni').val();
        var vmesFin = $('#cboMesFin').val();
        var parametros = Object();
        parametros["p_TamPagina"] = postData.rows;
        parametros["p_NumPagina"] = postData.page;
        parametros["p_OrdenPor"] = postData.sidx;
        parametros["p_OrdenTipo"] = postData.sord;
        parametros["numAnio"] = vnumAnio;
        parametros["codArea"] = vcodArea;
        parametros["codRegEstado"] = vcodEstado;
        parametros["mesIni"] = vmesIni;
        parametros["mesFin"] = vmesFin;

        var paramAjax = Object();
        paramAjax["ajaxMessage"] = 'Listando detalle de plantillas presuestales del año actual...';
        paramAjax["url"] = "/Presupuesto/ListarSeguimientoPresupuesto";
        paramAjax["data"] = JSON.stringify(parametros);
        paramAjax["error"] = $.f_ajaxRequestFailed;
        paramAjax["success"] = function (response, status) {  /* Función callback */
            if (status == 'success') {
                var tipo = response.Type;
                var mensaje = response.Data;
                if (tipo == "E")
                    $.f_Mensaje(mensaje, false, true, 1);
                else if (tipo == "I")
                    $.f_Mensaje(mensaje, false, true);
                else
                    $.getDataTablaEjecSuccess(response, status);
            }
            else
                $.f_Mensaje(response.responseText, true, true, 1);
        }


        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

/**********************************************************************
 Nombre: $.getDataTablaEjecSuccess
 Funcion: Función callback luego de solicitar data para el jQGrid
 **********************************************************************/
(function ($) {
    $.getDataTablaEjecSuccess = function (response, status) {
        'use strict';

        if (status == 'success') {
            var tipo = response.Type;
            var mensaje = response.Data;
            if (tipo == 'E')
                $.f_Mensaje(mensaje, true, true, 1);
            else if (tipo == 'I')
                $.f_Mensaje(mensaje, true, true);
            else if (tipo == 'C') {
                $("#gridTabla")[0].addJSONData(mensaje);
            }
        }
    }
})(jQuery);

//**********************************************************************
// Nombre: configuraGrillaGasto
// Funcion: Configuración grilla de Registros de Gastos
//**********************************************************************
(function ($) {
    $.configuraGrillaGasto = function (subGridID, pagerSubGridID, rowID) {
        'use strict';

        var widthGrid = window.screen.width * 0.9 - 90;

        $('#' + subGridID).jqGrid({
            width: widthGrid,
            shrinkToFit: false,

            datatype: function (postData) {

                window.sessionStorage.setItem('idSubGrid', subGridID);

                var parametro = Object();
                parametro["p_TamPagina"] = postData.rows;
                parametro["p_NumPagina"] = postData.page;
                parametro["p_OrdenPor"] = postData.sidx;
                parametro["p_OrdenTipo"] = postData.sord;
                parametro['codPlantillaDeta'] = rowID;

                var paramAjax = Object();
                paramAjax['ajaxMessage'] = 'Cargando gastos de la partida...';
                paramAjax['url'] = '/Presupuesto/ListarSeguimientoPresupuestoDetalle';
                paramAjax['data'] = JSON.stringify(parametro);
                paramAjax['error'] = $.f_ajaxRequestFailed;
                paramAjax['success'] = $.getDataGastoSuccess;

                $.f_ajaxRespuesta(paramAjax);
            },

            jsonReader: //Set the jsonReader to the JQGridJSonResponse squema to bind the data.
            {
                root: "Items",
                page: "CurrentPage",
                total: "PageCount",
                records: "RecordCount",
                repeatitems: true,
                cell: "Row",
                id: "ID" //index of the column with the PK in it    
            },
            mtype: 'POST',
            colNames: ['', '', 'Nro Documento', 'Fecha Gasto', 'Cantidad', 'Monto Gastado', 'Responsable', 'Observaciones', 'Editado el ', 'Editado por'],
            colModel: [
                    { name: 'Editar', index: 'Editar', width: 35, align: 'center', editable: false, formatter: $.formatEditarReg, sortable: false, hidden: true },
                    { name: 'Eliminar', index: 'Eliminar', width: 35, align: 'center', editable: false, formatter: $.formatEliminarReg, sortable: false, hidden: true },
                    { name: 'numDocumento', index: 'numDocumento', editable: true, width: 130, align: 'left' },
                    { name: 'fecGasto', index: 'fecGasto', editable: true, width: 100, align: 'left' },
                    { name: 'cntCantidad', index: 'cntCantidad', editable: true, width: 80, align: 'left' },
                    { name: 'monTotal', index: 'monTotal', editable: true, width: 90, align: 'left', formatter: 'currency', prefix: 'S/.' },
                    { name: 'codEmpResponsable', index: 'codEmpResponsable', editable: true, width: 180, align: 'left' },
                    { name: 'gloObservacion', index: 'gloObservacion', editable: true, width: 250, align: 'left' },
                    { name: 'segFechaEdita', index: 'segFechaEdita', editable: true, width: 150, align: 'left', search: false, hidden: true },
                    { name: 'segUsuarioEdita', index: 'segUsuarioEdita', editable: true, width: 70, align: 'left', search: false, hidden: true }
            ],

            pager: pagerSubGridID,
            pagerpos: "left",
            loadtext: 'Cargando datos...',
            recordtext: "{0} - {1} de {2}",
            emptyrecords: 'vacío',
            pgtext: 'Pág: {0} de {1}',
            rowNum: 5,
            rowList: [5, 10, 20, 40, 80],
            sortname: 'fecGasto',
            sortorder: "asc",
            viewrecords: true,
            caption: 'Listado',
            height: 'auto',
            altRows: false
        }).jqGrid(); //'filterToolbar', { stringResult: true, searchOnEnter: true }

        $.f_cssGridApply(false, 1);
    }
})(jQuery);
//**********************************************************************
// Nombre: $.getDataGastoSuccess
// Funcion: Función callback luego de solicitar data para el jQGrid de clientes
//**********************************************************************
(function ($) {
    $.getDataGastoSuccess = function (response, status) {
        'use strict';

        if (status == 'success') {
            var tipo = response.Type;
            var mensaje = response.Data;

            if (tipo == 'E')
                $.f_Mensaje(mensaje, true, true);
            else if (tipo == 'I')
                $.f_Mensaje(mensaje, true, true);
            else if (tipo == 'C') {
                var data = mensaje;
                var idSubGrid = window.sessionStorage.getItem('idSubGrid');
                var grid = $("#" + idSubGrid)[0];
                grid.addJSONData(data);
            }
        }
        else
            $.f_Mensaje(response.responseText, true, true, 1);
    }
})(jQuery);
//**********************************************************************
// Nombre: exportGrid
// Funcion: Exportar Excel
//**********************************************************************

(function ($) {
    $.jgrid.extend({
        exportarExcelCliente: function (o) {
            var archivoExporta, hojaExcel;
            archivoExporta = {
                worksheets: [
                    []
                ],
                creator: "Arcmop",
                created: new Date(),
                lastModifiedBy: "Arcmop",
                modified: new Date(),
                activeWorksheet: 0
            };
            hojaExcel = archivoExporta.worksheets[0];
            hojaExcel.name = o.nombre;

            var arrayCabeceras = new Array();
            arrayCabeceras = $(this).getDataIDs();
            var dataFilaGrid = $(this).getRowData(arrayCabeceras[0]);
            var nombreColumnas = new Array();
            var ii = 0;
            for (var i in dataFilaGrid) {
                nombreColumnas[ii++] = i;
            }
            hojaExcel.push(nombreColumnas);
            var dataFilaArchivo;
            for (i = 0; i < arrayCabeceras.length; i++) {
                dataFilaGrid = $(this).getRowData(arrayCabeceras[i]);
                dataFilaArchivo = new Array();
                for (j = 0; j < nombreColumnas.length; j++) {
                    dataFilaArchivo.push(dataFilaGrid[nombreColumnas[j]]);
                }
                hojaExcel.push(dataFilaArchivo);
            }
            return window.location = xlsx(archivoExporta).href();
        },
        exportarTextoCliente: function (o) {
            var arrayCabeceras = new Array();
            arrayCabeceras = $(this).getDataIDs();
            var dataFilaGrid = $(this).getRowData(arrayCabeceras[0]);
            var nombreColumnas = new Array();
            var ii = 0;
            var textoRpta = "";
            for (var i in dataFilaGrid) {
                nombreColumnas[ii++] = i;
                textoRpta = textoRpta + i + "\t";
            }
            textoRpta = textoRpta + "\n";
            for (i = 0; i < arrayCabeceras.length; i++) {
                dataFilaGrid = $(this).getRowData(arrayCabeceras[i]);
                for (j = 0; j < nombreColumnas.length; j++) {
                    textoRpta = textoRpta + dataFilaGrid[nombreColumnas[j]] + "\t";
                }
                textoRpta = textoRpta + "\n";
            }
            textoRpta = textoRpta + "\n";
            return textoRpta;
        }
    });
})(jQuery);