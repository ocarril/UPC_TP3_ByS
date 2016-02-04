function ViewModel() {
    var self = this;
    var paso = 0;
    self.Filtro = {
        CodigoProducto: ko.observable(),
        NombreProducto: ko.observable()        
    }

    self.NombreProducto = ko.observable();
    self.Procedimientos = {
        version: ko.observable(),
        codigoProcedimiento: ko.observable(),
        fechIniVigencia: ko.observable(util.date.format(new Date(), 'dd/MM/yyyy')),
        fechFinVigencia: ko.observable(util.date.format(new Date(), 'dd/MM/yyyy')),
        responsable: ko.observable(),
        unidadPlazo: ko.observable(),
        observaciones: ko.observable(),
        nombreProducto: ko.observable(),
        actividadProcedimiento: ko.observable(),
        plazoActividad: ko.observable()
    }
    self.productos = ko.observableArray();
    self.ProcedimientoArray = ko.observableArray();
    //self.KardexArray = ko.observableArray();
    //self.OrdenesCompraArray = ko.observableArray();
    //self.OrdenesPedidoArray = ko.observableArray();
    //self.RecetasArray = ko.observableArray();
    //self.HojaMermaArray = ko.observableArray();

    //self.productos = ko.observableArray();



    self.BuscarProducto = function () {
        if (!self.Filtro.NombreProducto()) {
            toastr.warning('Ingrese un nombre de producto para buscar');
            return;
        }

        $.getJSON(urlPath + 'Trazabilidad/BuscarProductoTraza?producto=' + self.Filtro.NombreProducto())
            .done(function (data) {
                debugger;
                if (data.length > 0) {
                    self.productos(data);
                    $('#modal-productos').modal('show');
                } else if (data.length == 0) {
                    toastr.warning('No hay resultados de la búsqueda');
                    //self.LimpiarPantalla();
                }
            }).fail(function () {
                toastr.error('El código no está asociado a ningun producto registrado');
            });
    }


    self.SeleccionarProducto = function (data) {
        self.Filtro.CodigoProducto(data.codigoProducto);
        self.Filtro.NombreProducto(data.nombreProducto);
        //self.NombreProducto(data.nombreProducto);
        $('#modal-productos').modal('hide');
    }

    self.BuscarProcedimiento = function () {

        var idProducto = self.Filtro.CodigoProducto();
        if (idProducto == "") {
            toastr.warning('Seleccione un producto para buscar');
            return;
        }

        $.getJSON(urlPath + 'Trazabilidad/BuscarProcediento?producto=' + idProducto)
            .done(function (data) {
                paso = 0;
                if (data.length > 0) {
                    self.ProcedimientoArray(data);
                    paso = 1;
                    //('#modal-productos').modal('show');
                } else {
                    self.ProcedimientoArray(data);
                    toastr.warning('No hay resultados de la búsqueda');
                    //self.LimpiarPantalla();
                }
            }).fail(function () {
                toastr.error('El código no está asociado a ningun producto registrado');
            });
    };

    self.SeleccionarProcedimiento = function (data) {
        debugger;
        if (paso == 1) {
            self.ConsultarTrazabilidad(data);
        }
    };

    self.ConsultarTrazabilidad = function (codigoProcedimiento) {
        $('#divRegistroProce').modal('show');
        if (codigoProcedimiento.length > 0) {
            //'use strict';

            //var divID = 'divRegistroProce';
            //var modal = true;
            //var title = ''; //'Datos de la partida presupuestal';
            //var width = 'auto';
            //var height = null;
            //var draggable = true;
            //var resizable = false;
            //var buttons = {
            //    'Cerrar': function (event) {
            //        $(this).dialog('hide');
            //    },
            //    'Guardar': function () {
            //        self.ActualizarProcedimiento(this);
            //    }
            //};
            //$.f_dialog_open_noButtons(divID, modal, title, width, height, draggable, resizable).dialog({ buttons: buttons })
            //.dialog({
            //    beforeClose: function (event, ui) {
            //        $('#divRegistroProce').find(':text, select').val('');  // Limpiar campos del popup
            //    }
            //});
            //$.f_dialogCssApply(divID);
            if (codigoProcedimiento.length > 0) {               
                $.ajax({
                    type: 'POST',
                    url: urlPath + 'Trazabilidad/BuscarProcedientoPorId',
                    data: ko.toJSON({
                        pcodigoProcedimiento: codigoProcedimiento
                    }),
                    dataType: 'json',
                    contentType: 'application/json',
                    success: function (data) {                        
                        console.log(data);
                        debugger;
                        self.Procedimientos.codigoProcedimiento(data.codigoProcedimiento);
                        self.Procedimientos.version(data.version);
                        self.Procedimientos.fechIniVigencia(data.fechIniVigencia);
                        self.Procedimientos.fechFinVigencia(data.fechFinVigencia);
                        self.Procedimientos.responsable(data.responsable);
                        self.Procedimientos.unidadPlazo(data.unidadPlazo);
                        self.Procedimientos.observaciones(data.observaciones);                    
                        self.Procedimientos.actividadProcedimiento(data.actividadProcedimiento);
                        self.Procedimientos.plazoActividad(data.plazoActividad);
                        toastr.success('Se ha consultado correctamente el Informe de trazabilidad');
                    },
                    error: function (dataError) {
                        console.log(dataError);
                    }
                });
            }
        }
    }


    self.ActualizarProcedimiento = function (obj) {
        var cadena = '';
        if (!self.Procedimientos.version()) {
            cadena += 'Ingrese la Versión</br>';                    
        }
        if (!self.Procedimientos.fechIniVigencia()) {
            cadena += 'Ingrese la Fecha de Inicio</br>';            
        }
        if (!self.Procedimientos.fechFinVigencia()) {
            cadena += 'Ingrese la Fecha de Fin</br>';
        }
        if (!self.Procedimientos.responsable()) {
            cadena += 'Ingrese el Responsable</br>';
        } 
        if (!self.Procedimientos.unidadPlazo()) {
            cadena += 'Ingrese la Unidad Plazo</br>';
        }
        if (!self.Procedimientos.observaciones()) {
            cadena += 'Ingrese las Observaciones</br>';
        }
        if (!self.Procedimientos.actividadProcedimiento()) {
            cadena += 'Ingrese la Actividad del Prodcedimiento</br>';
        }
        if (!self.Procedimientos.plazoActividad()) {
            cadena += 'Ingrese el Plazo de la Actividad</br>';
        }


        var fec_ini = self.Procedimientos.fechIniVigencia(), fec_fin = self.Procedimientos.fechFinVigencia();

        if (fec_ini && fec_fin) {
            fec_ini = util.date.toJson(util.date.format(fec_ini, 'dd/MM/yyyy'));
            fec_fin = util.date.toJson(util.date.format(fec_fin, 'dd/MM/yyyy'));

            if (fec_fin.getTime() - fec_ini.getTime() < 0) {
                cadena += 'La Fecha Final debe ser menor que la Fecha Inicio, no se puede procesar.</br>';
            }
        }



        if (cadena.length > 0)
        {
            toastr.warning(cadena);
            return;k
        }
        
        $.ajax({
            type: 'POST',
            url: urlPath + 'Trazabilidad/ActualizarProcedimiento',
            data: ko.toJSON({
                entity: self.Procedimientos
            }),
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
               // console.log(data);

                toastr.success('Se actualizo correctamente el Procedimiento.');
                $('#divRegistroProce').modal('hide');
                self.BuscarProcedimiento();
            },
            error: function (dataError) {
                console.log(dataError);
                toastr.error('Ocurrio un erro al actualizar el Procedimiento.');
            }
        });
    }
    self.CerrarProcedimiento = function (obj) {
        $('#divRegistroProce').modal('hide');
    }

    self.ImprimirProcedimiento = function ()
    {    
        $("#procedimientoficha").printThis();
    }
}


var modelo;
$(function () {

    modelo = new ViewModel();
    ko.applyBindings(modelo);

});
