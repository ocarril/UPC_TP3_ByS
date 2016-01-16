function ViewModel() {
    var self = this;
    
    self.Filtro = {
        CodigoProducto: ko.observable('001'),
        NombreProducto: ko.observable(),
        FechaInicio: ko.observable(util.date.format(new Date(), '01/01/yyyy')),
        FechaFin: ko.observable(util.date.format(new Date(), 'dd/MM/yyyy'))
    }    
   
    self.VentasArray = ko.observableArray();
    self.KardexArray = ko.observableArray();
    self.OrdenesCompraArray = ko.observableArray();
    self.OrdenesPedidoArray = ko.observableArray();
    self.RecetasArray = ko.observableArray();
    self.HojaMermaArray = ko.observableArray();

    self.ConsultarTrazabilidad = function () {
        if (!self.Filtro.CodigoProducto() || !self.Filtro.FechaInicio() || !self.Filtro.FechaFin()) {
            toastr.warning('Ingrese un código de producto y un período de fechas para consultar');
            return;
        }

        $.ajax({
            type: 'POST',
            url: urlPath + 'Producto/ConsultarTrazabilidad',
            data: ko.toJSON({
                Codigo: self.Filtro.CodigoProducto(),
                FechaInicio: self.Filtro.FechaInicio(),
                FechaFin: self.Filtro.FechaFin()
            }),
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
                //console.log(data);
                self.Filtro.NombreProducto(data.Producto);
                self.VentasArray(data.InformeVenta);
                self.KardexArray(data.Kardex);
                self.OrdenesCompraArray(data.OrdenesCompra);
                self.OrdenesPedidoArray(data.OrdenesPedido);
                self.RecetasArray(data.Recetas);
                self.HojaMermaArray(data.HojaMerma);
            },
            error: function (dataError) {
                console.log(dataError);
            }
        });
    }
}

$(function () {
    var modelo = new ViewModel();
    ko.applyBindings(modelo);
});