function Pedido(data) {
    var self = this;
    if (!data) data = {};
    self.NumeroPedido = ko.observable(data.NumeroPedido);
    self.Fecha = ko.observable(data.Fecha);
    self.Sucursal = ko.observable(data.Sucursal);
    self.Estado = ko.observable(data.Estado);
    self.DireccionEntrega = ko.observable(data.DireccionEntrega);
    self.Productos = ko.observableArray(data.Productos);
    self.Seleccionado = ko.observable(false);
}

function Producto(data) {
    var self = this;
    if (!data) data = {};
    self.IdProducto = ko.observable(data.IdProducto);
    self.Descripcion = ko.observable(data.Descripcion);
    self.UnidadMedida = ko.observable(data.UnidadMedida);
    self.Ubicacion = ko.observable(data.Ubicacion);
    self.Stock = ko.observable(data.Stock);
    self.Cantidad = ko.observable(data.Cantidad || 0);
    self.Atendido = ko.observable(data.Atendido || 0);
    self.Saldo = ko.observable(data.Saldo || self.Cantidad() - self.Atendido());
    self.Atendido.subscribe(function (newValue) {
        self.Saldo(self.Cantidad() - self.Atendido());
    });    
    self.Seleccionado = ko.observable(false);

}

function ViewModel() {
    var self = this;
    
    self.pedidos = ko.observableArray();
    self.DetallePedido = new Pedido();
    self.DetalleProducto = new Producto();
    self.ProductoExistencias = new Producto();
    self.PedidoBuscar = ko.observable();

    self.ConsultarPedidos = function () {                
        $.ajax({
            type: 'POST',
            url: urlPath + 'Picking/ListarPedidos',
            data: ko.toJSON({ param: self.PedidoBuscar() || '' }),
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                //console.log(response);
                var pedidos = response.map(function (item) {
                    switch (item.Estado) {
                        case 1: item.Estado = 'Pendiente'; break;
                        case 2: item.Estado = 'En proceso'; break;
                        case 3: item.Estado = 'Atendido'; break;
                    }
                    return new Pedido(item);
                });
                
                self.pedidos(pedidos);
            },
            error: function (dataError) {
                console.log(dataError.responseText);                
            }
        });
    }

    self.SeleccionarPedido = function (data) {        
        self.pedidos().map(function (x) { x.Seleccionado(false) });
        data.Seleccionado(!data.Seleccionado());
    }

    self.VerPedido = function () {
        var obj = ko.utils.arrayFirst(self.pedidos(), function (item) { return item.Seleccionado() });
        if (obj != null) {
            self.DetallePedido.NumeroPedido(obj.NumeroPedido());
            self.DetallePedido.Fecha(obj.Fecha());
            self.DetallePedido.Sucursal(obj.Sucursal());
            self.DetallePedido.Estado(obj.Estado());
            self.DetallePedido.DireccionEntrega(obj.DireccionEntrega());

            self.DetallePedido.Productos.removeAll();
            $.ajax({
                type: 'POST',
                url: urlPath + 'Picking/DetallePedido',
                data: JSON.stringify({ NumeroPedido: obj.NumeroPedido() }),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (data) {                    
                    var productos = data.map(function (p) { return new Producto(p) });
                    self.DetallePedido.Productos(productos);                   
                },
                error: function (dataError) {
                    console.log(dataError.responseText);
                }
            });

            $('#modal-detalle-pedido').modal('show');
        }
        else {
            toastr.warning('Seleccione un pedido por lo menos', 'Seleccione');
        }        
    }

    self.SeleccionarProducto = function (data) {
        self.DetallePedido.Productos().map(function (x) { x.Seleccionado(false) });
        data.Seleccionado(!data.Seleccionado());
    }

    self.VerProducto = function () {
        var obj = ko.utils.arrayFirst(self.DetallePedido.Productos(), function (item) { return item.Seleccionado() });        
        if (obj != null) {
            //Buscar detalles de la base de datos
            self.DetalleProducto.IdProducto(obj.IdProducto());
            self.DetalleProducto.Descripcion(obj.Descripcion());
            self.DetalleProducto.UnidadMedida(obj.UnidadMedida());
            self.DetalleProducto.Ubicacion('');
            self.DetalleProducto.Cantidad(obj.Cantidad());
            self.DetalleProducto.Saldo(obj.Saldo());
            self.DetalleProducto.Atendido(obj.Atendido());

            //Extraemos la posición del artículo
            $.ajax({
                type: 'POST',
                url: urlPath + 'Producto/ConsultarUbicacion',
                data: JSON.stringify({ IdProducto: obj.IdProducto() }),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (data) {
                    var ubicacion = data.map(function (u) {
                        return 'Almacén: ' + u.Almacen + ', ' +
                               'Fila: ' + u.Fila + ', ' +
                               'Columna: ' + u.Columna + ', ' +
                               'Nivel: ' + u.Nivel + ', ' +
                               'Posición: ' + u.Posicion;
                    });
                    self.DetalleProducto.Ubicacion(ubicacion);
                },
                error: function (dataError) {
                    console.log(dataError.responseText);
                }
            });

            $('#modal-detalle-producto').modal('show');
        } else {
            toastr.warning('Seleccione un producto', 'Seleccione');
        }
    }

    self.ConsultarStock = function () {
        self.ProductoExistencias.Descripcion(self.DetalleProducto.Descripcion());
        self.ProductoExistencias.UnidadMedida(self.DetalleProducto.UnidadMedida());        
        $.post(urlPath + 'Producto/ConsultarStock',
            { IdProducto: self.DetalleProducto.IdProducto() }, function (data) {
                self.ProductoExistencias.Stock(data || 0);
                $('#modal-stock').modal('show');
            }, 'json');                
    }

    self.RegistrarCantidad = function () {
        var atendido = self.DetalleProducto.Atendido();
        var obj = ko.utils.arrayFirst(self.DetallePedido.Productos(), function (item) { return item.Seleccionado() });
        if (self.DetalleProducto.Saldo() < 0) {
            toastr.error('La cantidad a atender excede la cantidad pedida');
            return;
        }
        obj.Atendido(atendido);
        $('#modal-detalle-producto').modal('hide');
    }

    self.CerrarPedido = function () {
        if (self.DetallePedido.Productos().length == 0) {
            toastr.error('No hay productos en el pedido, no se puede proceder');
            return;
        }

        if (!confirm('¿Desea cerrar el pedido?')) return;

        var obj = ko.utils.arrayFirst(self.pedidos(), function (item) { return item.Seleccionado() });
        var detalle = ko.toJS(self.DetallePedido.Productos())
            .map(function (p) {
                return {
                    IdProducto: p.IdProducto,
                    Cantidad: p.Atendido
                }
            });

        //console.log(detalle);

        $.post(urlPath + 'Picking/CerrarPedido',
            { NumeroPedido: obj.NumeroPedido(), Detalle: detalle },
            function (data) {
                obj.Estado('Atendido');
                toastr.info('Se ha cerrado el pedido con la Nota de Salida N° ' + data, 'Pedido Atendido');
                $('#modal-detalle-pedido').modal('hide');
            });
    }

    self.init = function () {
        self.ConsultarPedidos();
    }
}

$(function () {
    var modelo = new ViewModel();
    ko.applyBindings(modelo);
    modelo.init();    
});