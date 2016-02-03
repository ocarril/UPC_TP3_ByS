function Producto(data) {
    if (!data) data = {};
    this.codigoProducto = ko.observable(data.codigoProducto);
    this.nombreProducto = ko.observable(data.nombreProducto);
    this.descripcion = ko.observable(data.descripcion);
    this.tipoProducto = ko.observable(data.tipoProducto);
    this.presentacion = ko.observable(data.presentacion);
    this.pesoProducto = ko.observable(data.pesoProducto);
    
    
}

function OrdenRetiro(data) {
    if (!data) data = {};
    this.codigoProducto = ko.observable(data.codigoProducto);
    this.fecha = ko.observable(data.fecha);
    this.autorizado = ko.observable(data.autorizado);
    this.motivo = ko.observable(data.motivo);
    this.riesgo = ko.observable(data.riesgo);
}

function ViewModel() {
    var self = this;

    self.ProductoBusqueda = ko.observable();
    self.producto = new Producto();
    self.orden = new OrdenRetiro();

    self.BuscarProducto = function () {
        if (self.ProductoBusqueda()) {
            /*self.producto.codigoProducto(1);
            self.producto.nombreProducto('PANADOL');
            self.producto.descripcion('');
            self.producto.tipoProducto('Pastillas');
            self.producto.presentacion('Tabletas');
            self.producto.pesoProducto('500 mg');*/

            $.getJSON(urlPath + 'Trazabilidad/BuscarProductoTraza?producto=' + self.ProductoBusqueda())
            .done(function (data) {
                if (data.length > 0) {
                    var prod = data[0];
                    self.producto.codigoProducto(prod.codigoProducto);
                    self.producto.nombreProducto(prod.nombreProducto);
                    self.producto.descripcion(prod.descripcion);
                    self.producto.tipoProducto(prod.tipoProducto);
                    self.producto.presentacion(prod.presentacion);
                    self.producto.pesoProducto(prod.pesoProducto);                    

                    //self.productos(data);
                    //$('#modal-productos').modal('show');
                } else if (data.length == 0) {
                    toastr.warning('No hay resultados de la búsqueda');
                }
            }).fail(function () {
                toastr.error('El código no está asociado a ningun producto registrado');
            });

        } else {
            toastr.warning('Ingrese un código de producto para buscar');
        }
    }

    self.Imprimir = function () {

    }

    self.Guardar = function () {
        self.orden.codigoProducto(self.producto.codigoProducto());
        $.ajax({
            type: 'POST',
            url: urlPath + 'Trazabilidad/GuardarOrdenRetiro',
            data: ko.toJSON({ parametro: self.orden }),
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
                if (data.Valor) {
                    toastr.info('Se ha retirado el producto ' + self.producto.Nombre(), 'Procesado');
                }
                else {
                    toastr.warning('No se pudo completar la orden de retiro.', 'Proceso no completado');
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });

    }

    self.Nuevo = function () {
        self.ProductoBusqueda(undefined);
        self.producto.codigoProducto(undefined);
        self.producto.nombreProducto(undefined);
        self.producto.descripcion(undefined);
        self.producto.tipoProducto(undefined);
        self.producto.presentacion(undefined);
        self.producto.pesoProducto(undefined);        
    }
}

$(function () {
    var modelo = new ViewModel();
    ko.applyBindings(modelo);
});


/*
function ViewModel() {
    var self = this;

}

$(function () {
    var modelo = new ViewModel();
    ko.applyBindings(modelo);
});
*/
