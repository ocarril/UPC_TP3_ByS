
//------------------------------------- LOCAL STORAGE -------------------------------------

(function ($) {
    $.f_localStorageSupport = function () {
        try {
            return 'localStorage' in window && window['localStorage'] !== null;
        }
        catch (e) {
            return false;
        }
    }
})(jQuery);

(function ($) {
    $.f_localStorage_set = function (key, value) {
        f_localStorage_remove(key);
        window.localStorage.setItem(key, value);
    }
})(jQuery);

(function ($) {
    $.f_localStorage_get = function (key) {
        return window.localStorage.getItem(key);
    }
})(jQuery);

(function ($) {
    $.f_localStorage_remove = function (key) {
        var val = f_localStorage_get(key);

        if (val != null)
            window.localStorage.removeItem(key);
    }
})(jQuery);

(function ($) {
    $.f_localStorage_clear = function () {
        window.localStorage.clear();
    }
})(jQuery);

(function ($) {
    $.f_localStorage_length = function () {
        return window.localStorage.length;
    }
})(jQuery);

//----------------------------------------------------------------------------------------

