//function Pedido(data) {
//    var self = this;
//    if (!data) data = {};
//    self.Pedido = ko.observable(data.Pedido);
//    self.Sucursal = ko.observable(data.Sucursal);
//    self.Estado = ko.observable(data.Estado);
//}

function Picking(data) {
    var self = this;
    if (!data) data = {};
    self.NumeroPicking = ko.observable(data.NumeroPicking);
    self.FechaEntrega = ko.observable(data.FechaEntrega);
    self.IdResponsable = ko.observable(data.IdResponsable);
    self.Pedidos = ko.observableArray(data.Pedidos);
}

function ViewModel() {
    var self = this;

    self.picking = new Picking();
    self.responsables = ko.observableArray();
    self.pedidos = ko.observableArray();
    self.sucursales = ko.observableArray();
    self.FiltroPedido = {
        Inicio: ko.observable(),
        Fin: ko.observable(),
        Sucursal: ko.observable()
    };

    self.SeleccionarFila = function (data) {
        data.Seleccionado(!data.Seleccionado());
    }

    self.SeleccionarPedidos = function () {
        //var seleccionados = self.pedidos().filter(function (item) { return item.Seleccionado() });
        //if (seleccionados.length > 0) {
        //    var ids = seleccionados.map(function (x) { return x.Pedido }).join(', ')
        //    toastr.success('Se han seleccionados los pedidos ' + ids, seleccionados.length + ' seleccionados');
        //}
        //else {
        //    toastr.warning('No hay pedidos seleccionados');
        //}
        var sucursales = self.pedidos().map(function (x) { return x.Sucursal });
        self.sucursales(util.array.distinct(sucursales));
        $('#modal-seleccionar-pedidos').modal('show');
    }

    self.ContarSeleccionados = ko.computed(function () {
        var seleccionados = self.pedidos().filter(function (item) { return item.Seleccionado() });
        return seleccionados.length + ' seleccionados';
    });

    self.FiltrarPedidos = function () {
        var inicio = self.FiltroPedido.Inicio(), 
            fin = self.FiltroPedido.Fin(),
            sucursal = self.FiltroPedido.Sucursal();

        self.pedidos().map(function (x) {
            var logic = (((!inicio || x.Pedido >= inicio) && (!fin || x.Pedido <= fin)) &&
                        (!sucursal || x.Sucursal == sucursal));
            x.Seleccionado(logic);
        });
        $('#modal-seleccionar-pedidos').modal('hide');
    }

    self.Listar = function () {
        toastr.info('Verificar la lista de picking');
    }

    self.Grabar = function () {
        var seleccionados = self.pedidos().filter(function (item) { return item.Seleccionado() });
        if (seleccionados.length > 0) {
            self.picking.Pedidos(seleccionados);

            //Cambiamos de estado
            seleccionados.map(function (item) { item.Estado('Abierto') });
            toastr.info('Se ha grabado el picking, verifique la consola presionando F12', 'Guardado');
            console.log(ko.toJSON(self.picking), 'JSON');
        } else {
            toastr.warning('No ha seleccionado ningun registro', 'Seleccione');
        }        
    }

    self.Salir = function () {
        toastr.error('Salir de la opción', 'Salir');
    }

    self.init = function () {
        //Responsables
        self.responsables([
            { IdPersona: 1, Nombre: 'Mario Arce' },
            { IdPersona: 2, Nombre: 'Juan Mallqui' }
        ]);

        //Pedidos
        var pedidos = [
            { Pedido: 200, Sucursal: 'San Felipe', Estado: 'Creado' },
            { Pedido: 201, Sucursal: 'Arequipa', Estado: 'Creado' },
            { Pedido: 202, Sucursal: 'Javier Prado', Estado: 'Creado' },
            { Pedido: 203, Sucursal: 'Salaverry', Estado: 'Creado' },
            { Pedido: 204, Sucursal: 'Arequipa', Estado: 'Creado' }
        ];

        pedidos = pedidos.map(function (item) {
            item.Estado = ko.observable(item.Estado);
            item.Seleccionado = ko.observable(false);
            return item;
        });

        self.pedidos(pedidos);
    }
}

$(function () {
    var modelo = new ViewModel();
    ko.applyBindings(modelo);
    modelo.init();
});