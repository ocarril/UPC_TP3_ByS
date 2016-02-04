function Producto(data) {
    var self = this;
    if (!data) data = {};
    self.codigoFichaTecProducto = ko.observable(data.codigoFichaTecProducto);
    self.nombre = ko.observable(data.nombre);
    self.descripcion = ko.observable(data.descripcion);
    self.etiquetado = ko.observable(data.etiquetado);
    self.procedimientoAlmacen = ko.observable(data.procedimientoAlmacen);
    self.procedimientoVenta = ko.observable(data.procedimientoVenta);
    self.procedimiemtoDistribucion = ko.observable(data.procedimiemtoDistribucion);
    self.posologia = ko.observable(data.posologia);
    self.quimicoFarmaceutico = ko.observable(data.quimicoFarmaceutico);
    self.aprobar = ko.observable(data.aprobar);
    self.codigoProcedimiento = ko.observable(data.codigoProcedimiento);
    self.codigoFichaTecProveedor = ko.observable(data.codigoFichaTecProveedor);
}

function ViewModel() {
    var self = this;

    
    self.FichaProducto = new Producto();
    self.FichaEditar = new Producto();

  

    self.Filtro = {
        CodigoProducto: ko.observable(),
        NombreProducto: ko.observable()
    }
  
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

    self.ConsultarFicha = function () {
        if (!self.Filtro.CodigoProducto()) {
            toastr.warning('Ingrese un producto para buscar');
            return;
        }

        $.getJSON(urlPath + 'Trazabilidad/FichaTecnicaFarmacia?producto=' + self.Filtro.CodigoProducto())
            .done(function (data) {                
                if (data.length == 1) {
                    self.FichaProducto.nombre(data[0].nombre);
                    self.FichaProducto.descripcion(data[0].descripcion);
                    self.FichaProducto.etiquetado(data[0].etiquetado);
                    self.FichaProducto.procedimientoAlmacen(data[0].procedimientoAlmacen);
                    self.FichaProducto.procedimientoVenta(data[0].procedimientoVenta);
                    self.FichaProducto.procedimiemtoDistribucion(data[0].procedimiemtoDistribucion);
                    self.FichaProducto.posologia(data[0].posologia);
                    self.FichaProducto.quimicoFarmaceutico(data[0].quimicoFarmaceutico);
                    self.FichaProducto.aprobar(data[0].aprobar);
                    self.FichaProducto.codigoProcedimiento(data[0].codigoProcedimiento);
                    self.FichaProducto.codigoFichaTecProveedor(data[0].codigoFichaTecProveedor);
                    toastr.info('Se encontró "' + data[0].nombre + '"');
                } else if (data.length > 1) {
                    //self.productos(data);
                    //$('#modal-productos').modal('show');
                } else if (data.length == 0) {
                    toastr.warning('No hay resultados de la búsqueda');
                    self.LimpiarPantalla();
                }
            }).fail(function () {
                toastr.error('El código no está asociado a ningun producto registrado');
            });
    }

    //self.SeleccionarProducto = function (data) {
    //    self.FichaProducto.nombre(data.nombre);
    //    self.FichaProducto.descripcion(data.descripcion);
    //    self.FichaProducto.etiquetado(data.etiquetado);
    //    self.FichaProducto.procedimientoAlmacen(data.procedimientoAlmacen);
    //    self.FichaProducto.procedimientoVenta(data.procedimientoVenta);
    //    self.FichaProducto.procedimiemtoDistribucion(data.procedimiemtoDistribucion);
    //    self.FichaProducto.posologia(data.posologia);
    //    self.FichaProducto.quimicoFarmaceutico(data.quimicoFarmaceutico);
    //    self.FichaProducto.aprobar(data.aprobar);
    //    self.FichaProducto.codigoProcedimiento(data.codigoProcedimiento);
    //    self.FichaProducto.codigoFichaTecProveedor(data.codigoFichaTecProveedor);
    //    $('#modal-productos').modal('hide');
    //}

    self.AbrirModalActualizar = function () {
        var data = ko.toJS(self.FichaProducto);
        self.FichaEditar.codigoFichaTecProducto(data.codigoFichaTecProducto);
        self.FichaEditar.nombre(data.nombre);
        self.FichaEditar.descripcion(data.descripcion);
        self.FichaEditar.etiquetado(data.etiquetado);
        self.FichaEditar.procedimientoAlmacen(data.procedimientoAlmacen);
        self.FichaEditar.procedimientoVenta(data.procedimientoVenta);
        self.FichaEditar.procedimiemtoDistribucion(data.procedimiemtoDistribucion);
        self.FichaEditar.posologia(data.posologia);
        self.FichaEditar.quimicoFarmaceutico(data.quimicoFarmaceutico);
        self.FichaEditar.aprobar(data.aprobar);
        self.FichaEditar.codigoProcedimiento(data.codigoProcedimiento);
        self.FichaEditar.codigoFichaTecProveedor(data.codigoFichaTecProveedor);
        $('#modal-actualizar').modal('show');
    }

    self.GuardarFicha = function () {
        var data = ko.toJS(self.FichaEditar);
        $.post(urlPath + 'Trazabilidad/ActualizarFichaTecnica', { ficha: data })
          .done(function (codigo) {
              //console.log(codigo);
              self.FichaProducto.codigoFichaTecProducto(data.codigoFichaTecProducto);
              self.FichaProducto.nombre(data.nombre);
              self.FichaProducto.descripcion(data.descripcion);
              self.FichaProducto.etiquetado(data.etiquetado);
              self.FichaProducto.procedimientoAlmacen(data.procedimientoAlmacen);
              self.FichaProducto.procedimientoVenta(data.procedimientoVenta);
              self.FichaProducto.procedimiemtoDistribucion(data.procedimiemtoDistribucion);
              self.FichaProducto.posologia(data.posologia);
              self.FichaProducto.quimicoFarmaceutico(data.quimicoFarmaceutico);
              self.FichaProducto.aprobar(data.aprobar);
              self.FichaProducto.codigoProcedimiento(data.codigoProcedimiento);
              self.FichaProducto.codigoFichaTecProveedor(data.codigoFichaTecProveedor);

              toastr.info('Se guardaron cambios', 'Ficha de producto');
              $('#modal-actualizar').modal('hide');
          }).fail(function (dataError) {
              console.log(dataError);
              toastr.error('No se pudo actualizar la ficha técnica');
          });
    }

    self.ImprimirFicha = function () {        
        $("#ficha-tecnica").printThis();
    }

    self.LimpiarPantalla = function () {
        self.FichaProducto.codigoFichaTecProducto(undefined);
        self.FichaProducto.nombre(undefined);
        self.FichaProducto.descripcion(undefined);
        self.FichaProducto.etiquetado(undefined);
        self.FichaProducto.procedimientoAlmacen(undefined);
        self.FichaProducto.procedimientoVenta(undefined);
        self.FichaProducto.procedimiemtoDistribucion(undefined);
        self.FichaProducto.posologia(undefined);
        self.FichaProducto.quimicoFarmaceutico(undefined);
        self.FichaProducto.aprobar(undefined);
        self.FichaProducto.codigoProcedimiento(undefined);
        self.FichaProducto.codigoFichaTecProveedor(undefined);
    }
}
var modelo;
$(function () {
     modelo = new ViewModel();
    ko.applyBindings(modelo);
});

