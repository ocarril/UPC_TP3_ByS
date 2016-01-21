ko.bindingHandlers.dateTimePicker = {
    init: function (element, valueAccessor, allBindingsAccessor) {
        //initialize datepicker with some optional options
        var options = allBindingsAccessor().dateTimePickerOptions || {};
        $(element).datetimepicker(options);

        //when a user changes the date, update the view model
        ko.utils.registerEventHandler(element, "dp.change", function (event) {
            var value = valueAccessor();
            if (ko.isObservable(value)) {                
                if (event.date && event.date != null && !(event.date instanceof Date)) {
                    value(event.date.toDate());
                } else {
                    //value(event.date);
                    value(undefined);                    
                }
            }
            //console.log(event, options);            
        });

        ko.utils.domNodeDisposal.addDisposeCallback(element, function () {
            var picker = $(element).data("DateTimePicker");
            if (picker) {
                picker.destroy();
            }
        });
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var picker = $(element).data("DateTimePicker");
        //when the view model is updated, update the widget
        if (picker) {
            var koDate = ko.utils.unwrapObservable(valueAccessor());            
            //in case return from server datetime i am get in this form for example /Date(93989393)/ then format this
            //koDate = (typeof (koDate) !== 'object') ? new Date(parseFloat((koDate || '').toString().replace(/[^0-9]/g, ''))) : koDate;            
            if (typeof (koDate) !== 'object') {
                if (/\/Date\((-?\d+)\)\//.test(koDate)) {
                    koDate = new Date(parseFloat((koDate || '').toString().replace(/[^0-9]/g, '')));
                }
                else if (/^(\d{4})(?:-?W(\d+)(?:-?(\d+)D?)?|(?:-(\d+))?-(\d+))(?:[T ](\d+):(\d+)(?::(\d+)(?:\.(\d+))?)?)?(?:Z(-?\d*))?$/.test(koDate)) {
                    koDate = new Date(koDate);
                }
                else if (/\d{2}\/\d{2}\/\d{4}/.test(koDate)) {
                    var r = /(\d{2}\/\d{2}\/\d{4})\s?(\d{1,2}:\d{2})?\s?(am|AM|pm|PM)?/gi.exec(koDate);
                    var t = r[1].split('/');
                    koDate = new Date(t[2], t[1] - 1, t[0]);

                    //Hora
                    if (r[2]) {
                        var h = r[2].split(':');
                        if (r[3]) {
                            var tt = r[3].toUpperCase();
                            h[0] = (tt == 'PM' && h[0] < 12) ? h[0] * 1 + 12 : h[0];
                        }
                        koDate.setHours(h[0], h[1]);
                    }
                }
            }            

            picker.date(koDate || null);
        }
    }
};