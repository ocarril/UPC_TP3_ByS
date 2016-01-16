function NotaIngreso(data) {
    var self = this;
    if (!data) data = {};
    self.NumeroNotaIngreso = ko.observable(data.NumeroNotaIngreso);
    self.Fecha = ko.observable(data.Fecha);
    self.NumeroOrdenCompra = ko.observable(data.NumeroOrdenCompra);
    self.UsuarioRecibo = ko.observable(data.UsuarioRecibo);
    self.idAlmacen = ko.observable(data.idAlmacen);
    self.GuiaRemsion = ko.observable(data.GuiaRemsion);
    self.Observaciones = ko.observable(data.Observaciones);
    self.DetalleNotaIngreso = ko.observableArray(data.DetalleNotaIngreso);
}

function DetalleNotaIngreso(data) {
    var self = this;
    if (!data) data = {};
    self.NumeroNotaIngreso = ko.observable(data.NumeroNotaIngreso);
    self.IdProducto = ko.observable(data.IdProducto);
    self.Producto = ko.observable(data.Producto);
    self.Cantidad = ko.observable(data.Cantidad);
    self.UnidadMedida = ko.observable(data.UnidadMedida);
    self.Observaciones = ko.observable(data.Observaciones);
}

function ViewModel() {
    var self = this;

    self.notas = ko.observableArray();
    self.almacenes = ko.observableArray();
    self.NotaIngreso = new NotaIngreso();
    self.NuevoItem = new DetalleNotaIngreso();    

    self.NuevaNota = function () {
        self.NotaIngreso.NumeroNotaIngreso(undefined);
        self.NotaIngreso.Fecha(util.date.format(new Date(), 'dd/MM/yyyy'));
        self.NotaIngreso.NumeroOrdenCompra(undefined);
        self.NotaIngreso.UsuarioRecibo(undefined);
        self.NotaIngreso.idAlmacen(undefined);
        self.NotaIngreso.GuiaRemsion(undefined);
        self.NotaIngreso.Observaciones(undefined);
        self.NotaIngreso.DetalleNotaIngreso.removeAll();
        $.getJSON(urlPath + 'NotaIngreso/ListarAlmacenes', function (data) { self.almacenes(data); }, 'json');
        $('#modal-nota').modal('show');
    }

    self.VerDetalleNota = function (data) {        
        self.NotaIngreso.NumeroNotaIngreso(data.NumeroNotaIngreso);
        self.NotaIngreso.Fecha(util.date.format(data.Fecha, 'dd/MM/yyyy'));
        self.NotaIngreso.NumeroOrdenCompra(data.NumeroOrdenCompra);
        self.NotaIngreso.UsuarioRecibo(data.UsuarioRecibo);
        self.NotaIngreso.idAlmacen(data.idAlmacen);
        self.NotaIngreso.GuiaRemsion(data.GuiaRemsion);
        self.NotaIngreso.Observaciones(data.Observaciones);

        $.ajax({
            type: 'POST',
            url: urlPath + 'NotaIngreso/DetalleNotaIngreso',
            data: ko.toJSON({ NumeroNotaIngreso: data.NumeroNotaIngreso }),
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
                //console.log(data);
                self.almacenes(data.Almacenes);
                self.NotaIngreso.DetalleNotaIngreso(data.Detalle.map(function (x) { return new DetalleNotaIngreso(x) }));
            }
        });

        $('#modal-nota').modal('show');
    }

    self.EditarNota = function (data) {

    }

    self.EliminarNota = function (nota) {
        if (!confirm('¿Desea eliminar la Nota de Ingreso?')) {
            return;
        }

        $.ajax({
            type: 'POST',
            url: urlPath + 'NotaIngreso/EliminarNota',
            data: ko.toJSON({ NumeroNotaIngreso: nota.NumeroNotaIngreso }),
            dataType: 'json',
            contentType: 'application/json',
            success: function (data) {
                self.notas.remove(nota);
                toastr.warning('Se ha eliminado la Nota de Ingreso');
            },
            error: function (dataError) {
                console.log(dataError);
            }
        });
    }

    self.AgregarItem = function () {
        self.NuevoItem.NumeroNotaIngreso(self.NotaIngreso.NumeroNotaIngreso());
        self.NuevoItem.IdProducto(undefined);
        self.NuevoItem.Producto(undefined);
        self.NuevoItem.Cantidad(undefined);
        self.NuevoItem.UnidadMedida(undefined);
        self.NuevoItem.Observaciones(undefined);
        $('#modal-item').modal('show');
    }

    self.GuardarNuevoItem = function () {
        if (!self.NuevoItem.Producto() && !self.NuevoItem.Cantidad()) {
            toastr.error('Ingrese producto y cantidad', 'Faltan datos');
            return;
        }
        var item = ko.toJS(self.NuevoItem);
        var obj = ko.utils.arrayFirst(self.NotaIngreso.DetalleNotaIngreso(), function (x) { return x.IdProducto() == item.IdProducto });
        if (obj == null) {
            self.NotaIngreso.DetalleNotaIngreso.push(new DetalleNotaIngreso(item));
            $('#modal-item').modal('hide');
        } else {
            toastr.warning('El item ya existe en la lista');
        }        
    }

    self.EliminarItem = function (data) {
        self.NotaIngreso.DetalleNotaIngreso.remove(data);
    }

    self.BuscarProducto = function () {
        if (!self.NuevoItem.IdProducto()) {
            toastr.warning('Ingrese un código de producto');
            return;
        }

        self.NuevoItem.Producto(undefined);
        self.NuevoItem.UnidadMedida(undefined);

        $.getJSON(urlPath + 'Producto/BuscarPorId?IdProducto=' + self.NuevoItem.IdProducto())
        .done(function (data) {
            self.NuevoItem.Producto(data.Descripcion);
            self.NuevoItem.UnidadMedida(data.UnidadMedida);
        }).fail(function () {
            toastr.warning('El producto no existe');
        });
    }

    self.Guardar = function () {
        var nota = ko.toJS(self.NotaIngreso);

        if (nota.DetalleNotaIngreso.length == 0) {
            toastr.warning('Ingrese productos para guardar la Nota de Ingreso', 'Productos');
            return;
        }
        
        $.ajax({
            type: 'POST',
            url: urlPath + 'NotaIngreso/GuardarNota',
            data: ko.toJSON({ nota: nota }),
            //dataType: 'json', //No se coloca ya que va a retornar un string
            contentType: 'application/json',
            success: function (data) {                                
                if (!nota.NumeroNotaIngreso) {
                    nota.NumeroNotaIngreso = data;
                    self.notas.push(nota);
                }
                else {                    
                    var obj = ko.utils.arrayFirst(self.notas(), function (item) { return item.NumeroNotaIngreso == nota.NumeroNotaIngreso });
                    if (obj != null) {
                        self.notas.replace(obj, nota);
                    }
                }
                self.NotaIngreso.NumeroNotaIngreso(data);
                $('#modal-nota').modal('hide');
                toastr.success('Se ha guardado correctamente la Nota de Ingreso');
            }, error: function (dataError) {
                console.log(dataError);
            }
        });
    }

    self.FiltroBusqueda = {
        FechaInicio: ko.observable(),
        FechaFin: ko.observable(),
        NumeroNotaIngreso: ko.observable(),
        Proveedor: ko.observable()
    }

    self.BuscarNotaIngreso = function () {
        var params = {
            FechaInicio: self.FiltroBusqueda.FechaInicio() || '',
            FechaFin: self.FiltroBusqueda.FechaFin() || '',
            NumeroNotaIngreso: self.FiltroBusqueda.NumeroNotaIngreso() || null,
            Proveedor: self.FiltroBusqueda.Proveedor() || ''
        };

        //console.log(params);

        $.ajax({
            type: "POST",
            url: urlPath + 'NotaIngreso/FiltrarNotaIngreso',
            data: ko.toJSON(params),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                self.notas(data); //Put the response in ObservableArray
            },
            error: function (err) {
                //alert(err.status + " : " + err.statusText);
                console.log(err);
            }
        });
    }

    self.init = function () {        
        self.BuscarNotaIngreso();
    }
}

$(function () {
    var modelo = new ViewModel();
    ko.applyBindings(modelo);
    modelo.init();
});