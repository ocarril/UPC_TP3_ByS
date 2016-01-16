//**********************************************************************
// Nombre: $.f_ajaxRequest
// Funcion: Realiza una petición ajax al servidor
//**********************************************************************
(function ($) {
    $.f_ajaxRequest = function (ajaxMessage, type, async, timeout, url, data, dataType, contentType, success, error) {
        window.ajaxMessage = ajaxMessage;

        jQuery.ajax({
            type: type,                 // GET, POST, PUT O DELETE (verbo HTTP), si se omite, por defecto es GET
            async: async,               // true o false, llamada sícrona o asíncrona, por defecto la llamada es asíncrona
            timeout: timeout,           // Tiempo máximo de espera para la petición (en milisegundos)
            url: url,                   // ubicación del servicio
            data: data,                 // data enviada al servidor
            dataType: dataType,         // Tipo de dato que se espera que se devuelva en la respuesta
            contentType: contentType,   // Tipo de contenido que se especifica en la petición. Si se omite, la opción por defecto es application/x-www-form-urlencoded
            success: success,           // función si la llamada al server fue exitosa
            error: error,               // función si la llamada al server falló
            cache: false
        });
    }
})(jQuery);

//**********************************************************************
// Nombre: $.f_ajaxRespuesta
// Funcion: Realiza una petición ajax al servidor
//**********************************************************************
(function ($) {
    $.f_ajaxRespuesta = function (paramAjax) {
        window.ajaxMessage = paramAjax['ajaxMessage'];
        jQuery.ajax({
            type: paramAjax["type"]==undefined?"POST":paramAjax["type"],            // GET, POST, PUT O DELETE (verbo HTTP), si se omite, por defecto es GET
            async: paramAjax["async"]==undefined?true:paramAjax["async"],           // true o false, llamada sícrona o asíncrona, por defecto la llamada es asíncrona
            timeout: paramAjax["timeout"]==undefined?600000:paramAjax["timeout"],   // Tiempo máximo de espera para la petición (en milisegundos)
            url: paramAjax["url"],                                                  // ubicación del servicio
            data: paramAjax["data"]==undefined?'':paramAjax["data"],                // data enviada al servidor
            dataType: paramAjax["dataType"]==undefined?'JSON':paramAjax["dataType"],// Tipo de dato que se espera que se devuelva en la respuesta
            contentType: paramAjax["contentType"]==undefined?'application/json; charset=UTF-8':paramAjax["contentType"],   // Tipo de contenido que se especifica en la petición. Si se omite, la opción por defecto es application/x-www-form-urlencoded
            success: paramAjax["success"],                                          // función si la llamada al server fue exitosa
            error: paramAjax["error"],                                              // función si la llamada al server falló
            cache: false
        });
    }
})(jQuery);

//**********************************************************************
// Nombre: $.f_ajaxRequestFailed
// Funcion: Visualiza alerta de error en la llamada al servidor
//**********************************************************************
(function ($) {
    $.f_ajaxRequestFailed = function (request, status, error) {
        var message = 'Ha fallado la petición al servidor [status request=' + request.status + '] ' + request.statusText;
        alert(message);
    }
})(jQuery);


//**********************************************************************
// Nombre: $.f_ajaxRequestFailed
// Funcion: Seguimiento de peticiones ajax
//**********************************************************************
(function ($) { 
    var xhrRequests = [];

    // Cada vez que se hace una petición la agregamos al array
    $(document).ajaxSend(function(e, jqXHR, options) {
        
    });

    // Al completarse la petición la elminamos del array
    $(document).ajaxComplete(function(e, jqXHR, options) {
        
    });

    // Cada vez que se hace una petición la agregamos al array
    $(document).ajaxStart(function(e, jqXHR, options) {
        var ajaxMessage = window.ajaxMessage;
        
        if (ajaxMessage != '')
            $.blockUI({ message: '<div style="background-color:blue;"><table border="0" cellpadding="5" cellspacing="0" align="center" width="150px"><colgroup><col width="20%" /><col width="80%" /></colgroup><tr><td><img alt="loading" src="../Content/images/img_ajax.gif" /></td><td style="font-size: 11px; width: 80px; height: 30px; forecolor: green">' + ajaxMessage + '...' + '</td></tr></table></div>' });

    });

    // Cada vez que se hace una petición la agregamos al array
    $(document).ajaxStop(function(e, jqXHR, options) {
        if (window.ajaxMessage != '')
            $.unblockUI();
    });

    $(document).ajaxComplete(function(e, jqXHR, options) {
        // Verificar si ocurrió timeout
        if (jqXHR.statusText == 'timeout')
            alert('La petición ha tardado demasiado para el timeout configurado.');
        else if (options.dataType == 'json' || options.dataType == 'iframe json' ) {
            var urlCurrent = window.location.href;
            var json = jqXHR.responseJSON;

        }
    });

})(jQuery);

     /// <summary>
     /// Funcion que exporta un fichero mediante una petición Ajax.
     /// </summary>
     /// <remarks>
     /// Creacion: LOG(TLV) 20120627 <br />
     /// Modificacion: 
     /// </remarks>
     (function ($) {
     $.f_ajaxExportarFichero = function (generarFichero, descargarFichero, datos, nombreReporte) {
         window.ajaxMessage = 'Generando el reporte de excel de '+ nombreReporte;
         jQuery.ajax({
             type: 'POST',
             url: generarFichero,
             data: datos,
             onSuccess: function (response) {
                 var hidNombreReporte = "<input type='hidden' id='nombreReporteExcel' name='nombreReporteExcel' value='" + nombreReporte + "'/>"
                 jQuery('<form action="' + descargarFichero + '" method="post">' + hidNombreReporte + '</form>')
		        .appendTo('body').submit().remove();
             }
         });
     }

})(jQuery);
