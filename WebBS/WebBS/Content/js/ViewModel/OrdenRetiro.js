function Producto(data) {
    if (!data) data = {};
    this.codigoProducto = ko.observable(data.codigoProducto);
    this.nombreProducto = ko.observable(data.nombreProducto);
    this.descripcion = ko.observable(data.descripcion);
    this.tipoProducto = ko.observable(data.tipoProducto);
    this.presentacion = ko.observable(data.presentacion);
    this.pesoProducto = ko.observable(data.pesoProducto);
    this.fecha = ko.observable(data.fecha);
    this.autorizado = ko.observable(data.autorizado);
    this.motivo = ko.observable(data.motivo);
    this.riesgo = ko.observable(data.riesgo);
}

function OrdenRetiro(data) {
    if (!data) data = {};
    this.codigoProducto = ko.observable(data.codigoProducto);
    //this.fecha = ko.observable(data.fecha);
    //this.autorizado = ko.observable(data.autorizado);
    //this.motivo = ko.observable(data.motivo);
    //this.riesgo = ko.observable(data.riesgo);
}

function ViewModel() {
    var self = this;
    //$("#retiroimprimir").hide();
    //self.ProductoBusqueda = ko.observable();
    self.producto = new Producto();
    self.orden = new OrdenRetiro();

    $("#seccionbotonImprimir").hide();

    self.Filtro = {
        CodigoProducto: ko.observable(),
        NombreProducto: ko.observable()
    }
    self.productos = ko.observableArray();



    $("#jmombreproducto").change(function (e) {
        var txt = $(this).val();
        if (txt.trim() == "") {
            self.Filtro.CodigoProducto(undefined);
            self.Filtro.NombreProducto(undefined);
        }
    });

    self.BuscarProducto = function () {
        if (!self.Filtro.NombreProducto()) {
            toastr.warning('Ingrese un nombre de producto para buscar');
            $("#seccionbotonImprimir").hide();
            self.Nuevo();
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



    self.ConsultarOrden = function () {        
        if (self.Filtro.CodigoProducto()) {

            $.getJSON(urlPath + 'Trazabilidad/BuscarProductoTraza?producto=' + self.Filtro.CodigoProducto())
            .done(function (data) {
                if (data.length > 0) {
                    var prod = data[0];
                    self.producto.codigoProducto(prod.codigoProducto);
                    self.producto.nombreProducto(prod.nombreProducto);
                    self.producto.descripcion(prod.descripcion);
                    self.producto.tipoProducto(prod.tipoProducto);
                    self.producto.presentacion(prod.presentacion);
                    self.producto.pesoProducto(prod.pesoProducto);                    
                    self.producto.fecha(undefined);
                    self.producto.autorizado(undefined);
                    self.producto.motivo(undefined);
                    self.producto.riesgo(undefined);
                    //self.productos(data);
                    //$('#modal-productos').modal('show');
                } else {
                    self.Nuevo();
                   
                    toastr.warning('No hay resultados de la búsqueda');
                }
            }).fail(function () {
                toastr.error('El código no está asociado a ningun producto registrado');
            });

        } else {
            toastr.warning('Ingrese un código de producto para buscar');
            self.Nuevo();
        }
    }

    self.Imprimir = function () {
       // ko.ApplyBindings(ViewModel);
        $("#seccionimprimir").printThis();

    }
  

    self.Guardar = function () {
        //self.orden.codigoProducto(self.producto.codigoProducto());
        debugger;
        $.ajax({
            type: 'POST',
            url: urlPath + 'Trazabilidad/GuardarOrdenRetiro',
            data: ko.toJSON({ parametro: self.producto }),
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
                if (data.Valor) {
                    $("#seccionbotonImprimir").show();
                    toastr.success('Se ha registrado la orden del retiro del producto ' + self.producto.nombreProducto(), 'Procesado');                    
                }
                else {
                    toastr.error('No se pudo completar la orden de retiro. El producto ya fue retirado.', 'Proceso no completado');
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });

    }

    self.Nuevo = function () {        
        self.producto.codigoProducto(undefined);
        self.producto.nombreProducto(undefined);
        self.producto.descripcion(undefined);
        self.producto.tipoProducto(undefined);
        self.producto.presentacion(undefined);
        self.producto.pesoProducto(undefined);
        self.producto.fecha(undefined);
        self.producto.autorizado(undefined);
        self.producto.motivo(undefined);
        self.producto.riesgo(undefined);
        $("#seccionbotonImprimir").hide();
    }
}


var modelo
$(function () {
     modelo = new ViewModel();
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
