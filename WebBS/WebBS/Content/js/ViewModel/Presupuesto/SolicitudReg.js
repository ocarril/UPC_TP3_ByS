/***********************************************************************
Método     : SolicitudReg.js
Propósito  : Manejo de las Solicitudes 
Se asume   : N/A
Efectos    : N/A
Notas      : N/A
Autor      : (OCR) Orlando Carril Ramirez.
Fecha/Hora de Creación : 20/01/2016- 11:18am
Modificado : N/A
Fecha/Hora : N/A
***********************************************************************/
$(document).ready(function () {
    'use strict';

    var vcodSolicitud = $('#hddcodSolicitud').val();

    $('#btnRegresar').bind('click', function (event) {

        var url = '/Presupuesto/Solicitud';
        window.location.href = url;
    });

    $('#btnGuardar').bind('click', function (event) {

        $.fnc_guardarSolicitudCabe();
    });


    $('#btnAgregarMasivo').bind('click', function (event) {

        $.fnu_showDialogAgregarMasivo();
    });

    $.fnu_MostrarRegistroSolicitud(vcodSolicitud);

    $.fnu_configuraGridTabla();
    $.f_formatoFechas("txtfecSolicitada");
    $.f_formatoFechas("txtfecLimite");
    if (vcodSolicitud < 1)
        $('#btnGuardar').attr('class', 'capaOcultar');
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
            colNames: ['', '', 'Descripcion', 'Cantidad', 'S/.Estimado', 'Ejecutar el', 'Partida', 'Se Presupuesto', 'Aprobado por', 'Editado el ', 'Editado por'],
            colModel: [
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditar, sortable: false },
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEliminar, sortable: false },
                { name: 'gloDescripcion', index: 'gloDescripcion', editable: true, width: 200, align: 'left' },
                { name: 'cntCantidad', index: 'cntCantidad', editable: true, width: 70, align: 'right' },
                { name: 'monEstimado', index: 'monEstimado', editable: true, width: 90, align: 'right' },
                { name: 'fecEjecucion', index: 'fecEjecucion', editable: false, width: 90, align: 'center' },
                { name: 'numPartida', index: 'numPartida', editable: false, width: 150, align: 'left' },
                { name: 'gloDescripcionEla', index: 'gloDescripcionEla', editable: false, width: 140, align: 'center' },
                { name: 'codEmpleadoAprueba', index: 'codEmpleadoAprueba', editable: false, width: 130, align: 'left' },
                { name: 'segFechaEdita', index: 'segFechaEdita', editable: true, width: 155, align: 'left' },
                { name: 'segUsuarioEdita', index: 'segUsuarioEdita', editable: true, width: 140, align: 'left' }
                ],
            pager: 'pagerTabla',
            pagerpos: "center",
            loadtext: 'Cargando datos',
            recordtext: "{0} - {1} de {2}",
            emptyrecords: 'No existen detalles de la solicitud de ejecución',
            pgtext: 'Pág: {0} de {1}',
            rowNum: 10,
            rowList: [10, 20, 40, 80],
            sortname: 'fecEjecucion',
            sortorder: "asc",
            viewrecords: true,
            caption: 'Listado',
            height: 'auto',
            rownumbers: true,
            altRows: true,
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
        var vcodSolicitud = $('#hddcodSolicitud').val();
        var vcodRegEstado = 4;
        var vnumSolicitud = $('#hddnumAnio').val();
        var parametros = Object();
        parametros["p_TamPagina"] = postData.rows;
        parametros["p_NumPagina"] = postData.page;
        parametros["p_OrdenPor"] = postData.sidx;
        parametros["p_OrdenTipo"] = postData.sord;
        parametros["codSolicitud"] = vcodSolicitud;
        parametros["codRegEstado"] = vcodRegEstado;
        
        var paramAjax = Object();
        paramAjax["ajaxMessage"] = 'Listando detalle de solicitudes de ejecucion...';
        paramAjax["url"] = "/Presupuesto/ListarSolicitudDeta";
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

/**********************************************************************
Nombre: fnu_configuraGridTablaAprobado
Funcion: Configuración de grilla
**********************************************************************/
(function ($) {
    $.fnu_configuraGridTablaAprobado = function () {
        'use strict';

        var gridWidth = window.screen.width * 0.9 - 55;
        $('[id*=gridAgregaVario]').jqGrid({
            width: gridWidth,
            autowidth: true,
            shrinkToFit: false,
            datatype: $.getDataTablaAprobado,
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
            colNames: ['', '', '', 'Area', 'Partida', 'Descripcion', 'Cantidad', 'Estim.Total', 'Fec-Ejecución', 'Estado', 'Tipo', 'Editado el ', 'Editado por'],
            colModel: [
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditaryy, sortable: false, hidden: true },
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEditarxx, sortable: false, hidden: true },
                { name: '', index: '', width: 35, align: 'center', editable: false, formatter: $.formatEliminarxx, sortable: false, hidden: true },
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
            pager: 'pagerAgregaVario',
            pagerpos: "center",
            loadtext: 'Cargando datos',
            recordtext: "{0} - {1} de {2}",
            emptyrecords: 'No existen partida aprobada para solicitar su ejecución',
            pgtext: 'Pág: {0} de {1}',
            rowNum: 10,
            rowList: [10, 20, 40, 80],
            sortname: 'codAreaNombre',
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
  Nombre: $.getDataTablaAprobado
  Funcion: Se dispara para realizar una petición de la data actualizada 
           del jQGrid de Datos
 ***********************************************************************/
(function ($) {
    $.getDataTablaAprobado = function (postData) {
        'use strict';

        // Leer los datos para la petición
        var vnumAnio = $('#hddnumAnio').val();
        var vcodArea = $('#hddcodArea').val();
        var vcodRegEstado = 2;
        var parametros = Object();
        parametros["p_TamPagina"] = postData.rows;
        parametros["p_NumPagina"] = postData.page;
        parametros["p_OrdenPor"] = postData.sidx;
        parametros["p_OrdenTipo"] = postData.sord;
        parametros["numAnio"] = vnumAnio;
        parametros["codArea"] = vcodArea;
        parametros["codRegEstado"] = vcodRegEstado;

        var paramAjax = Object();
        paramAjax["ajaxMessage"] = 'Listando detalle de plantillas presuestales aprobadas...';
        paramAjax["url"] = "/Presupuesto/ListarPlantillaDetallePorEjecutar";
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
                    $.getDataTablaAprobadoSuccess(response, status);
            }
            else
                $.f_Mensaje(response.responseText, true, true, 1);
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

/**********************************************************************
 Nombre: $.getDataTablaAprobadoSuccess
 Funcion: Función callback luego de solicitar data para el jQGrid
 **********************************************************************/
(function ($) {
    $.getDataTablaAprobadoSuccess = function (response, status) {
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

(function ($) {
    $.fnu_MostrarRegistroSolicitud = function (pID) {
        'use strict';

        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Cargando registro de solicitud...';
        paramAjax["url"] = '/Presupuesto/BuscarSolicitud' + '?pId=' + pID;
        paramAjax["success"] = function (data) {
            var detalle = data.Data;
            var generadoPor = data.EmpleadoGen;
            var aprobadoPor = data.EmpleadoApr;
            $('#hddcodSolicitud').val(detalle.Codigo);
            $.f_loadComboFromArray(generadoPor, 'cbocodEmpleadoGenera', false, detalle.codEmpleadoGenera, false);
            $.f_loadComboFromArray(aprobadoPor, 'cbocodEmpleadoAprueba', false, detalle.codEmpleadoAprueba, false);
            $('#txtgloObservacion').val(detalle.gloObservacion);
            $('#txtcntCantidad').val(detalle.cntCantidad);
            $('#txtnumSolicitud').val(detalle.numSolicitud);
            $('#txtfecSolicitada').val($.f_formatoFechaDDMMYYYY(detalle.fecSolicitada));
            $('#txtfecLimite').val($.f_formatoFechaDDMMYYYY(detalle.fecLimite));
            $('#txtcodRegEstado').val(detalle.codRegEstadoNombre);
            $('#txtsegUsuarioEdita').val(detalle.segUsuarioEdita);
            $('#txtsegFechaEdita').val($.f_formatoFechaDDMMYYYY(detalle.segFechaEdita));
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

/*******************************************************
Pantalla POPUP para agregar de forma masiva Partidas de otros años
********************************************************/
(function ($) {
    $.fnu_showDialogAgregarMasivo = function () {
        'use strict';

        $.fnu_configuraGridTablaAprobado();

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
                $.fnc_guardarSolicitud();
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
 Nombre: $.fnc_guardarSolicitud
 Funcion: Función que guarda las partidas seleccionadas
**********************************************************************/
(function ($) {
    $.fnc_guardarSolicitudCabe = function () {
        'use strict'

        var strValidado = '';
        var vcodSolicitud = $('#hddcodSolicitud').val();
        var vgloObservacion = $('#txtgloObservacion').val();
        var vfecSolicitada = $('#txtfecSolicitada').val();
        var vfecLimite = $('#txtfecLimite').val();
        var vcodEmpleadoGenera = $('#cbocodEmpleadoGenera').val();
        if (vgloObservacion == '')
            strValidado = strValidado + 'Ingresar observación de la solicitud.<br/>';
        if (vfecSolicitada == '')
            strValidado = strValidado + 'Seleccionar fecha solicitud pqara la solicitud de ejecucion.<br/>';
        if (vcodEmpleadoGenera == '')
            strValidado = strValidado + 'Seleccionar empleado quien genera la solicitud.<br/>';

        if (strValidado.length > 0) {
            $.f_Mensaje(strValidado, false, true);
            return;
        }

        var pobjSolicitud = {};
        pobjSolicitud["Codigo"] = vcodSolicitud;
        pobjSolicitud["gloObservacion"] = vgloObservacion;
        pobjSolicitud["fecSolicitada"] = vfecSolicitada;
        pobjSolicitud["fecLimite"] = vfecLimite;
        pobjSolicitud["codEmpleadoGenera"] = vcodEmpleadoGenera;
        pobjSolicitud["indTipo"] = "J";
        pobjSolicitud["codRegEstado"] = 1;

        var parametro = {};
        parametro['url'] = '/Presupuesto/GuardarSolicitud';
        parametro['data'] = JSON.stringify(pobjSolicitud);
        parametro['ajaxMessage'] = 'Guardando solicitud de ejecución...';
        parametro['success'] = $.fnc_guardarSolicitudSuccess; /*Función callback*/
        $.f_ajaxRespuesta(parametro);
    }
})(jQuery);

/**********************************************************************
 Nombre: $.fnc_guardarSolicitud
 Funcion: Función que guarda las partidas seleccionadas
**********************************************************************/
(function ($) {
    $.fnc_guardarSolicitud = function (response, status) {
        'use strict'

        var strValidado = '';
        var lstSolicitudDetaIDs = $.fnc_traerFilasSeleccionadas();
        var vcodSolicitud = $('#hddcodSolicitud').val();
        var vgloObservacion = $('#txtgloObservacion').val();
        var vfecSolicitada = $('#txtfecSolicitada').val();
        var vfecLimite = $('#txtfecLimite').val();
        var vcodEmpleadoGenera = $('#cbocodEmpleadoGenera').val();

        if (vgloObservacion == '')
            strValidado = strValidado + 'Ingresar observación de la solicitud.<br/>';
        if (vfecSolicitada == '')
            strValidado = strValidado + 'Seleccionar fecha solicitud pqara la solicitud de ejecucion.<br/>';
        if (vcodEmpleadoGenera == '')
            strValidado = strValidado + 'Seleccionar empleado quien genera la solicitud.<br/>';

        /* AQUI AGREGAR LOGICA  crom*/
        if (lstSolicitudDetaIDs.length == 0)
            strValidado = strValidado + 'No ha seleccionado ninguna partida presupuestal aprobada...<br/>';

        if (strValidado.length > 0) {
            $.f_Mensaje(strValidado, false, true);
            return;
        }
        
        if (vcodSolicitud > 0) {
            var parametro = {};
            parametro['url'] = '/Presupuesto/GuardarSolicitudDeta';
            parametro['data'] = JSON.stringify(lstSolicitudDetaIDs);
            parametro['ajaxMessage'] = 'Guardando detalles de solicitud de ejecución...';
            parametro['success'] = $.fnc_guardarSolicitudDetaSuccess; /*Función callback*/
            $.f_ajaxRespuesta(parametro);
        }
        else {
            var pobjSolicitud = {};
            pobjSolicitud["Codigo"] = vcodSolicitud;
            pobjSolicitud["gloObservacion"] = vgloObservacion;
            pobjSolicitud["fecSolicitada"] = vfecSolicitada;
            pobjSolicitud["fecLimite"] = vfecLimite;
            pobjSolicitud["codEmpleadoGenera"] = vcodEmpleadoGenera;
            pobjSolicitud["indTipo"] = "J";
            pobjSolicitud["codRegEstado"] = 1;
            pobjSolicitud["lstSolicitudDeta"] = lstSolicitudDetaIDs;

            var parametro = {};
            parametro['url'] = '/Presupuesto/GuardarSolicitud';
            parametro['data'] = JSON.stringify(pobjSolicitud);
            parametro['ajaxMessage'] = 'Guardando solicitud de ejecución...';
            parametro['success'] = $.fnc_guardarSolicitudSuccess; /*Función callback*/
            $.f_ajaxRespuesta(parametro);
        }
    }
})(jQuery);

/**********************************************************************
Nombre: $.fnc_guardarSolicitudDetaSuccess
Funcion: Invocada por el controlador de evento click del botón Guardar
**********************************************************************/
(function ($) {
    $.fnc_guardarSolicitudDetaSuccess = function (response, status) {
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
                $.f_reloadGrid('gridTabla');
                $.f_reloadGrid('gridAgregaVario');
                var vcodSolicitud = $('#hddcodSolicitud').val();
                var url = '/Presupuesto/SolicitudReg?pID=' + vcodSolicitud;
                window.location.href = url;
            }
        }
        else
            $.f_Mensaje(status, false, true);
    }
})(jQuery);

/**********************************************************************
Nombre: $.fnc_guardarSolicitudSuccess
Funcion: Invocada por el controlador de evento click del botón Guardar
**********************************************************************/
(function ($) {
    $.fnc_guardarSolicitudSuccess = function (response, status) {
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
                var url = '/Presupuesto/Solicitud';
                window.location.href = url;
            }
        }
        else
            $.f_Mensaje(response.responseText, false, true);
    }
})(jQuery);

/**********************************************************************
 Nombre: $.fnc_traerFilasSeleccionadas
 Funcion: Función que devuelve las filas seleccionadas de la grilla 
**********************************************************************/
(function ($) {
    $.fnc_traerFilasSeleccionadas = function () {
        'use strict'

        var vcodSolicitud = $('#hddcodSolicitud').val();
        var saveSelectedRows = $("#gridAgregaVario").getGridParam('selarrrow');
        var objSolicitudDeta = {};
        var arr_SolicitudDeta = [];
        if (saveSelectedRows.toString().length > 0) {
            var codigoIDs = saveSelectedRows.toString().split(',');
            for (var i = 0; i < codigoIDs.length; ++i) {
                var codID = parseInt(codigoIDs[i]);

                objSolicitudDeta['codPlantillaDeta'] = codID;
                objSolicitudDeta['codSolicitud'] = vcodSolicitud;
                objSolicitudDeta['gloDescripcion'] = 'Por editar....';
                objSolicitudDeta['cntCantidad'] = 1;
                arr_SolicitudDeta.push(objSolicitudDeta);
                objSolicitudDeta = {};
            };
        }
        return arr_SolicitudDeta;
    }
})(jQuery);


/***********************************************************************
Nombre: $.formatEditar 
Funcion: Formatea columna de edición de la grilla de Detalle de Solicitud
************************************************************************/
(function ($) {
    $.formatEditar = function (cellvalue, options, rowObject) {
        'use strict';

        var srcImage = '../Content/Images/icoEditar.png';
        var image;
        image = "<a href='#' onclick=\"$.fnu_showDialogEditTabla('" + options.rowId + "');\"><img title='Editar detale de solicitud' src='" + srcImage + "' border='0' id='imgEditarTabla' /></a>";
        return image;
    }
})(jQuery);


/***********************************************************************
Nombre: $.formatEliminar 
Funcion: Formatea columna de eliminación de la grilla de Detalle de Solicitud
************************************************************************/
(function ($) {
    $.formatEliminar = function (cellvalue, options, rowObject) {
        'use strict';

        var srcImage = '../Content/Images/icoEliminar.png';
        var image;
        image = "<a href='#' onclick=\"$.fnu_showDialogElimina('" + options.rowId + "');\"><img title='Eliminar registro del detalle de solicitud' src='" + srcImage + "' border='0' id='imgEliminarRegistro' /></a>";
        return image;
    }
})(jQuery);

(function ($) {
    $.fnu_showDialogElimina = function (codReg) {
        'use strict';

        var mensajeOK = new CROMMessageBox({
            contenido: '¿Confirma la eliminación del detalle de solicitud?',
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
        paramAjax["ajaxMessage"] = 'Eliminando detalle de la solicitud...';
        paramAjax["url"] = '/Presupuesto/EliminarSolicitudDeta' + '?pId=' + codReg
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


/*******************************************************
Pantalla POPUP para editar registro de Detalle de solicitud
********************************************************/
(function ($) {
    $.fnu_showDialogEditTabla = function (pID) {
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
                $.fnu_GuardarSolicitudDeta(this);
            }
        };
        $.f_dialog_open_noButtons(divID, modal, title, width, height, draggable, resizable).dialog({ buttons: buttons })
        .dialog({
            beforeClose: function (event, ui) {
                $('#divRegistro').find(':text, select').val('');  // Limpiar campos del popup
            }
        });
        $.f_dialogCssApply(divID);
        if (pID.length > 0) {
            $.fnu_MostrarRegistroSolicitudDeta(pID);
        }
    };
})(jQuery);

(function ($) {
    $.fnu_MostrarRegistroSolicitudDeta = function (pID) {
        'use strict';

        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Cargando registro de detalle de solicitud...';
        paramAjax["url"] = '/Presupuesto/BuscarSolicitudDeta' + '?pId=' + pID;
        paramAjax["success"] = function (data) {
            var detalle = data.Data;
            $('#hddcodSolicitudDeta').val(detalle.Codigo);
            $('#txtcodPartidaNombre').val(detalle.objPlantillaDeta.objPartida.desNombre);
            $('#txtgloDescripcion').val(detalle.gloDescripcion);
            $('#txtfecEjecucion').val($.f_formatoFechaDDMMYYYY(detalle.objPlantillaDeta.fecEjecucion));
            $('#txtmonEstimado').val(detalle.objPlantillaDeta.monEstimado);
            $('#txtcntCantidad').val(detalle.cntCantidad);
            $('#txtsegUsuarioEditaDet').val(detalle.segUsuarioEdita);
            $('#txtsegFechaEditaDet').val($.f_formatoFechaDDMMYYYY(detalle.segFechaEdita, true));
        }
        $.f_ajaxRespuesta(paramAjax);
    }
})(jQuery);

(function ($) {
    $.fnu_GuardarSolicitudDeta = function (context) {
        'use strict';

        var objTabla = $.fnu_ValidarTabla();
        if (objTabla.Mensaje.length > 0) {
            $.f_Mensaje(objTabla.Mensaje, false, true);
            return;
        }
        var paramAjax = {};
        paramAjax["ajaxMessage"] = 'Guardando detalle de solicitud...';
        paramAjax["url"] = '/Presupuesto/GuardarSolicitudDeta';
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
                    $.f_reloadGrid('gridTabla');
                    $(context).dialog('close');
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

        var vcodSolicitud = $('#hddcodSolicitud').val();
        var vcodSolicitudDeta= $('#hddcodSolicitudDeta').val();
        var vgloDescripcion= $('#txtgloDescripcion').val();
        var vfecEjecucion= $('#txtfecEjecucion').val();
        var vmonEstimado= $('#txtmonEstimado').val();
        var vcntCantidad= $('#txtcntCantidad').val();

        if (vgloDescripcion == '')
            strValidado = strValidado + 'Ingresar descripcion de partida <br/>';
        if (vgloDescripcion == 0)
            strValidado = strValidado + 'Ingresar cantidad minima.<br/>';
        if (vmonEstimado == 0)
            strValidado = strValidado + 'Ingresar cantidadmonto estimado de partida.<br/>';
        if (vfecEjecucion == '')
            strValidado = strValidado + 'Ingresar fecha de ejecucion.<br/>';

        var fechaEjec = $.f_formatoFechaYYYYMMDD(vfecEjecucion);

        var fecha = $('#hddnumAnio').val() + '0101';
        var fechaMax = $('#hddnumAnio').val() + '1231';
        if (fechaEjec < fecha)
            strValidado = strValidado + 'La fecha es incorrecta, inferior al año a presupuestar <br/>';
        if (fechaEjec > fechaMax)
            strValidado = strValidado + 'La fecha es incorrecta, supera el año a presupuestar <br/>';

        var pobjTabla = {};
        pobjTabla["Codigo"] = vcodSolicitudDeta;
        pobjTabla["codSolicitud"] = vcodSolicitud;
        pobjTabla["gloDescripcion"] = vgloDescripcion;
        pobjTabla["monEstimado"] = vmonEstimado;
        pobjTabla["cntCantidad"] = vcntCantidad;
        pobjTabla["fecEjecucion"] = vfecEjecucion;

        pobjTabla["Mensaje"] = strValidado;
        return pobjTabla;
    }
})(jQuery);
