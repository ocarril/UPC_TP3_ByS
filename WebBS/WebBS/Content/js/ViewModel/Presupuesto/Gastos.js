﻿/***********************************************************************
Método     : Gastos.js
Propósito  : Manejo de la pagina de registro de Plantillas de Presupuestos 
Se asume   : N/A
Efectos    : N/A
Notas      : N/A
Autor      : (OCR) Orlando Carril Ramirez.
Fecha/Hora de Creación : 20/08/2015- 09:25am
Modificado : N/A
Fecha/Hora : N/A
***********************************************************************/
$(document).ready(function () {
    'use strict';

    $('#btnLimpiar').bind('click', function (event) {

        $('#dataForm').find('input[type=text], select').val('');
    });

    $('#btnBuscar').bind('click', function (event) {

        var blnChecked = document.getElementsByName("chkVerGasto")[0].checked;
        if (blnChecked==true) {
            $('#divListaGasto').attr('class', 'capaMostrar');
            $('#divLista').attr('class', 'capaOcultar');
            $.f_reloadGrid('gridTablaGasto');
        }
        else {
            $('#divListaGasto').attr('class', 'capaOcultar');
            $('#divLista').attr('class', 'capaMostrar');
            $.f_reloadGrid('gridTabla');
        }
    });

    $('#chkVerGasto').bind('click', function (event) {

        if (this.checked == true) {
            $('#divListaGasto').attr('class', 'capaMostrar');
            $('#divLista').attr('class', 'capaOcultar');
            $.fnu_configuraGridGasto();
        }
        else {
            $('#divListaGasto').attr('class', 'capaOcultar');
            $('#divLista').attr('class', 'capaMostrar');
            $.fnu_configuraGridTabla();
        }
    });

    $('#txtAnio').val($('#hddnumAnio').val());
    $('#txtsegUsuarioEdita').attr('Disabled', true);
    $('#txtsegFechaEdita').attr('Disabled', true);
    $('#txtAnio').attr('Disabled', true);
    $('#txtmonTotalPresupuesto').attr('Disabled', true);
    $('#txtmonTotalSolicitado').attr('Disabled', true);
    $('#txtmonTotalGastado').attr('Disabled', true);
    $.f_formatoFechas("txtfecGasto");
    $.fnu_MostrarTotalesPresupuesto();
});

/**********************************************************************
Nombre: configuraGrilla
Funcion: Configuración de grilla
**********************************************************************/
(function ($) {

    $.fnu_configuraGridTabla = function () {
        'use strict';

        var gridWidth = window.screen.width * 0.9 - 55;
        $('[id*=gridTabla]').jqGrid({
            width: gridWidth,
            autowidth: true,
            shrinkToFit: false,
            datatype: $.getDataTabla,
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
            colNames: ['', '', '','Area', 'Partida', 'Descripcion', 'Cantidad', 'Estim.Total', 'Fec-Ejecución', 'Estado', 'Tipo', 'Editado el ', 'Editado por'],
            colModel: [
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatPago, sortable: false },
                { name: 'btnEdita', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditar, sortable: false, hidden: true },
                { name: 'btnElimina', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEliminar, sortable: false, hidden: true },
                { name: 'codAreaNombre', index: 'codAreaNombre', editable: true, width: 120, align: 'left' },
                { name: 'codPartidaNombre', index: 'codPartidaNombre', editable: true, width: 140, align: 'left' },
                { name: 'gloDescripcion', index: 'gloDescripcion', editable: false, width: 210, align: 'left' },
                { name: 'cntCantidad', index: 'cntCantidad', editable: false, width: 60, align: 'right' },
                { name: 'monEstimado', index: 'monEstimado', editable: false, width: 75, align: 'right' },
                { name: 'fecEjecucion', index: 'fecEjecucion', editable: false, width: 80, align: 'center' },
                { name: 'codRegEstadoNombre', index: 'codRegEstadoNombre', editable: false, width: 110, align: 'left' },
                { name: 'indPlantillaNombre', index: 'indPlantillaNombre', editable: false, width: 70, align: 'left' },
                { name: 'segFechaEdita', index: 'segFechaEdita', editable: true, width: 135, align: 'left' },
                { name: 'segUsuarioEdita', index: 'segUsuarioEdita', editable: true, width: 120, align: 'CENTER' }
                ],
            pager: 'pagerTabla',
            pagerpos: "center",
            loadtext: 'Cargando datos',
            recordtext: "{0} - {1} de {2}",
            emptyrecords: 'No existen partida aprobada para ejecución',
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

        $(".ui-jqgrid-titlebar").hide();
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
                paramAjax['url'] = '/Presupuesto/ListarGasto';
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
            colNames: ['', '', 'Nro Documento', 'Fecha Gasto', 'Cantidad', 'Monto Gastado','Responsable','Observaciones', 'Editado el ', 'Editado por'],
            colModel: [
                    { name: 'Editar', index: 'Editar', width: 35, align: 'center', editable: false, formatter: $.formatEditarReg, sortable: false },
                    { name: 'Eliminar', index: 'Eliminar', width: 35, align: 'center', editable: false, formatter: $.formatEliminarReg, sortable: false},
                    { name: 'numDocumento', index: 'numDocumento', editable: true, width: 130, align: 'left' },
                    { name: 'fecGasto', index: 'fecGasto', editable: true, width: 100, align: 'left'},
                    { name: 'cntCantidad', index: 'cntCantidad', editable: true, width: 80, align: 'left'},
                    { name: 'monTotal', index: 'monTotal', editable: true, width: 90, align: 'left', formatter: 'currency', prefix: 'S/.' },
                    { name: 'codEmpResponsable', index: 'codEmpResponsable', editable: true, width: 180, align: 'left' },
                    { name: 'gloObservacion', index: 'gloObservacion', editable: true, width: 250, align: 'left' },
                    { name: 'segFechaEdita', index: 'segFechaEdita', editable: true, width: 150, align: 'left', search: false },
                    { name: 'segUsuarioEdita', index: 'segUsuarioEdita', editable: true, width: 70, align: 'left', search: false }
            ],

            pager: pagerSubGridID,
            pagerpos: "left",
            loadtext: 'Cargando datos...',
            recordtext: "{0} - {1} de {2}",
            emptyrecords: 'No se econtraron registros de gastos...',
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

/**********************************************************************
  Nombre: $.getDataTabla
  Funcion: Se dispara para realizar una petición de la data actualizada 
           del jQGrid de Datos
 ***********************************************************************/
(function ($) {
    $.getDataTabla = function (postData) {
        'use strict';

        // Leer los datos para la petición
        var vnumAnio = $('#hddnumAnio').val();
        var vcodArea = $('#cboAreas').val();
        var vcodRegEstado = 4;
        var parametros = Object();
        parametros["p_TamPagina"] = postData.rows;
        parametros["p_NumPagina"] = postData.page;
        parametros["p_OrdenPor"] = postData.sidx;
        parametros["p_OrdenTipo"] = postData.sord;
        parametros["numAnio"] = vnumAnio;
        parametros["codArea"] = vcodArea;
        parametros["codRegEstado"] = vcodRegEstado;
        
        var paramAjax = Object();
        paramAjax["ajaxMessage"] = 'Listando detalle de plantillas presuestales...';
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
                    $.getDataTablaSuccess(response, status);
            }
            else
                $.f_Mensaje(response.responseText, true, true, 1);
        }


        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

/**********************************************************************
 Nombre: $.getDataTablaSuccess
 Funcion: Función callback luego de solicitar data para el jQGrid
 **********************************************************************/
(function ($) {
    $.getDataTablaSuccess = function (response, status) {
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

/***********************************************************************
Nombre: $.formatDetalle (OCR)
Funcion: Formatea columna de Detalle de la grilla de DOCUMENTO
************************************************************************/
(function ($) {
    $.formatPago = function (cellvalue, options, rowObject) {
        'use strict';

        var srcImage = '../Content/Images/Pagos.png';
        var image;
        image = "<a href='#' onclick=\"$.fnu_showDialogAgregarGasto('" + options.rowId + "', 0);\"><img title='Pago para detalle de plantilla presupuestal' src='" + srcImage + "' border='0' id='imgNuevoRegistro' /></a>";
        return image;
    }
})(jQuery);

/*******************************************************
Pantalla POPUP para editar registro de Tabla
********************************************************/
(function ($) {
    $.fnu_showDialogAgregarGasto = function (codPlantillaDeta) {
        'use strict';

        $('#hddcodPlantillaDeta').val(codPlantillaDeta);
        $.fnu_showDialogEditGasto(0);
        $.fnu_MostrarRegistroGasto(0);
    };
})(jQuery);

/*******************************************************
Pantalla POPUP para editar registro de Tabla
********************************************************/
(function ($) {
    $.fnu_showDialogEditGasto = function (codGasto) {
        'use strict';

        var divID = 'divRegistro';
        var modal = true;
        var title = ''; //'Datos del gasto presupuestal';
        var width = 'auto';
        var height = null;
        var draggable = true;
        var resizable = false;
        var buttons = {
            'Cerrar': function (event) {
                $(this).dialog('close');
            },
            'Guardar': function () {
                $.fnu_GuardarGasto(this);
            }
        };
        $.f_dialog_open_noButtons(divID, modal, title, width, height, draggable, resizable).dialog({ buttons: buttons })
        .dialog({
            beforeClose: function (event, ui) {
                $('#divRegistro').find(':text, select').val('');  // Limpiar campos del popup
            }
        });
        $.f_dialogCssApply(divID);
        $.fnu_MostrarRegistroGasto(codGasto);

    };
})(jQuery);

(function ($) {
    $.fnu_MostrarRegistroGasto = function (codGasto) {
        'use strict';

        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Cargando registro de presupuesto...';
        paramAjax["url"] = '/Presupuesto/BuscarGasto' + '?pId=' + codGasto;
        paramAjax["success"] = function (data) {
            var detalle = data.Data;
            var responsable = data.Empleados;
            $('#hddcodGasto').val(detalle.Codigo);
            $.f_loadComboFromArray(responsable, 'cbocodEmpleadoResp', true, detalle.codEmpleadoResp, false);
            $('#txtgloObservacion').val(detalle.gloObservacion);
            $('#txtcntCantidad').val(detalle.cntCantidad);
            $('#txtmonTotal').val(detalle.monTotal);
            $('#txtnumDocumento').val(detalle.numDocumento);
            $('#txtfecGasto').val($.f_formatoFechaDDMMYYYY(detalle.fecGasto));
            $('#txtsegUsuarioEdita').val(detalle.segUsuarioEdita);
            $('#txtsegFechaEdita').val($.f_formatoFechaDDMMYYYY(detalle.segFechaEdita,true));

        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

(function ($) {
    $.fnu_MostrarTotalesPresupuesto = function () {
        'use strict';

        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Cargando totales de presupuesto...';
        paramAjax["url"] = '/Presupuesto/BuscarPresupuesto' + '?pId=' + $('#hddnumAnio').val();
        paramAjax["success"] = function (data) {
            var detalle = data.Data;
            $('#txtmonTotalPresupuesto').val(detalle.monTotalPresupuesto);
            $('#txtmonTotalSolicitado').val(detalle.monTotalSolicitado);
            $('#txtmonTotalGastado').val(detalle.monTotalGastado);
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

(function ($) {
    $.fnu_GuardarGasto = function (context) {
        'use strict';

        var objGasto = $.fnu_ValidarGasto();
        if (objGasto.Mensaje.length > 0) {
            $.f_Mensaje(objGasto.Mensaje, false, true);
            return;
        }

        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Guardando gasto presupuestal...';
        paramAjax["url"] = '/Presupuesto/GuardarGasto';
        paramAjax["data"] = JSON.stringify(objGasto);
        paramAjax["success"] = function (response, status) {
            if (status == 'success') {
                var tipo = response.Type;
                var mensaje = response.Data;
                if (tipo == "E")
                    $.f_Mensaje(mensaje, false, true, 1);
                else if (tipo == "I")
                    $.f_Mensaje(mensaje, false, true);
                else if (tipo == "C") {
                    $.f_Mensaje(mensaje, true, true, 3);
                    $(context).dialog('close');
                    $.f_reloadGrid('gridTabla');
                    $.fnu_MostrarTotalesPresupuesto();
                }
            }
            else
                $.f_Mensaje(response.responseText, true, true);
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

(function ($) {
    $.fnu_ValidarGasto = function () {
        'use strict';

        var strValidado = '';
        var vcodGasto = $('#hddcodGasto').val();
        var vcodPlantillaDeta = $('#hddcodPlantillaDeta').val();
        var vcodEmpleadoResp = $('#cbocodEmpleadoResp').val();
        var vgloObservacion = $('#txtgloObservacion').val();
        var vcntCantidad = parseFloat($('#txtcntCantidad').val());
        var vmonTotal = parseFloat($('#txtmonTotal').val());
        var vnumDocumento = $('#txtnumDocumento').val();
        var vfecGasto = $('#txtfecGasto').val();
        if (vcodEmpleadoResp == '')
            strValidado = strValidado + 'Seleccionar empleado responsable <br/>';
        if (vgloObservacion == '')
            strValidado = strValidado + 'Ingresar observación con respecto al gasto <br/>';
        if (vcntCantidad <= 0)
            strValidado = strValidado + 'Ingresar cantidad minima.<br/>';
        if (vnumDocumento == '')
            strValidado = strValidado + 'Ingresar Nro documento de referencia.<br/>';
        if (vmonTotal <= 0)
            strValidado = strValidado + 'Ingresar monto total dl gasto.<br/>';
        if (vfecGasto == '')
            strValidado = strValidado + 'Ingresar fecha del gasto.<br/>';

        var fechaMim = String(vfecGasto.substring(6, 10)) +
                        String(vfecGasto.substring(3, 5)) +
                        String(vfecGasto.substring(0, 2));
        var fecha = $('#hddnumAnio').val() + '1231';
        if (fechaMim > fecha)
            strValidado = strValidado + 'El año de la fecha es incorrecta <br/>';

        var pobjGasto = {};
        pobjGasto["Codigo"] = vcodGasto;
        pobjGasto["codPlantillaDeta"] = vcodPlantillaDeta;
        pobjGasto["codEmpleadoResp"] = vcodEmpleadoResp;
        pobjGasto["monTotal"] = vmonTotal;
        pobjGasto["cntCantidad"] = vcntCantidad;
        pobjGasto["fecGasto"] = vfecGasto;
        pobjGasto["gloObservacion"] = vgloObservacion;
        pobjGasto["numDocumento"] = vnumDocumento;
        pobjGasto["Mensaje"] = strValidado;
        return pobjGasto;
    }
})(jQuery);

/***********************************************************************
Nombre: $.formatEditarReg 
Funcion: Formatea columna de edición de la grilla de Gasto
************************************************************************/
(function ($) {
    $.formatEditarReg = function (cellvalue, options, rowObject) {
        'use strict';

        var srcImage = '../Content/Images/icoEditar.png';
        var image;
        image = "<a href='#' onclick=\"$.fnu_showDialogEditGasto('" + options.rowId + "');\"><img title='Editar registro del gasto' src='" + srcImage + "' border='0' id='imgEditarRegistro' /></a>";
        return image;
    }
})(jQuery);

/***********************************************************************
Nombre: $.formatEliminarReg 
Funcion: Formatea columna de eliminación de la grilla de Gasto
************************************************************************/
(function ($) {
    $.formatEliminarReg = function (cellvalue, options, rowObject) {
        'use strict';

        var srcImage = '../Content/Images/icoEliminar.png';
        var image;
        image = "<a href='#' onclick=\"$.fnu_showDialogEliminaReg('" + options.rowId + "');\"><img title='Eliminar registro del gasto' src='" + srcImage + "' border='0' id='imgEliminarRegistro' /></a>";
        return image;
    }
})(jQuery);

(function ($) {
    $.fnu_showDialogEliminaReg = function (codReg) {
        'use strict';

        var mensajeOK = new CROMMessageBox({
            contenido: '¿Confirma la eliminación del gasto de la partida presupuestal:?',
            tipo: 4,
            botones: [
                    {
                        Etiqueta: "Aceptar",
                        Click: function () { $.fnu_eliminarRegistro(codReg); }
                    },
                    {
                        Etiqueta: "Cancelar"
                    }]
        });
        mensajeOK.Mostrar();
    }
})(jQuery);

(function ($) {
    $.fnu_eliminarRegistro = function (codReg) {
        'use strict';

        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Eliminando gasto de la partida presupuestal...';
        paramAjax["url"] = '/Presupuesto/EliminarGasto' + '?pId=' + codReg
        paramAjax["error"] = $.f_ajaxRequestFailed;
        paramAjax["success"] = function (response, status) {
            if (status == 'success') {
                var tipo = response.Type;
                var mensaje = response.Data;
                if (tipo == "E")
                    $.f_Mensaje(mensaje, false, true, 1);
                else if (tipo == "I")
                    $.f_Mensaje(mensaje, false, true);
                else if (tipo == "C") {
                    $.f_Mensaje(mensaje, true, true, 3);
                    $.f_reloadGrid(window.sessionStorage.getItem('idSubGrid'));
                    $.f_reloadGrid('gridTablaGasto');
                    $.fnu_MostrarTotalesPresupuesto();
                }
            }
            else
                $.f_Mensaje(response.responseText, true, true);
        }

        $.f_ajaxRespuesta(paramAjax);

    }
})(jQuery);


/**********************************************************************
Nombre: configuraGrilla
Funcion: Configuración de grilla de Gastos
**********************************************************************/
(function ($) {

    $.fnu_configuraGridGasto = function () {
        'use strict';

        var gridWidth = window.screen.width * 0.9 - 55;
        $('[id*=gridTablaGasto]').jqGrid({
            width: gridWidth,
            autowidth: true,
            shrinkToFit: false,
            datatype: $.getDataTablaGasto,
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
            colNames: ['', '', 'Nro Documento', 'Fecha Gasto', 'Cantidad', 'Monto Gastado', 'Responsable', 'Observaciones','Area','Presupuesto', 'Editado el ', 'Editado por'],
            colModel: [
                    { name: 'Editar', index: 'Editar', width: 35, align: 'center', editable: false, formatter: $.formatEditarReg, sortable: false },
                    { name: 'Eliminar', index: 'Eliminar', width: 35, align: 'center', editable: false, formatter: $.formatEliminarReg, sortable: false },
                    { name: 'numDocumento', index: 'numDocumento', editable: true, width: 130, align: 'left' },
                    { name: 'fecGasto', index: 'fecGasto', editable: true, width: 100, align: 'center' },
                    { name: 'cntCantidad', index: 'cntCantidad', editable: true, width: 80, align: 'right' },
                    { name: 'monTotal', index: 'monTotal', editable: true, width: 90, align: 'right' },
                    { name: 'codEmpResponsable', index: 'codEmpResponsable', editable: true, width: 180, align: 'left' },
                    { name: 'gloObservacion', index: 'gloObservacion', editable: true, width: 250, align: 'left' },
                    { name: 'codAreaNombre', index: 'codAreaNombre', editable: true, width: 200, align: 'left' },
                    { name: 'codPresupuestoNombre', index: 'codPresupuestoNombre', editable: true, width: 200, align: 'left' },
                    { name: 'segFechaEdita', index: 'segFechaEdita', editable: true, width: 150, align: 'left', search: false },
                    { name: 'segUsuarioEdita', index: 'segUsuarioEdita', editable: true, width: 70, align: 'left', search: false }
            ],
            pager: 'pagerTablaGasto',
            pagerpos: "center",
            loadtext: 'Cargando datos',
            recordtext: "{0} - {1} de {2}",
            emptyrecords: 'No se econtraron registros de gastos...',
            pgtext: 'Pág: {0} de {1}',
            rowNum: 10,
            rowList: [10, 20, 40, 80],
            sortname: 'fecGasto',
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
  Nombre: $.getDataTablaGasto
  Funcion: Se dispara para realizar una petición de la data actualizada 
           del jQGrid de Datos
 ***********************************************************************/
(function ($) {
    $.getDataTablaGasto = function (postData) {
        'use strict';

        // Leer los datos para la petición
        var vnumAnio = $('#hddnumAnio').val();
        var vcodArea = $('#cboAreas').val();
        var vcodRegEstado = 4;
        var parametros = Object();
        parametros["p_TamPagina"] = postData.rows;
        parametros["p_NumPagina"] = postData.page;
        parametros["p_OrdenPor"] = postData.sidx;
        parametros["p_OrdenTipo"] = postData.sord;
        parametros["codPlantillaDeta"] = null;
        parametros["numAnio"] = vnumAnio;
        parametros["codArea"] = vcodArea;

        var paramAjax = Object();
        paramAjax["ajaxMessage"] = 'Listando gastos de las plantillas presuestales...';
        paramAjax["url"] = "/Presupuesto/ListarGasto";
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
                    $.getDataTablaGastoSuccess(response, status);
            }
            else
                $.f_Mensaje(response.responseText, true, true, 1);
        }


        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

/**********************************************************************
 Nombre: $.getDataTablaGastoSuccess
 Funcion: Función callback luego de solicitar data para el jQGrid
 **********************************************************************/
(function ($) {
    $.getDataTablaGastoSuccess = function (response, status) {
        'use strict';

        if (status == 'success') {
            var tipo = response.Type;
            var mensaje = response.Data;
            if (tipo == 'E')
                $.f_Mensaje(mensaje, true, true, 1);
            else if (tipo == 'I')
                $.f_Mensaje(mensaje, true, true);
            else if (tipo == 'C') {
                $("#gridTablaGasto")[0].addJSONData(mensaje);
            }
        }
    }
})(jQuery);
