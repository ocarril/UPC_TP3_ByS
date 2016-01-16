(function ($) {
    $.f_formatoFechas = function (txtfecha) {
        'use strict';

        $("#" + txtfecha).datepicker({
            showOn: 'button',
            buttonImage: '../Content/Images/icoCalendar.gif',
            buttonImageOnly: true,
            changeYear: true,
            changeMonth: true,
            dateFormat: 'dd/mm/yy',
            timeFormat: 'hh:mm:ss',
            numberOfMonths: 1,
            onSelect: function (txtfecha, objDatepicker) {
                $("#mensaje").html("<p>Has seleccionado: " + txtfecha + "</p>");
            }
        });
    }
})(jQuery);

(function ($) {
    $.f_IrALaPagina = function (urlPagina) {
        'use strict';
        
        var strRuta = window.location.protocol + '//' + window.location.host + '/' + urlPagina;
        //alert(strRuta);
        var pathLocation = window.location;
        if(urlPagina=="")
			strRuta=pathLocation;
        window.location.replace(strRuta);
    }
})(jQuery);


(function ($) {
    $.f_Mensaje = function (mensaje, autoHide, modal, ntipo) {
        'use strict';

        // ntipo = 1;  ROJO
        // ntipo = 2;  NARANJA
        // ntipo = 3;  VERDE
        // ntipo = 4;  AZULADO
        var argumentos = ['', ''];
        if (autoHide == undefined || autoHide == null)
            autoHide = true;

        if (modal == undefined || modal == null)
            modal = true;
        if (ntipo == undefined || ntipo == null)
            ntipo = 2;
        var controlMensaje = new CROMMessageBox({
            contenido: mensaje,
            modal: modal,
            argumentos: argumentos,
            autoCerrado: autoHide,
            tipo: ntipo
        });
        controlMensaje.Mostrar();
    }
})(jQuery);

