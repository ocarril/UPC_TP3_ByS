//**********************************************************************
// Nombre: f_dialog_open_noButtons
// Funcion: Abre un modal sin botones
//**********************************************************************
(function ($) {
    $.f_dialog_open_noButtons = function (divId, modal, title, width, height, draggable, resizable, pFunctionOK) {
        var dialog = $('#' + divId).dialog({
            autoOpen: false,        // Default

            show: {
                effect: "blind",
                duration: 1000
            },
            hide: {
                effect: "explode",
                duration: 1000
            },

            closeOnEscape: true,    // Default,

            modal: modal,
            title: title,
            width: width != null ? width : 'auto',
            height: height != null ? height : 'auto',
            draggable: draggable,
            resizable: resizable
        });

        return dialog.dialog('open');
    }
})(jQuery);


//**********************************************************************
// Nombre: f_dialog_open
// Funcion: Abre un modal con la función OK enviada como parámetro
//**********************************************************************
(function ($) {
    $.f_dialog_open = function (divId, modal, title, width, height, draggable, resizable, pFunctionOK) {
        var dialog = $('#' + divId).dialog({
            autoOpen: false,        // Default
            closeOnEscape: true,    // Default,

            modal: modal,
            title: title,
            width: width != null ? width : 'auto',
            height: height != null ? height : 'auto',
            draggable: draggable,
            resizable: resizable,

            buttons: {
                "Aplicar": function () {
                    pFunctionOK();
                },
                "Cancelar": function () {
                    $(this).dialog("close");
                }
            }
        });

        return dialog.dialog('open');
    }
})(jQuery);


//**********************************************************************
// Nombre: f_dialog_open_buttons
// Funcion: Abre un modal con los botones especificados como parámetros
//**********************************************************************
(function ($) {
    $.f_dialog_open_buttons = function (divId, modal, title, width, height, draggable, resizable, pButtons) {
        var dialog = $('#' + divId).dialog({
            autoOpen: false,        // Default
            closeOnEscape: true,    // Default,

            modal: modal,
            title: title,
            width: width != null ? width : 'auto',
            height: height != null ? height : 'auto',
            draggable: draggable,
            resizable: resizable,

            buttons: pButtons
        });

        return dialog.dialog('open');
    }
})(jQuery);


//**********************************************************************
// Nombre: f_dialog_open_url
// Funcion: Abre un modal con una URL (IFRAME)
//**********************************************************************
(function ($) {
    $.f_dialog_open_url = function (divID, modal, title, width, height, draggable, resizable, pURL, pFunctionOK, pFunctionBCLOSE) {
        $("body").append("<div id='div_ModalFrame'></div>");

        var strHtml = '<iframe id="ifrModal" width="100%" height="100%" frameborder="0" scrolling="auto" marginheight="0" marginwidth="0" src="' + pURL + '"></iframe>';
        $("#div_ModalFrame").html(strHtml);

        var dialog = $("#" + divID).dialog({
            autoOpen: false,        // Default
            closeOnEscape: true,    // Default,

            modal: modal,
            title: title,
            width: width != null ? width : 'auto',
            height: height != null ? height : 'auto',
            draggable: draggable,
            resizable: resizable,

            beforeClose: function (event, ui) {
                if (pFunctionBCLOSE != null) pFunctionBCLOSE();
                $(this).remove();
            },
            buttons: {
                "Aplicar": function () {
                    pFunctionOK();
                },
                "Cancelar": function () {
                    $(this).dialog("close");
                }
            }
        });

        return dialog.dialog('open');
    }
})(jQuery);


//******************************************************************************************
// Nombre: f_dialog_open_url_buttons
// Funcion: Abre un modal con una URL (IFRAME) con los botones especificados como parámetros
//******************************************************************************************
(function ($) {
    $.f_dialog_open_url_buttons = function (divId, modal, title, width, height, draggable, resizable, pURL, pButtons) {
        $("body").append('<div id="' + divId + '"></div>');

        var strHtml = '<iframe id="ifrModal" width="100%" height="100%" frameborder="0"  src="' + pURL + '"></iframe>';
        $("#" + divId).html(strHtml);

        var dialog = $("#" + divId).dialog({
            autoOpen: false,        // Default
            closeOnEscape: true,    // Default,

            modal: modal,
            title: title,
            width: width != null ? width : 'auto',
            height: height != null ? height : 'auto',
            draggable: draggable,
            resizable: resizable,

            beforeClose: function (event, ui) {
                $(this).remove();
            },

            buttons: pButtons
        });

        return dialog.dialog('open');
    }
})(jQuery);


//**********************************************************************

(function ($) {
    $.f_dialogCssApply = function (popupID) {

        $('div.ui-dialog div.ui-dialog-titlebar').removeClass('ui-widget-header').addClass('panel-heading');
        $('div.ui-dialog-content').removeClass('capaOcultar');
        $('div.ui-dialog table td label').addClass('panel-heading');
        $('div.ui-dialog-buttonpane div.ui-dialog-buttonset button.ui-button').attr('class', 'btn btn-primary form-control');

        // Ajustar ancho de barra de título y panel de botones del diálogo
        var ancho = null;
        if (window.sessionStorage.getItem('ancho_' + popupID) == null) {
            ancho = $('#' + popupID).css('width');
            window.sessionStorage.setItem('ancho_' + popupID, ancho);
        }

        ancho = window.sessionStorage.getItem('ancho_' + popupID);
        $('div.ui-dialog-titlebar').css('width', ancho);
        $('div.ui-dialog-buttonpane').css('width', ancho);

        // Centrar el diálogo en la ventana
        $('#' + popupID).dialog({
            position: {
                my: "center",
                at: "center",
                of: window,
                collision: "fit",
                // Ensure the titlebar is always visible
                using: function (pos) {
                    var topOffset = $(this).css(pos).offset().top;
                    if (topOffset < 0)
                        $(this).css("top", pos.top - topOffset);
                    else
                        $(this).css("top", pos.top);
                }
            }
        });
    }
})(jQuery);