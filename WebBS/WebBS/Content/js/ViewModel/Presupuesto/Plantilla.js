/***********************************************************************
Método     : Plantilla.js
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

    $('#btnNuevo').bind('click', function (event) {

        $.fnu_showDialogEditTabla('-1');
    });

    $('#btnAgregarMasivo').bind('click', function (event) {

        $.fnu_showDialogAgregarMasivo();
    });

    $('#btnLimpiar').bind('click', function (event) {

        $('#dataForm').find('input[type=text], select').val('');
    });

    $('#btnBuscar').bind('click', function (event) {

        $.f_reloadGrid('gridTabla');
    });

    $('#btnTerminar').bind('click', function (event) {

        $.fnu_showDialogTerminarIngreso();
    });

    $("#cbonumAnio").change(function () {

        $.f_reloadGrid('gridAgregaVario');
    });
    
    $('#btnVerEnEjecucion').bind('click', function (event) {

        $.fnu_showDialogVerEnEjecucion();
    });

    $("#cboAreas").change(function () {

        $.f_reloadGrid('gridPresupActual');
    });

    $.fnu_cargarPlantillaPorArea($('#hddcodArea').val());
    $.fnu_configuraGridTabla();
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

    $.f_formatoFechas("txtfecEjecucion");
});

(function ($) {
    $.fnu_cargarPlantillaPorArea = function (codArea) {
        'use strict';

        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Cargando registro de tabla...';
        paramAjax["url"] = '/Presupuesto/BuscarPlantilla?pId=' + codArea;
        paramAjax["success"] = function (data) {
            var plantilla = data.Data;
            $('#hddcodPlantilla').val(plantilla.Codigo);
            $('#txtAnio').val(plantilla.objPresupuesto.numAnio);
            $('#txtEstadoPlantilla').val(plantilla.codRegEstadoNombre);
            $('#txtnumPlantilla').val(plantilla.numPlantilla);
            $('#txtDesArea').val(plantilla.objArea.desNombre);
            $('#txtResponsableActual').val(plantilla.objEmpleado.desNombre);
            $('#txtPresupuesto').val(plantilla.objPresupuesto.desNombre);
            $('#txtFechaCierre').val($.f_formatoFechaDDMMYYYY(plantilla.objPresupuesto.fecCierre));
            $('#txtFechaExtemporaneo').val(plantilla.fecCierreExtempor);
            $('#txtmonMaximo').val(plantilla.monMaximo);
            $('#txtmonEstimadoTotal').val(plantilla.monEstimadoTotal);
            var vEstadoPlantilla = $('#txtEstadoPlantilla').val();
            var fechaFinal = $.f_formatoFechaYYYYMMDD($('#txtFechaCierre').val());
            var fechaMaxima = $.f_formatoFechaYYYYMMDD($('#txtFechaExtemporaneo').val());
            var fechaActual = $.f_formatoFechaYYYYMMDD($('#hddfechaActual').val());

            if (fechaActual > fechaMaxima || vEstadoPlantilla.toUpperCase() != 'PENDIENTE') {
                $('#btnNuevo').attr('class', 'capaOcultar');
                $('#btnTerminar').attr('class', 'capaOcultar');
                $('#btnAgregarMasivo').attr('class', 'capaOcultar');
                if (fechaActual > fechaFinal)
                    $('#txtprcPenalidad').attr('class', 'capaMostrar');
                else
                    $('#txtprcPenalidad').attr('class', 'capaOcultar');
                $('#hddOcultaBoton').val('true');
                $.f_Mensaje('La fecha de registro de partidas presupuestales se ha VENCIDO o la plantilla esta TERMINADA.', false, true);
            }
            else {
                $('#hddOcultaBoton').val('false');
                if (fechaActual > fechaFinal)
                    $('#txtprcPenalidad').attr('class', 'capaMostrar');
                else
                    $('#txtprcPenalidad').attr('class', 'capaOcultar');
            }
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

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
            colNames: ['', '', '','Area', 'Partida', 'Descripcion', 'Cantidad', 'S/. Estimado Total', 'Fecha Ejecución', 'Estado', 'Tipo', 'Editado el ', 'Editado por'],
            colModel: [
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatNuevo, sortable: false , hidden:true},
                { name: 'btnEdita', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditar, sortable: false },
                { name: 'btnElimina', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEliminar, sortable: false},
                { name: 'codAreaNombre', index: 'codAreaNombre', editable: true, width: 140, align: 'left', hidden:true },
                { name: 'codPartidaNombre', index: 'codPartidaNombre', editable: true, width: 140, align: 'left' },
                { name: 'gloDescripcion', index: 'gloDescripcion', editable: false, width: 210, align: 'left' },
                { name: 'cntCantidad', index: 'cntCantidad', editable: false, width: 80, align: 'right' },
                { name: 'monEstimado', index: 'monEstimado', editable: false, width: 120, align: 'right' },
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
  Nombre: $.getDataTabla
  Funcion: Se dispara para realizar una petición de la data actualizada 
           del jQGrid de Datos
 ***********************************************************************/
(function ($) {
    $.getDataTabla = function (postData) {
        'use strict';

        // Leer los datos para la petición
        var vnumAnio = $('#hddnumAnio').val();
        var vcodArea = $('#hddcodArea').val();
        var parametros = Object();
        parametros["p_TamPagina"] = postData.rows;
        parametros["p_NumPagina"] = postData.page;
        parametros["p_OrdenPor"] = postData.sidx;
        parametros["p_OrdenTipo"] = postData.sord;
        parametros["numAnio"] = vnumAnio;
        parametros["codArea"] = vcodArea;
        
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
Nombre: $.formatEditar (OCR)
Funcion: Formatea columna de edición de la grilla de DOCUMENTO
************************************************************************/
(function ($) {
    $.formatEditar = function (cellvalue, options, rowObject) {
        'use strict';

        var blnOculta = $('#hddOcultaBoton').val();
        var srcImage = '../Content/Images/icoEditar.png';
        var image;
        if(blnOculta=='false')
            image = "<a href='#' onclick=\"$.fnu_showDialogEditTabla('" + options.rowId + "');\"><img title='Editar plantilla presupuestal' src='" + srcImage + "' border='0' id='imgEditarTabla' /></a>";
        else
            image = ''
        return image;
    }
})(jQuery);

/***********************************************************************
Nombre: $.formatEliminar (OCR)
Funcion: Formatea columna de eliminación de la grilla de DOCUMENTO
************************************************************************/
(function ($) {
    $.formatEliminar = function (cellvalue, options, rowObject) {
        'use strict';

        var blnOculta = $('#hddOcultaBoton').val();
        var srcImage = '../Content/Images/icoEliminar.png';
        var image;
        if (blnOculta == 'false')
            image = "<a href='#' onclick=\"$.fnu_showDialogEliminaTabla('" + options.rowId + "');\"><img title='Eliminar plantilla presupuestal' src='" + srcImage + "' border='0' id='imgEliminarTabla' /></a>";
        else
            image = ''
        return image;
    }
})(jQuery);

(function ($) {
    $.fnu_showDialogEliminaTabla = function (idTabla) {
        'use strict';

        var mensajeOK = new CROMMessageBox({
            contenido: '¿Confirma la eliminación del registro de partida presupuestal. ?',
            tipo: 4,
            botones: [
                    {
                        Etiqueta: "Aceptar",
                        Click: function () { $.fnu_eliminarTabla(idTabla); }
                    },
                    {
                        Etiqueta: "Cancelar"
                    }]
        });
        mensajeOK.Mostrar();
    }
})(jQuery);

(function ($) {
    $.fnu_eliminarTabla = function (codPlantillaDeta) {
    'use strict';

     var paramAjax ={};
     paramAjax["ajaxMessage"] = 'Eliminando partida presupuestal...';
     paramAjax["url"] = '/Presupuesto/EliminarPlantillaDetalle?pId=' + codPlantillaDeta
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
                                        $.f_reloadGrid('gridTabla');
                                    }
                                }
                                else
                                   $.f_Mensaje(response.responseText, true, true);
                            }
    $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

/***********************************************************************
Nombre: $.formatDetalle (OCR)
Funcion: Formatea columna de Detalle de la grilla de DOCUMENTO
************************************************************************/
(function ($) {
    $.formatNuevo = function (cellvalue, options, rowObject) {
        'use strict';

        var srcImage = '../Content/Images/New.png';
        var image;
        image = "<a href='#' onclick=\"$.fnu_showDialogEditReg('" + options.rowId + "', 0);\"><img title='Nuevo plantilla presupuestal' src='" + srcImage + "' border='0' id='imgNuevoRegistro' /></a>";
        return image;
    }
})(jQuery);



/*******************************************************
Pantalla POPUP para editar registro de Tabla
********************************************************/
(function ($) {
    $.fnu_showDialogEditTabla = function (codPlantillaDeta) {
        'use strict';

        var divID = 'divRegistro';
        var modal = true;
        var title = ''; //'Datos de la partida presupuestal';
        var width = 'auto';
        var height = null;
        var draggable = true;
        var resizable = false;
        var buttons = {
            'Cerrar': function (event) {
                $(this).dialog('close');
            },
            'Guardar': function () {
                $.fnu_GuardarTabla(this);
            }
        };
        $.f_dialog_open_noButtons(divID, modal, title, width, height, draggable, resizable).dialog({ buttons: buttons })
        .dialog({
            beforeClose: function (event, ui) {
                $('#divRegistro').find(':text, select').val('');  // Limpiar campos del popup
            }
        });
        $.f_dialogCssApply(divID);
        if (codPlantillaDeta.length > 0) {
            $.fnu_MostrarRegistroTabla(codPlantillaDeta);
        }
    };
})(jQuery);

(function ($) {
    $.fnu_MostrarRegistroTabla = function (codPlantillaDeta) {
        'use strict';

        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Cargando registro de presupuesto...';
        paramAjax["url"] = '/Presupuesto/BuscarPlantillaDetalle' + '?pId=' + codPlantillaDeta;
        paramAjax["success"] = function (data) {
            var detalle = data.Data;
            var partida = data.Partidas;
            $('#hddcodPlantillaDeta').val(detalle.Codigo);
            $.f_loadComboFromArray(partida, 'cbocodPartida', true, detalle.codPartida, false);
            $('#chkindPlantilla').attr('checked', detalle.indPlantilla == 1 ? true : false);
            $('#txtgloDescripcion').val(detalle.gloDescripcion);
            $('#txtcntCantidad').val(detalle.cntCantidad);
            $('#txtmonEstimado').val(detalle.monEstimado);
            $('#txtfecEjecucion').val($.f_formatoFechaDDMMYYYY(detalle.fecEjecucion, false));
            $('#txtsegUsuarioEdita').val(detalle.segUsuarioEdita);
            $('#txtsegFechaEdita').val($.f_formatoFechaDDMMYYYY(detalle.segFechaEdita, true));
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

(function ($) {
    $.fnu_GuardarTabla = function (context) {
        'use strict';

        var objTabla = $.fnu_ValidarTabla();
        if (objTabla.Mensaje.length > 0) {
            $.f_Mensaje(objTabla.Mensaje, false, true);
            return;
        }
        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Guardando partida presupuestal...';
        paramAjax["url"] = '/Presupuesto/GuardarPlantillaDetalle';
        paramAjax["data"] = JSON.stringify(objTabla);
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
                    $.fnu_cargarPlantillaPorArea($('#hddcodArea').val());
                }
            }
            else {
                $.f_Mensaje(response.responseText, true, true);
            }
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

(function ($) {
    $.fnu_ValidarTabla = function () {
        'use strict';
        
        var strValidado = '';
        var vcodPlantillaDeta = $('#hddcodPlantillaDeta').val();
        var vcodPlantilla = $('#hddcodPlantilla').val();
        var vcodPartida = $('#cbocodPartida').val();
        var vindPlantilla = document.getElementsByName("chkindPlantilla")[0].checked ? "N" : "T";
        var vgloDescripcion = $('#txtgloDescripcion').val();
        var vtxtcntCantidad = parseFloat($('#txtcntCantidad').val().replace(',', ''));
        var vtxtmonEstimado = parseFloat($('#txtmonEstimado').val().replace(',', ''));
        var vtxtfecEjecucion = $('#txtfecEjecucion').val();

        var vsubTotal = vtxtcntCantidad * vtxtmonEstimado;

        if (vcodPartida == '')
            strValidado = strValidado + 'Seleccionar grupo de partida <br/>';
        if (vgloDescripcion == '')
            strValidado = strValidado + 'Ingresar descripcion de partida <br/>';
        if (vtxtcntCantidad == 0)
            strValidado = strValidado + 'Ingresar cantidad minima.<br/>';
        if (vtxtmonEstimado == 0)
            strValidado = strValidado + 'Ingresar cantidadmonto estimado de partida.<br/>';
        if (vtxtfecEjecucion == '')
            strValidado = strValidado + 'Ingresar fecha de ejecucion.<br/>';

        var fechaEjec = $.f_formatoFechaYYYYMMDD(vtxtfecEjecucion);
                        
        var fecha = $('#hddnumAnio').val() + '0101';
        var fechaMax = $('#hddnumAnio').val() + '1231';
        if (fechaEjec < fecha)
            strValidado = strValidado + 'La fecha es incorrecta, inferior al año a presupuestar <br/>';
        if (fechaEjec > fechaMax)
            strValidado = strValidado + 'La fecha es incorrecta, supera el año a presupuestar <br/>';

        var vmonTotalMaximo = parseFloat($('#txtmonMaximo').val().replace(',',''));
        var vmonTotalPresup = parseFloat($('#txtmonEstimadoTotal').val().replace(',', '')) + parseFloat(vsubTotal);
        
        if (vmonTotalPresup > vmonTotalMaximo)
            strValidado = strValidado + 'El monto acumulado a presupuestar supera al monto establecido.. <br/>';

        var pobjTabla = {};
        pobjTabla["Codigo"] = vcodPlantillaDeta;
        pobjTabla["codPlantilla"] = vcodPlantilla;
        pobjTabla["gloDescripcion"] = vgloDescripcion;
        pobjTabla["monEstimado"] = vtxtmonEstimado;
        pobjTabla["cntCantidad"] = vtxtcntCantidad;
        pobjTabla["fecEjecucion"] = vtxtfecEjecucion;
        pobjTabla["indPlantilla"] = vindPlantilla;
        pobjTabla["codPartida"] = vcodPartida;

        pobjTabla["Mensaje"]= strValidado;
        return pobjTabla;
    }
})(jQuery);

/*******************************************************
Pantalla POPUP para agregar de forma masiva Partidas de otros años
********************************************************/
(function ($) {
    $.fnu_showDialogAgregarMasivo = function () {
        'use strict';

        $.fnu_configuraGridPartidas();

        var divID = 'divAgregarVarios';
        var modal = true;
        var title = ''; // 'Datos de la partidas presupuestales de años anteriores';
        var width = 'auto';
        var height = null;
        var draggable = true;
        var resizable = false;
        var buttons = {
            'Cerrar': function (event) {
                $(this).dialog('close');
            },
            'Guardar': function () {

                $.fnc_guardarPartidasPorReferencia();
                $.f_reloadGrid('gridTabla');
            }
        };
        $.f_dialog_open_noButtons(divID, modal, title, width, height, draggable, resizable).dialog({ buttons: buttons })
        .dialog({
            beforeClose: function (event, ui) {
                $('#divAgregarVarios').find(':text, select').val('');  // Limpiar campos del popup
            }
        });
        $.f_dialogCssApply(divID);
    };
})(jQuery);

/**********************************************************************
 Nombre: $.fnc_guardarPartidasPorReferencia
 Funcion: Función que guarda las partidas seleccionadas
**********************************************************************/
(function ($) {
    $.fnc_guardarPartidasPorReferencia = function (response, status) {
        'use strict'

        var lstPlantillaDetaIDs = $.fnc_traerFilasSeleccionadas();

        if (lstPlantillaDetaIDs.length == 0) {
            $.f_Mensaje('No ha seleccionado ninguna partida presupuestal...', false, true, 4);
            return;
        }
        else {
            var parametro = {};
            parametro['url'] = '/Presupuesto/GuardarPlantillaDetallePorRefer';
            parametro['data'] = JSON.stringify(lstPlantillaDetaIDs);
            parametro['ajaxMessage'] = 'Guardando detalle de plantilla por referencia...';
            parametro['success'] = $.fnc_guardarPartidasPorReferenciaSuccess; /*Función callback*/
            $.f_ajaxRespuesta(parametro);
        }

    }
})(jQuery);

/**********************************************************************
Nombre: $.fnc_guardarPartidasPorReferenciaSuccess
Funcion: Invocada por el controlador de evento click del botón Guardar
**********************************************************************/
(function ($) {
    $.fnc_guardarPartidasPorReferenciaSuccess = function (response, status) {
        'use strict'

        if (status == 'success') {
            var tipo = response.Type;
            var mensaje = response.Data;
            if (tipo == "E")
                $.f_Mensaje(mensaje, false, true, 1);
            else if (tipo == "I")
                $.f_Mensaje(mensaje, false, true);
            else if (tipo == "C") {
                $.f_Mensaje(mensaje, true, true, 3);
                $.fnu_cargarPlantillaPorArea($('#hddcodArea').val());
            }
        }
        else
            $.f_Mensaje(response.responseText, false, true);
    }
})(jQuery);

/**********************************************************************
Nombre: configuraGrilla
Funcion: Configuración de grilla
**********************************************************************/
(function ($) {

    $.fnu_configuraGridPartidas = function () {
        'use strict';

        var gridWidth = window.screen.width * 0.9 - 55;
        $('[id*=gridAgregaVario]').jqGrid({
            width: gridWidth,
            autowidth: true,
            shrinkToFit: false,
            datatype: $.getDataPartidas,
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
            colNames: ['', '','','Area', 'Partida', 'Descripcion', 'Cantidad', '(S/.)Estimado Total', 'Fecha Ejecución'],
            colModel: [
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatNuevo, sortable: false , hidden:true},
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditar, sortable: false, hidden: true },
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditar, sortable: false, hidden: true },
                { name: 'codAreaNombre', index: 'codAreaNombre', editable: true, width: 140, align: 'left'},
                { name: 'codPartidaNombre', index: 'codPartidaNombre', editable: true, width: 140, align: 'left' },
                { name: 'gloDescripcion', index: 'gloDescripcion', editable: false, width: 210, align: 'left' },
                { name: 'cntCantidad', index: 'cntCantidad', editable: false, width: 80, align: 'right' },
                { name: 'monEstimado', index: 'monEstimado', editable: false, width: 130, align: 'right' },
                { name: 'fecEjecucion', index: 'fecEjecucion', editable: false, width: 100, align: 'center' }
            ],
            pager: 'pagerAgregaVario',
            pagerpos: "center",
            loadtext: 'Cargando datos',
            recordtext: "{0} - {1} de {2}",
            emptyrecords: 'vacío',
            pgtext: 'Pág: {0} de {1}',
            rowNum: 7,
            rowList: [7, 14, 21, 42],
            sortname: 'codPartidaNombre',
            sortorder: "asc",
            viewrecords: true,
            multiselect: true,
            caption: 'Listado',
            height: 'auto',
            rownumbers: true,
            altRows: true
        });

        $(".ui-jqgrid-titlebar").hide();
    }
})(jQuery);

/**********************************************************************
  Nombre: $.getDataPartidas
  Funcion: Se dispara para realizar una petición de la data actualizada 
           del jQGrid de Datos
 ***********************************************************************/
(function ($) {
    $.getDataPartidas = function (postData) {
        'use strict';

        // Leer los datos para la petición
        var vAnioCombo = $('#cbonumAnio').val();
        if (vAnioCombo.length >= 4) {

            var vcodArea = $('#hddcodArea').val();
            var parametros = Object();
            parametros["p_TamPagina"] = postData.rows;
            parametros["p_NumPagina"] = postData.page;
            parametros["p_OrdenPor"] = postData.sidx;
            parametros["p_OrdenTipo"] = postData.sord;
            parametros["numAnio"] = vAnioCombo;
            parametros["codArea"] = vcodArea;

            var paramAjax = Object();
            paramAjax["ajaxMessage"] = 'Listando detalle de plantillas presuestales...';
            paramAjax["url"] = "/Presupuesto/ListarPlantillaDetalleAntes";
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
                        $.getDataPartidasSuccess(response, status);
                }
                else
                    $.f_Mensaje(response.responseText, true, true, 1);
            }

            $.f_ajaxRespuesta(paramAjax);
        }
    }
})(jQuery);

/**********************************************************************
 Nombre: $.getDataPartidasSuccess
 Funcion: Función callback luego de solicitar data para el jQGrid
 **********************************************************************/
(function ($) {
    $.getDataPartidasSuccess = function (response, status) {
        'use strict';

        if (status == 'success') {
            var tipo = response.Type;
            var mensaje = response.Data;
            if (tipo == 'E')
                $.f_Mensaje(mensaje, true, true, 1);
            else if (tipo == 'I')
                $.f_Mensaje(mensaje, true, true);
            else if (tipo == 'C') {
                $("#gridAgregaVario")[0].addJSONData(mensaje);
            }
        }
    }
})(jQuery);

/*******************************************************
Pantalla POPUP para visualizar el presupuesto en ejecución
********************************************************/
(function ($) {
    $.fnu_showDialogVerEnEjecucion = function () {
        'use strict';

        $('#txtAnioPre').val(parseInt($('#hddnumAnio').val()) - 1);
        $.fnu_configuraGridEnEjecucion();

        var divID = 'divPresupuestoActual';
        var modal = true;
        var title = ''; //'Presupuesto actual';
        var width = 'auto';
        var height = null;
        var draggable = true;
        var resizable = false;
        var buttons = {
            'Cerrar': function (event) {
                $(this).dialog('close');
            }
        };
        $.f_dialog_open_noButtons(divID, modal, title, width, height, draggable, resizable).dialog({ buttons: buttons })
        .dialog({
            beforeClose: function (event, ui) {
                $('#divPresupuestoActual').find(':text, select').val('');  // Limpiar campos del popup
            }
        });
        $.f_dialogCssApply(divID);
    };
})(jQuery);

/**********************************************************************
Nombre: fnu_configuraGridEnEjecucion
Funcion: Configuración de grilla para el presupuesto en ejecucion
**********************************************************************/
(function ($) {

    $.fnu_configuraGridEnEjecucion = function () {
        'use strict';

        var gridWidth = window.screen.width * 0.9 - 55;
        $('[id*=gridPresupActual]').jqGrid({
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
            colNames: ['', '', '', 'Area', 'Partida', 'Descripcion', 'Cantidad', '(S/.) Estimado Total', 'Fecha Ejecución', 'Estado', 'Tipo', 'Editado el ', 'Editado por'],
            colModel: [
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatNuevo, sortable: false, hidden: true },
                { name: 'btnEdita', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditar, sortable: false, hidden: true },
                { name: 'btnElimina', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEliminar, sortable: false, hidden: true },
                { name: 'codAreaNombre', index: 'codAreaNombre', editable: true, width: 140, align: 'left' },
                { name: 'codPartidaNombre', index: 'codPartidaNombre', editable: true, width: 140, align: 'left' },
                { name: 'gloDescripcion', index: 'gloDescripcion', editable: false, width: 210, align: 'left' },
                { name: 'cntCantidad', index: 'cntCantidad', editable: false, width: 80, align: 'right' },
                { name: 'monEstimado', index: 'monEstimado', editable: false, width: 130, align: 'right' },
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

        // Leer los datos para la petición
        var vnumAnio = $('#txtAnioPre').val();
        var vcodArea = $('#cboAreas').val();
        var parametros = Object();
        parametros["p_TamPagina"] = postData.rows;
        parametros["p_NumPagina"] = postData.page;
        parametros["p_OrdenPor"] = postData.sidx;
        parametros["p_OrdenTipo"] = postData.sord;
        parametros["numAnio"] = vnumAnio;
        parametros["codArea"] = vcodArea;

        var paramAjax = Object();
        paramAjax["ajaxMessage"] = 'Listando detalle de plantillas presuestales del año actual...';
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
                $("#gridPresupActual")[0].addJSONData(mensaje);
            }
        }
    }
})(jQuery);

/**********************************************************************
 Nombre: $.fnc_traerFilasSeleccionadas
 Funcion: Función que devuelve las filas seleccionadas de la grilla 
**********************************************************************/
(function ($) {
    $.fnc_traerFilasSeleccionadas = function () {
        'use strict'

        var vcodPlantilla = $('#hddcodPlantilla').val();
        var saveSelectedRows = $("#gridAgregaVario").getGridParam('selarrrow');
        var objPartida = {};
        var arr_Partida = [];
        if (saveSelectedRows.toString().length > 0) {
            var codigoIDs = saveSelectedRows.toString().split(',');
            for (var i = 0; i < codigoIDs.length; ++i) {
                var codID = parseInt(codigoIDs[i]);

                objPartida['Codigo'] = codID;
                objPartida['codPlantilla'] = vcodPlantilla;
                arr_Partida.push(objPartida);
                objPartida = {};
            };
        }
        return arr_Partida;
    }
})(jQuery);


(function ($) {
    $.fnu_showDialogTerminarIngreso = function () {
        'use strict';

        var mensajeOK = new CROMMessageBox({
            contenido: '¿Confirma haber terminado los registros de partidas presupuestal del area correspondiente. ?',
            tipo: 4,
            botones: [
                    {
                        Etiqueta: "Aceptar",
                        Click: function () { $.fnu_terminarIngreso(); }
                    },
                    {
                        Etiqueta: "Cancelar"
                    }]
        });
        mensajeOK.Mostrar();
    }
})(jQuery);

(function ($) {
    $.fnu_terminarIngreso = function () {
        'use strict';

        var vcodPlantilla = $('#hddcodPlantilla').val()
        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Eliminando partida presupuestal...';
        paramAjax["url"] = '/Presupuesto/PlantillaTerminarIngreso?pId=' + vcodPlantilla
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
                    $.fnu_cargarPlantillaPorArea($('#hddcodArea').val());
                    $.f_reloadGrid('gridTabla');
                }
            }
            else
                $.f_Mensaje(response.responseText, true, true);
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);
