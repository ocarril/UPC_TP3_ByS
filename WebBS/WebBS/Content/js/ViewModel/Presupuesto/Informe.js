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

});

/**********************************************************************
Nombre: fnu_buscar
Funcion: Configuración de grilla para el presupuesto en ejecucion
**********************************************************************/
(function ($) {

    $.fnu_buscar = function () {
        alert('111111');
        'use strict';

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
            colNames: ['', '', '', 'Area', 'Partida', 'Descripcion', 'Cantidad', 'Estimado Total', 'Fecha Ejecución', 'Estado', 'Tipo', 'Editado el ', 'Editado por'],
            colModel: [
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatNuevo, sortable: false, hidden: true },
                { name: 'btnEdita', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditar, sortable: false, hidden: true },
                { name: 'btnElimina', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEliminar, sortable: false, hidden: true },
                { name: 'codAreaNombre', index: 'codAreaNombre', editable: true, width: 140, align: 'left' },
                { name: 'codPartidaNombre', index: 'codPartidaNombre', editable: true, width: 140, align: 'left' },
                { name: 'gloDescripcion', index: 'gloDescripcion', editable: false, width: 210, align: 'left' },
                { name: 'cntCantidad', index: 'cntCantidad', editable: false, width: 80, align: 'right' },
                { name: 'monEstimado', index: 'monEstimado', editable: false, width: 90, align: 'right' },
                { name: 'fecEjecucion', index: 'fecEjecucion', editable: false, width: 100, align: 'center' },
                { name: 'codRegEstadoNombre', index: 'codRegEstadoNombre', editable: false, width: 120, align: 'left' },
                { name: 'indPlantillaNombre', index: 'indPlantillaNombre', editable: false, width: 100, align: 'left' },
                { name: 'segFechaEdita', index: 'segFechaEdita', editable: true, width: 150, align: 'left' },
                { name: 'segUsuarioEdita', index: 'segUsuarioEdita', editable: true, width: 110, align: 'left' }
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
            altRows: true
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

        alert('2222');
        
        // Leer los datos para la petición
        var vnumAnio = $('#txtAnio').val();
        var vcodArea = $('#cboAreas').val();
        var parametros = Object();
        parametros["p_TamPagina"] = postData.rows;
        parametros["p_NumPagina"] = postData.page;
        parametros["p_OrdenPor"] = postData.sidx;
        parametros["p_OrdenTipo"] = postData.sord;
        parametros["numAnio"] = vnumAnio;
        parametros["codArea"] = vcodArea;

        var paramAjax = Object();
        paramAjax["ajaxMessage"] = 'Listando detalle de plantillas presuestales del año actual.11111..';
        paramAjax["url"] = "/Presupuesto/ListarPlantillaDetalle";
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
