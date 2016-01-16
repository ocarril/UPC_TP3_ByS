//**********************************************************************
// Nombre: $.f_extensionIsValid
// Función: Determina si extensión se encuentra dentro del array validExtensions
//**********************************************************************

(function ($) {
    $.f_extensionIsValid = function (extension, validExtensions) {
        for (var t in validExtensions)
            if (validExtensions[t] == extension) return true;

        return false;
    }
})(jQuery);


(function($) {
    $.f_deleteFileServerSuccess = function(response, status) {
        if (status == 'success') {
            var tipo = response.Type;
            var mensaje = response.Data;

            if (tipo == "E")
                $.f_showError(mensaje);
            else if (tipo == "I") {
                alert(mensaje);
            }
            else if (tipo == "C") {
                // Nothing
            }
        }
    }
})(jQuery);