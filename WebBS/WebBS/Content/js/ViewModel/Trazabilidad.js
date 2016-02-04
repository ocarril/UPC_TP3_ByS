function ViewModel() {
    var self = this;
   
    self.Filtro = {
        CodigoProducto: ko.observable(),
        NombreProducto: ko.observable(),
        FechaInicio: ko.observable(util.date.format(new Date(), '01/01/yyyy')),
        FechaFin: ko.observable(util.date.format(new Date(), 'dd/MM/yyyy'))
    }

    self.NombreProducto = ko.observable();

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
        self.NombreProducto(data.nombreProducto);
        $('#modal-productos').modal('hide');
    }

    self.ConsultarTrazabilidad = function () {
        if (!self.Filtro.CodigoProducto()) {
            toastr.warning('Ingrese un producto para buscar');
            return;
        }

        var fec_ini = self.Filtro.FechaInicio(),
            fec_fin = self.Filtro.FechaFin();

        if (fec_ini && !fec_fin || !fec_ini && fec_fin) {
            toastr.warning('Ingrese fecha de inicio y fecha final');
            return;
        }

        if (fec_ini && fec_fin) {
            fec_ini = util.date.toJson(util.date.format(fec_ini, 'dd/MM/yyyy'));
            fec_fin = util.date.toJson(util.date.format(fec_fin, 'dd/MM/yyyy'));

            if (fec_fin.getTime() - fec_ini.getTime() < 0) {
                toastr.info('La Fecha Final debe ser mayor que la Fecha Inicio, no se puede procesar.');
                return;
            }
        }
        var siinregistro = [];
        $.ajax({
            type: 'POST',
            url: urlPath + 'Trazabilidad/ConsultarTrazabilidad',
            data: ko.toJSON({
                Codigo: self.Filtro.CodigoProducto(),
                FechaInicio: self.Filtro.FechaInicio(),
                FechaFin: self.Filtro.FechaFin(),
                NombreProducto: self.Filtro.NombreProducto()
            }),
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
                console.log(data);
                debugger;
                //self.NombreProducto(data.Producto);
                if (data.InformeVenta.length>0) {
                    self.VentasArray(data.InformeVenta);
                    self.KardexArray(data.Kardex);
                    self.OrdenesCompraArray(data.OrdenesCompra);
                    self.OrdenesPedidoArray(data.OrdenesPedido);
                    self.RecetasArray(data.Recetas);
                    self.HojaMermaArray(data.HojaMerma);
                    toastr.success('Ha finalizado el análisis de trazabilidad');
                } else {
                    toastr.warning('No se encontro información para el producto');
                    self.VentasArray(siinregistro);
                    self.KardexArray(siinregistro);
                    self.OrdenesCompraArray(siinregistro);
                    self.OrdenesPedidoArray(siinregistro);
                    self.RecetasArray(siinregistro);
                    self.HojaMermaArray(siinregistro);

                }
            },
            error: function (dataError) {
                console.log(dataError);
            }
        });
    }

    self.Aceptar = function () {           
        $.post(urlPath + 'Trazabilidad/GuardarTrazabilidad', { listakardex: self.KardexArray(), listaOrdenCompra: self.OrdenesCompraArray(), listaventa: self.VentasArray(), listamerma: self.HojaMermaArray(), listadespacho: self.OrdenesPedidoArray(), listareceta: self.RecetasArray(), CodigoProducto: self.Filtro.CodigoProducto() })
          .done(function (codigo) {
              //console.log(codigo);             
              toastr.success('Se guardaron cambios.', 'Trazabilidad');
             
          }).fail(function (dataError) {
              console.log(dataError);
              toastr.error('No se pudo registrar la trazabilidad consultada. ');
          });
    }
}
var modelo;
$(function () {    
    modelo = new ViewModel();
    ko.applyBindings(modelo);
   
});

