//**********************************************************************
// Nombre: $.f_esFechaValida
// Funcion: Devuelve true si la fecha contenida en el control enviado, es consistente. False en caso contrario
//**********************************************************************
(function ($) {
    $.f_esFechaValida = function (datePickerID, formatoFecha) {
        if (formatoFecha == null) formatoFecha = $('#hdFormatoFechaDefault').val();

        var fecha = $('#' + datePickerID).val();
        var tokens = fecha.split('/');

        if (tokens.length != 3) return false;

        var dia, mes, anio;

        switch (formatoFecha) {
            case $('#hdFormatoFechaDefault').val():
                dia = parseInt(tokens[0], 10);
                mes = parseInt(tokens[1], 10);
                anio = parseInt(tokens[2], 10);
                break;
            case $('#hdFormatoFecha2').val():
                mes = parseInt(tokens[0], 10);
                dia = parseInt(tokens[1], 10);
                anio = parseInt(tokens[2], 10);
                break;
            case $('#hdFormatoFecha3').val():
                anio = parseInt(tokens[0], 10);
                mes = parseInt(tokens[1], 10);
                dia = parseInt(tokens[2], 10);
                break;
        }

        if (mes < 1 || mes > 12) return false;

        var caso = $.f_esBisiesto(anio) ? 1 : 0;

        var diasPorMes = [[0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]];

        var maximoDias = diasPorMes[caso][mes];

        return dia <= maximoDias;
    }
})(jQuery);


//**********************************************************************
// Nombre: $.f_esFechaValida
// Funcion: Devuelve true si la fecha contenida en el control enviado, es consistente. False en caso contrario
//**********************************************************************
(function ($) {
    $.f_esFechaValida2 = function (sFecha, formatoFecha) {
        if (formatoFecha == null) formatoFecha = $('#hdFormatoFechaDefault').val();

        var fecha = sFecha;
        var tokens = fecha.split('/');

        if (tokens.length != 3) return false;

        var dia, mes, anio;

        switch (formatoFecha) {
            case $('#hdFormatoFechaDefault').val():
                dia = parseInt(tokens[0], 10);
                mes = parseInt(tokens[1], 10);
                anio = parseInt(tokens[2], 10);
                break;
            case $('#hdFormatoFecha2').val():
                mes = parseInt(tokens[0], 10);
                dia = parseInt(tokens[1], 10);
                anio = parseInt(tokens[2], 10);
                break;
            case $('#hdFormatoFecha3').val():
                anio = parseInt(tokens[0], 10);
                mes = parseInt(tokens[1], 10);
                dia = parseInt(tokens[2], 10);
                break;
        }

        if (mes < 1 || mes > 12) return false;

        var caso = $.f_esBisiesto(anio) ? 1 : 0;

        var diasPorMes = [[0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]];

        var maximoDias = diasPorMes[caso][mes];

        return dia <= maximoDias;
    }
})(jQuery);



//**********************************************************************
// Nombre: $.f_esBisiesto
// Funcion: Devuelve true si el anio enviado es bisiesto. False en caso contrario
//**********************************************************************
(function ($) {
    $.f_esBisiesto = function(anio) {
        return anio % 4 == 0 && (anio % 100 != 0 || anio % 400 == 0);
    }
})(jQuery);


//**********************************************************************
// Nombre: $.f_esBisiesto
// Funcion: Devuelve true si el anio enviado es bisiesto. False en caso contrario
//**********************************************************************
(function($) {
    $.f_esIPV4Valida = function(entry) {
        var blocks = entry.split('.');
        
        if (blocks.length != 4) return false;

        for (index in blocks) {
            var block = $.trim(blocks[index]);
            if (block == '' || parseInt(block, 10) < 0 || parseInt(block, 10) > 255) return false;
        }

        return true;
    }
})(jQuery);


