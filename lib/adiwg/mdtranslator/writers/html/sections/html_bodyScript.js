if ( typeof L === "object") {
    (function() {
        //forEach Polyfill, Reference: https://goo.gl/hFIfSd
        if (!Array.prototype.forEach) {
            Array.prototype.forEach = function(callback, thisArg) {
                var T, k;
                if (this === null || this === undefined) {
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

        var coordsToLatLng = function(coords) {
          var longitude = coords[0];
          var latitude = coords[1];
          var latlng = L.latLng(latitude, longitude);

          if (longitude < 0) {
            return latlng.wrap(360, 0);
          } else
            return latlng;
        };

        var extentNodeList = document.querySelectorAll('section.extent-section');
        var extents = Array.prototype.slice.call(extentNodeList);

        /*var mqAttr = '<span>Tiles Courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png"></span>';
        var osmAttr = '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>';

        L.TileLayer.OSM = L.TileLayer.extend({
            initialize: function(options) {
                L.TileLayer.prototype.initialize.call(this, 'http://otile{s}.mqcdn.com/tiles/1.0.0/{type}/{z}/{x}/{y}.png', {
                    subdomains: '1234',
                    type: 'osm',
                    attribution: 'Map data ' + osmAttr + ', ' + mqAttr
                });
            }
        });*/

        var check = function(i, me, bnds) {
            if (i < 3) {
                var resize = me.getSize().x === 0 && me.getContainer().offsetWidth > 0;

                me.invalidateSize();
                if (resize) {
                    me.fitBounds(bnds);
                } else {
                    i++;
                    setTimeout(function() {
                        check(i, me, bnds);
                    }, 100);
                }
            }
        };

        extents.forEach(function(extent, idx, arr) {
            var map = L.map(extent.querySelector('div.map'));
            var header = extent.querySelector('summary.map-header');
            var geoNodelist = extent.querySelectorAll('div.geojson');
            var geoArray = Array.prototype.slice.call(geoNodelist);
            var geojson = [];

            geoArray.forEach(function(geo, geoIdx, geoArr) {
                var json = JSON.parse(geo.textContent || geo.innerText);
                var bbox = json.bbox;

                if (!json.properties) {
                    json.properties = {};
                }

                if (json.geometry === null && bbox) {
                    var bcoor;

                    if (!(bbox[0] <= 0 && bbox[2] <= 0) || !(bbox[0] > 0 && bbox[2] > 0)) {
                        //bbox crosses the dateline
                        var bbox0 = bbox[0] < 0 ? L.latLng(0, bbox[0]).wrap(360,0).lng : bbox[0];
                        var bbox2 = bbox[2] < 0 ? L.latLng(0, bbox[2]).wrap(360,0).lng : bbox[2];
                        bbox[0] = Math.min(bbox0, bbox2);
                        bbox[2] = Math.max(bbox0, bbox2);
                    }

                    bcoor = [[[bbox[2], bbox[3]], [bbox[0], bbox[3]], [bbox[0], bbox[1]], [bbox[2], bbox[1]], [bbox[2], bbox[3]]]];

                    json.geometry = {
                        "type": "Polygon",
                        "coordinates": bcoor
                    };
                    json.properties.style = {
                        color: '#f00',
                        fill: false
                    };
                }

                json.properties.popup = geo.getAttribute('data-popup');
                geojson.push(json);
            });

            var geoLayer = L.geoJson(geojson, {
                style: function(feature) {
                    return feature.properties.style || {};
                },
                coordsToLatLng: coordsToLatLng,
                onEachFeature: function (feature, layer) {
                    layer.bindPopup(feature.properties.popup,{
                        closeButton: true
                    });
                }
            }).addTo(map);

            var bnds = geoLayer.getBounds();

            L.DomEvent.addListener(header, 'click', function() {
                var me = this;
                var i = 0;

                setTimeout(function() {
                    check(i, me, bnds);
                }, 100);

            }, map);

            L.DomEvent.addListener(L.DomUtil.get('openAllDetails'), 'click', function() {
                var me = this;
                var i = 0;

                setTimeout(function() {
                    check(i, me, bnds);
                }, 100);

            }, map);

            map.fitBounds(bnds);
            //map.addLayer(new L.TileLayer.OSM());
            var stamen = new L.StamenTileLayer("terrain");
            map.addLayer(stamen);
        });
    })();
}
