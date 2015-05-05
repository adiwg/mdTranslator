if ( typeof L === "object") {
    (function() {
        //forEach Polyfill
        // Reference:
        // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach
        if (!Array.prototype.forEach) {
            Array.prototype.forEach = function(callback, thisArg) {
                var T, k;
                if (this == null) {
                    throw new TypeError(' this is null or not defined');
                }
                var O = Object(this);
                var len = O.length >>> 0;
                if ( typeof callback !== "function") {
                    throw new TypeError(callback + ' is not a function');
                }
                if (arguments.length > 1) {
                    T = thisArg;
                }
                k = 0;
                while (k < len) {
                    var kValue;
                    if ( k in O) {
                        kValue = O[k];

                        callback.call(T, kValue, k, O);
                    }
                    k++;
                }
            };
        }

        var extentNodeList = document.querySelectorAll('section.extent-section');
        var extents = Array.prototype.slice.call(extentNodeList);

        var mqAttr = '<p>Tiles Courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png"></p>';
        var osmAttr = '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>';

        L.TileLayer.OSM = L.TileLayer.extend({
            initialize: function(options) {
                L.TileLayer.prototype.initialize.call(this, 'http://otile{s}.mqcdn.com/tiles/1.0.0/{type}/{z}/{x}/{y}.png', {
                    subdomains: '1234',
                    type: 'osm',
                    attribution: 'Map data ' + osmAttr + ', ' + mqAttr
                });
            }
        });

        var check = function(i, me) {
            if (i < 3) {
                var resize = me.getSize().x === 0 && me.getContainer().offsetWidth > 0;
                console.info('norez');

                me.invalidateSize();
                if (resize) {
                    console.info('rez');
                    me.setView([0, 0], 2);
                } else {
                    i++;
                    setTimeout(function() {
                        check(i, me);
                    }, 100);
                }
            }
        };

        extents.forEach(function(extent, idx, arr) {
            var map = L.map(extent.querySelector('div.map'));
            var header = extent.querySelector('summary.map-header');

            L.DomEvent.addListener(header, 'click', function() {
                var me = this;
                var i = 0;

                //if (resize) {
                setTimeout(function() {
                    check(i, me);
                }, 100);
                //}
            }, map);

            console.info( map1 = map);
            map.setView([0, 0], 2);
            map.addLayer(new L.TileLayer.OSM());
        });
    })();
}