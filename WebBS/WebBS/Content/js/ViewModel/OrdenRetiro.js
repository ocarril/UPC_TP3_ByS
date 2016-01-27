function ViewModel() {
    var self = this;

}

$(function () {
    var modelo = new ViewModel();
    ko.applyBindings(modelo);
});