/***********************************************************************
Método     : Plantilla.js
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
 

    $('#btnLimpiar').bind('click', function (event) {

        $('#dataForm').find('input[type=text], select').val('');
    });

    $('#btnBuscar').bind('click', function (event) {

        $.f_reloadGrid('gridTabla');
    });
 
    
    $("#cboAreas").change(function () {

        $.f_reloadGrid('gridPresupActual');
    });

   // $.fnu_cargarPlantilla();
    $.fnu_configuraGridEnEjecucion();
    $('#txtsegUsuarioEdita').attr('Disabled', true);
    $('#txtsegFechaEdita').attr('Disabled', true);
    $('#txtAnio').attr('Disabled', true);
    $('#txtAnioPre').attr('Disabled', true);
    $('#txtEstadoPlantilla').attr('Disabled', true);
    $('#txtnumPlantilla').attr('Disabled', true);
    $('#txtDesArea').attr('Disabled', true);
    $('#txtResponsableActual').attr('Disabled', true);
    $('#txtPresupuesto').attr('Disabled', true);
    $('#txtFechaCierre').attr('Disabled', true);
    $('#txtmonMaximo').attr('Disabled', true);
    $('#txtmonEstimadoTotal').attr('Disabled', true);
    $('#txtFechaExtemporaneo').attr('Disabled', true);
    $('#txtprcPenalidad').attr('Disabled', true);
    $('#txtAnio').val($('#hddnumAnio').val());
    $.f_formatoFechas("txtfecEjecucion");
});
(function ($) {
    $.fnu_cargarPlantilla = function () {
        'use strict';
        alert('aaa');
        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Cargando ...';
        paramAjax["success"] = function (data) {
            var plantilla = data.Data;
            $('#txtAnio').val(plantilla.numAnio);
          
          
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

/**********************************************************************
Nombre: fnu_configuraGridEnEjecucion
Funcion: Configuración de grilla para el presupuesto en ejecucion
**********************************************************************/
(function ($) {

    $.fnu_configuraGridEnEjecucion = function () {
        'use strict';

        var gridWidth = window.screen.width * 0.9 - 55;
        $('[id*=gridTabla]').jqGrid({
            width: gridWidth,
            autowidth: true,
            shrinkToFit: false, 
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




