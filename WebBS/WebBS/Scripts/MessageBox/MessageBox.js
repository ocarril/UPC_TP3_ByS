// Copyright (c) 2012.
// All rights reserved.
/// <summary>
/// Control MessageBox.
/// </summary>
/// <remarks>
/// Creacion: 	LOG(ABL) 20120525
/// </remarks>

//ns('GC.CROM');
//ns('CROM.GC.UI');
//ns('CROM.GC.Path');
CROMMessageBoxType = function () {
    this.Error = 1;         // ROJO
    this.Alerta = 2;        // NARANJA
    this.Informacion = 3;   // VERDE
    this.Confirmacion = 4;  // AZULADO
}

//TODO: El nombre se cambiara a MessageBox al dar de baja al antiguo control
CROMMessageBox = function (configuracion) {

    //CONFIGURACION INICIAL
    //---------------------------------------------------

    var base = this;
    this.control = null;
    this.superposicion = null;
    this.tipoMensaje = new CROMMessageBoxType();
    this.contenedor = $(document.body);

    Inicializar(configuracion);


    //FUNCIONES PUBLICAS
    //----------------------------------------------------

    this.EstablecerConfiguracion = function (configuracion) {

        Inicializar(configuracion);
    };

    this.ObtenerConfiguracion = function () {
        return this.configuracion;
    };

    this.Mostrar = function (configuracion) {

        if (configuracion) {
            this.EstablecerConfiguracion(configuracion);
        }

        //Si existe un codigo se carga la información proporcionado de base de datos
        if (this.configuracion.codigo) {
            var CROMAjax = new CROM.GC.Ajax({
                data: { 'codigoMensaje': this.configuracion.codigo, 'listaParametro': this.configuracion.argumentos },
                action: this.configuracion.urlControlador,
                onSuccess: function (data) {
                    base.configuracion.titulo = data.Titulo;
                    base.configuracion.contenido = data.Texto;
                    base.configuracion.tipo = data.Tipo;

                    AplicarConfiguracion();
                }
            });
        }
        else {
            AplicarConfiguracion();
        }
    };

    this.Ocultar = function () {
        'use strict';

        if (this.control) {
            this.control.fadeOut(300);
        }
        if (this.superposicion) {
            this.superposicion.fadeOut(300);
        }
    };

    this.Cerrar = function () {

        if (this.control) {
            this.control.fadeOut(300, function () { Destruir(); });
        }
        if (this.superposicion) {
            this.superposicion.fadeOut(300);
        }
    };

    //FUNCIONES PRIVADAS
    //----------------------------------------------------

    function Inicializar(configuracion) {

        Destruir();

        base.configuracion = {
            codigo: null,
            argumentos: null,
            //urlControlador: CROM.GC.Path.Aplicacion + 'Mensaje/ObtenerMensaje/',
            tipo: base.tipoMensaje.Alerta,
            posicionX: '10px',
            posicionY: 'center',
            modal: true,
            manejadorEventoCerrar: null,
            autoCerrado: null,
            botones: null,
            contenedorPosicion: null,
            tiempoDesvanecimiento: 7000,
            destruirAlCerrar: true,
            titulo: 'Sistema ERP ByS'
        };

        if (configuracion) {
            $.extend(base.configuracion, configuracion);
        }

        //Definición de contenedor del control
        base.control = $(document.createElement('div'));
        base.control.addClass('messageBoxCROM');
        base.control.addClass('messageBoxPosicionDefaultCROM');
        base.control.keydown(function (e) {
            var evt = e || window.event;
            var codigoAsciiCerrar = evt.keyCode ? evt.keyCode : e.which;
            if (codigoAsciiCerrar === 27) {
                if (base.configuracion.manejadorEventoCerrar) {
                    base.configuracion.manejadorEventoCerrar();
                }
                base.Cerrar();
            }
        });

        //Definición de la cabecera del control
        var cabecera = $(document.createElement('div'));
        cabecera.addClass('cabecera');
        cabecera.append($(document.createElement('span')).addClass('titulo'));
        var botonCerrar = $(document.createElement('span'));
        botonCerrar.addClass('botonCerrar');
        botonCerrar.text('X');
        botonCerrar.click(function () {
            if (base.configuracion.manejadorEventoCerrar) {
                base.configuracion.manejadorEventoCerrar();
            }
            base.Cerrar();
        });
        cabecera.append(botonCerrar);
        base.control.append(cabecera);

        //Definición del contenido
        var contenido = $(document.createElement('div'));
        contenido.addClass('contenido');
        base.control.append(contenido);

        base.control.css('zIndex', '9999');
        base.control.css('display', 'none');

        if (base.configuracion.contenedorPosicion && base.configuracion.contenedorPosicion != null) {
            base.control.removeClass('messageBoxPosicionDefaultCROM');
            $('#' + base.configuracion.contenedorPosicion).empty();
            $('#' + base.configuracion.contenedorPosicion).append(base.control);
        }
        else {
            base.contenedor.append(base.control);
        }

        AplicarTexto();

        if (base.configuracion.tipo != base.tipoMensaje.Informacion) {
            AsignarBotones();
        }
    }

    function CancelarProcesosActivos() {
        if (base.control != null && base.control.is(':animated')) {
            base.control.stop(true, true);
        }

        if (base.superposicion != null && base.superposicion.is(':animated')) {
            base.superposicion.stop(true, true);
        }
    }

    function AplicarConfiguracion() {
        AplicarTexto();

        AplicarSuperposicion(base.configuracion.modal);

        AplicarPosicion(base.configuracion.posicionX, base.configuracion.posicionY);

        AplicarTipo(base.configuracion.tipo);

        if (base.control) {
            base.control.fadeIn(300, function () { base.control.focus(); });
        }

        if (base.superposicion) {
            base.superposicion.fadeTo(300, 0.3);
        }

        if (base.configuracion.autoCerrado) {
            AutoCerrado();
        }
    }

    function AplicarTexto() {

        if (base.configuracion.titulo) {
            $('.titulo', base.control).text(base.configuracion.titulo);
        }

        if (base.configuracion.contenido) {
            $('.contenido', base.control).html(base.configuracion.contenido);
        }
    }

    function AsignarBotones() {
        var botones = base.configuracion.botones;
        if (botones) {
            //Se elimina la botonera existente
            $('botonera', base.control).empty();
            $('botonera', base.control).remove();

            //Creación de la botonera
            var botonera = $(document.createElement('div'));
            botonera.addClass('botonera');

            for (var botonIndice in botones) {

                botonera.append('&nbsp;&nbsp;');

                var boton = botones[botonIndice];

                var botonElemento = $(document.createElement('span'));
                botonElemento.addClass('buttonCROM');
                botonElemento.text(boton.Etiqueta);
                botonElemento.click(boton.Click);
                botonElemento.click(function () { base.Cerrar(); });
                botonera.append(botonElemento);
            }

            base.control.append(botonera);
        }
    }

    function AplicarSuperposicion(modal) {
        if (modal) {
            base.superposicion = $(document.createElement('div'));
            base.superposicion.addClass('panelSuperposicion');
            base.superposicion.css('zIndex', '9998');
            base.superposicion.css('display', 'none');

            $(document.body).append(base.superposicion);
        }
    }

    function AplicarTipo(tipo) {
        base.control.removeClass('error');
        base.control.removeClass('alerta');
        base.control.removeClass('informacion');
        base.control.removeClass('confirmacion');
        base.control.css('center', '');
        base.control.css('top', '');
                
        switch (tipo) {
            case base.tipoMensaje.Error:
                base.control.addClass('error');
                break;

            case base.tipoMensaje.Alerta:
                base.control.addClass('alerta');
                break;

            case base.tipoMensaje.Informacion:
                if (base.configuracion.autoCerrado === undefined || base.configuracion.autoCerrado === null)
                    base.configuracion.autoCerrado = true;

                base.control.addClass('informacion');
                if (base.superposicion) {
                    base.superposicion.remove();
                    base.superposicion = null;
                }
                base.control.click(function () { base.Cerrar(); });
                break;

            case base.tipoMensaje.Confirmacion:
                base.control.addClass('confirmacion');
                break;
        }
    }

    function AplicarPosicion(posicionX, posicionY) {
        switch (posicionX) {
            case 'center':
                base.control.css('left', (($(window).width() - base.control.outerWidth()) / 2) + $(window).scrollLeft() + 'px');
                break;
            case 'left':
                base.control.css('left', '0px');
                break;
            case 'right':
                base.control.css('right', (($(window).width() - base.control.outerWidth())) + $(window).scrollLeft() + 'px');
                break;
            default:
                base.control.css('left', posicionX);
                break;
        }

        switch (posicionY) {
            case 'center':
                base.control.css('top', (($(window).height() - base.control.height()) / 2) + $(window).scrollTop() + 'px');
                break;
            case 'top':
                base.control.css('top', '0px');
                break;
            case 'bottom':
                base.control.css('top', (($(window).height() - base.control.outerHeight())) + $(window).scrollTop() + 'px');
                break;
            default:
                base.control.css('top', posicionY);
                break;
        }
    }

    function AutoCerrado() {
        base.control.fadeOut(base.configuracion.tiempoDesvanecimiento, function () { Destruir(); });

        if (base.superposicion) {
            base.superposicion.fadeOut(base.configuracion.tiempoDesvanecimiento);
        }
    }

    function Destruir() {

        CancelarProcesosActivos();

        //if (base.configuracion.destruirAlCerrar) {
            if (base.control) {
                base.control.empty();
                base.control.remove();
                base.control = null;
            }

            if (base.superposicion) {
                base.superposicion.remove();
                base.superposicion = null;
            }
        //}
    }
};