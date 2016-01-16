//ns("Belcorp.Planit.UI");
/// <summary>
/// Control de mensaje de carga
/// </summary>
/// <remarks>
/// Creacion: 	    LOG(RCP) 20120618 <br />
/// Modificacion: 
/// </remarks>
CROMMensajeCarga = function (opciones) {
    this.Inicializar(opciones);
};

CROMMensajeCargaprototype = {
    _objetivo: null,
    _contenedorCarga: null,
    _fondoCarga: null,

    Inicializar: function (opciones) {

        this._objetivo = document.body;

        if (opciones) {
            this._objetivo = opciones.renderizarEn ? document.getElementById(opciones.renderizarEn) : document.body;
        }

        var contenedorImagen = document.createElement('div');
        contenedorImagen.className = 'mensajeCarga';

        this._contenedorCarga = document.createElement('div');
        this._contenedorCarga.className = 'mensajeCargaPlanit';
        this._contenedorCarga.appendChild(contenedorImagen);

        this._fondoCarga = document.createElement('div');
        this._fondoCarga.className = 'mensajeCargaPlanitBackground';

        if (this._objetivo != document.body) {
            this._objetivo.style.position = 'relative';
            this._fondoCarga.style.position = 'absolute';
            this._contenedorCarga.style.position = 'absolute';
        }

        this._objetivo.appendChild(this._fondoCarga);
        this._objetivo.appendChild(this._contenedorCarga);
    },

    Mostrar: function () {
        $(this._fondoCarga).show();
        $(this._contenedorCarga).show();
        this._contenedorCarga.focus();
    },

    Ocultar: function () {
        $(this._fondoCarga).hide();
        $(this._contenedorCarga).hide();
    },

    Cerrar: function () {
        this.Ocultar();
        $(this._contenedorCarga).remove();
        $(this._fondoCarga).remove();
        this._contenedorCarga = null;
        this._fondoCarga = null;
        this._objetivo = null;
    }
};