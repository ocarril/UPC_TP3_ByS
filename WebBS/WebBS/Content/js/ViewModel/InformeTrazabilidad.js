function ViewModel() {
    var self = this;
    $("#seccioncomentario").hide();
    var midatatemp = {};
    self.Filtro = {
        CodigoProducto: ko.observable(),
        NombreProducto: ko.observable()     
    }    
   


    self.Trazabilidad = {
        codigoTraza: ko.observable(),
        fechaTraza: ko.observable(),
        nombreProducto: ko.observable(),
        estado: ko.observable(),     
        detalleAnalisis: ko.observable()        
    }


    self.VentasArray = ko.observableArray();
    self.KardexArray = ko.observableArray();
    self.OrdenesCompraArray = ko.observableArray();
    self.OrdenesPedidoArray = ko.observableArray();
    self.RecetasArray = ko.observableArray();
    self.HojaMermaArray = ko.observableArray();

    self.productos = ko.observableArray();
    self.BuscarProducto = function () {
        if (!self.Filtro.NombreProducto()) {
            toastr.warning('Ingrese un nombre de producto para buscar');
            return;
        }

        $.getJSON(urlPath + 'Trazabilidad/BuscarProductoTraza?producto=' + self.Filtro.NombreProducto())
            .done(function (data) {                
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

    self.ConsultarInformeTrazabilidad = function () {
        if (!self.Filtro.CodigoProducto()) {
            toastr.warning('Ingrese un producto para buscar');
            return;
        }

        $.ajax({
            type: 'POST',
            url: urlPath + 'Trazabilidad/ConsultarInformeTrazabilidad',
            data: ko.toJSON({
                Codigo: self.Filtro.CodigoProducto()                
            }),           
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
                console.log(data);               
                if (data.codigoTraza)
                {
                    self.Confirmacion(data);
                    
                }
                else
                {
                    toastr.warning('No se encontro trazabilidad para el producto.');
                    
                }
            },
            error: function (dataError) {
                console.log(dataError);
            }
        });
    }

    self.GenerarInformeTraza = function ()    {
        $("#seccioncomentario").show();
        self.Trazabilidad.detalleAnalisis(undefined);        
        $("#busquedadeproducto").hide();
    }

    self.CancelarInformeTraza = function () {
        $("#seccioncomentario").hide();
        self.Limpiar();
    }

    self.CancelarEditarInforme = function () {
        $("#busquedadeproducto").show();
        $("#seccioncomentario").hide();
        self.Limpiar();
    }

    self.Confirmacion = function (data) {

        if (data.estadoinformetrazabilidad.length == 0) {
            self.Trazabilidad.codigoTraza(data.codigoTraza);
            self.Trazabilidad.fechaTraza(data.fechaTraza);
            self.Trazabilidad.nombreProducto(data.nombreProducto);
            self.Trazabilidad.estado(data.estado);
            self.VentasArray(data.InformeVenta);
            self.KardexArray(data.Kardex);
            self.OrdenesCompraArray(data.OrdenesCompra);
            self.OrdenesPedidoArray(data.OrdenesPedido);
            self.RecetasArray(data.Recetas);
            self.HojaMermaArray(data.HojaMerma);
            toastr.success('Se ha consultado correctamente el Informe de trazabilidad');
        } else {
         midatatemp = data;
         $('#modal-confirmar').modal('show');

        }
    }

    self.AceptarConfirmar = function () {               
            var data = midatatemp;        
                    self.Trazabilidad.codigoTraza(data.codigoTraza);
                    self.Trazabilidad.fechaTraza(data.fechaTraza);
                    self.Trazabilidad.nombreProducto(data.nombreProducto);
                    self.Trazabilidad.estado(data.estado);
                    self.VentasArray(data.InformeVenta);
                    self.KardexArray(data.Kardex);
                    self.OrdenesCompraArray(data.OrdenesCompra);
                    self.OrdenesPedidoArray(data.OrdenesPedido);
                    self.RecetasArray(data.Recetas);
                    self.HojaMermaArray(data.HojaMerma);
                    toastr.success('Se ha consultado correctamente el Informe de trazabilidad');
        
        $('#modal-confirmar').modal('hide');
        midatatemp = undefined;
    }

    self.CancelarConfirmar = function () {
        debugger;
        $('#modal-confirmar').modal('hide');
        self.Limpiar();
        midatatemp = undefined;
    }

    self.Limpiar = function ()
    {
        var siinregistro = [];
        self.Trazabilidad.codigoTraza(undefined);
        self.Trazabilidad.fechaTraza(undefined);
        self.Trazabilidad.nombreProducto(undefined);
        self.Trazabilidad.estado(undefined);

        self.VentasArray(siinregistro);
        self.KardexArray(siinregistro);
        self.OrdenesCompraArray(siinregistro);
        self.OrdenesPedidoArray(siinregistro);
        self.RecetasArray(siinregistro);
        self.HojaMermaArray(siinregistro);

    }
    self.GenerarInformeTrazabilidad = function () {
        //if (!self.Trazabilidad.comentario()) {
        //    toastr.warning('Ingrese un comentario para el Informe de Trazabilidad.');
        //    return;
        //}

        $.ajax({
            type: 'POST',
            url: urlPath + 'Trazabilidad/GuardarInformeTrazabilidad',
            data: ko.toJSON({
                entity: self.Trazabilidad,
                codigoproducto: self.Filtro.CodigoProducto()
            }),
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
                console.log(data);
                //self.Trazabilidad.codigoTraza(data.codigoTraza);
                //self.Trazabilidad.fechaVenta(data.fechaVenta);
                //self.Trazabilidad.nombreProducto(data.nombreProducto);
                //self.Trazabilidad.fechaCompra(data.fechaCompra);
                //self.Trazabilidad.nombreCliente(data.nombreCliente);
                //self.Trazabilidad.numeroOrden(data.numeroOrden);
                //self.Trazabilidad.nombreProveedor(data.nombreProveedor);
                //self.Trazabilidad.precio(data.precio);
                //self.Trazabilidad.saldos(data.saldos);
                //self.Trazabilidad.observaciones(data.observaciones);
                //self.NombreProducto(data.Producto);            
                toastr.success('Se guardo correctamente el Informe de trazabilidad.');

                self.CancelarEditarInforme();
                midatatemp = undefined;
            
            },
            error: function (dataError) {

                console.log(dataError);
                toastr.success('Se guardo correctamente el Informe de trazabilidad.');

                self.CancelarEditarInforme();
                midatatemp = undefined;
               
                //toastr.error('Ocurrio un erro al guardar el Informe de trazabilidad.');
            }
        });

       
    }

}
var modelo;
$(function () {    
    modelo = new ViewModel();
    ko.applyBindings(modelo);
   
});

