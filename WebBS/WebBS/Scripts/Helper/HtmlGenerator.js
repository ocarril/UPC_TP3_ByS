(function ($) {
    $.f_getHtmlException = function (descripcion, fuente, stackTrace) {

        $.f_closeAllOpenDialog('div[id=dataForm] div[id=popups]');

        var html = '';

        html += "<div style='padding: 5px 5px 5px 5px;'>";
        html += "<div style='padding: 8px 4px 4px 4px;border: 1px solid #CCCCCC;'>";
        html += "<table id='tbException'>";
        html += "<tr>";
        html += "<td style='padding-bottom: 15px' colspan='2'><label style='font-size: 18px; color:red;'>Se ha producido una excepción. Se detalla información de la misma para su tratamiento.</label></td>";
        html += "</tr>";
        html += "<tr>";
        html += "<td><label style='font-family: Sans-Serif,Helvetica;color: navy;font-size: 12px;font-weight: bold;' for='txtDescripcion'>Descripción: </label></td>";
        html += "<td><textarea cols='30' rows='4' style='width:600px' id='txtDescripcion' name='txtDescripcion'>" + descripcion + "</textarea></td>";
        html += "</tr>";
        html += "<tr>";
        html += "<td><label style='font-family: Sans-Serif, Helvetica;color: navy;font-size: 12px;font-weight: bold;' for='txtFuente'>Fuente: </label></td>";
        html += "<td><textarea cols='30' rows='3' style='width:600px'>" + fuente + "</textarea></td>";
        html += "</tr>";
        html += "<tr>";
        html += "<td><label style='font-family: Sans-Serif, Helvetica;color: navy;font-size: 12px;font-weight: bold;' for='txtStackTrace'>Stack Trace: </label></td>";
        html += "<td><textarea cols='30' rows='5' style='width:600px'>" + stackTrace + "</textarea></td>";
        html += "</tr>";
        html += "</table>";
        html += "</div>";
        html += "</div>";

        return html;
    }
})(jQuery);
