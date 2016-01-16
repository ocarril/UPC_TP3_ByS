//**********************************************************************
// Nombre: fn_mdl_iframe
// Funcion: Abre un modal con una URL (IFRAME)
//**********************************************************************
function fn_util_AbreModal(pDiv, pTitulo, pAncho, pAlto, pFuncion, pFuncion1) {
    if (!pTitulo) { pTitulo = 'SSAC - Sistema de Solicitud de Acceso'; }

    $(pDiv).dialog({
        modal: true,
        title: pTitulo,
        width: (pAncho + 30),
        height: (pAlto ? pAlto : 'auto'),
        resizable: false,
        show: true,
        hide: true,
        beforeClose: function (event, ui) {
            if (pFuncion1 != null) {
                pFuncion1();
            }
        },
        buttons: {
            "Guardar": function () {
                pFuncion()
            },
            "Cancelar": function () {
                $(pDiv).dialog("close");
            }
        }
    });

    $(pDiv).dialog("open");
};

//**********************************************************************
// Nombre: fn_util_AbreModalBotones
// Funcion: Abre un modal con una URL (IFRAME)
//**********************************************************************
function fn_util_AbreModalBotones(pDiv, pTitulo, pAncho, pAlto, pBotones, pFuncion) {
    if (!pTitulo) { pTitulo = 'SSAC - Sistema de Solicitud de Acceso'; }

    $(pDiv).dialog({
        modal: true,
        title: pTitulo,
        width: pAncho ? (pAncho + 30) : 'auto',
        height: (pAlto ? pAlto : 'auto'),
        resizable: false,
        show: true,
        hide: true,
        maxWidth: 1000,
        beforeClose: function (event, ui) {
            if (pFuncion) {
                pFuncion();
            }
        },
        buttons: pBotones
    });

    $(pDiv).dialog("open");
};

//**********************************************************************
// Nombre: fn_mdl_muestraForm
// Funcion: Abre formulario
//**********************************************************************
function fn_mdl_muestraForm(pURL, pFuncion, pFuncion1, pTitulo, pAncho, pAlto) {
    if (!pTitulo) { pTitulo = 'SSAC - Sistema de Solicitud de Acceso'; }

    $("body").append("<div id='dv_ModalFrame'></div>");
    var strHtml = '<iframe runat="server" id="ifrModal" width="100%" height="100%" frameborder="0" scrolling="auto" marginheight="0" marginwidth="0" src="' + pURL + '"></iframe>';

    $("#dv_ModalFrame").html(strHtml);
    $("#dv_ModalFrame").dialog({
        modal: true,
        title: pTitulo,
        width: pAncho,
        height: (pAlto ? pAlto : 'auto'),
        resizable: false,
        show: true,
        hide: true,
        beforeClose: function (event, ui) {
            if (pFuncion1) pFuncion1();
            $(this).remove();
        },
        buttons: {
            "Aceptar": function () {
                if (pFuncion) pFuncion();
            },
            "Cancelar": function () {
                $(this).dialog('close');
            }
        }
    });
};

//**********************************************************************
// Nombre: fn_mdl_muestraForm
// Funcion: Abre formulario
//**********************************************************************
function fn_mdl_muestraForm2(pURL, pTitulo, pAncho, pAlto, pBotones, pNombreDiv) {
    if (!pTitulo) { pTitulo = 'SSAC - Sistema de Solicitud de Acceso'; }
    var pDiv = !pNombreDiv ? 'dv_ModalFrame' : pNombreDiv;

    $("body").append("<div id='" + pDiv + "'></div>");
    var strHtml = '<iframe runat="server" id="ifrModal" width="100%" height="100%" frameborder="0" scrolling="auto" marginheight="0" marginwidth="0" src="' + pURL + '"></iframe>';

    $("#" + pDiv).html(strHtml);
    $("#" + pDiv).dialog({
        modal: true,
        title: pTitulo,
        width: pAncho,
        height: (pAlto ? pAlto : 'auto'),
        resizable: false,
        show: true,
        hide: true,
        beforeClose: function (event, ui) {
            $(this).remove();
        },
        buttons: pBotones
    });
};

