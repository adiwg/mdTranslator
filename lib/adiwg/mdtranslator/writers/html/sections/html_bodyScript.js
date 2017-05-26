
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

// open detail panel in the document
function openDetail(evt) {
   var href = evt.target.getAttribute("href");
   href = href.slice(1);

   if(window.location !== window.parent.location){
     evt.preventDefault();
     var el = document.getElementById(href);
     window.scrollTo(0, el.offsetTop);
   }
   var parentNode = document.getElementById(href).parentNode;
   parentNode.open = true;
}

// open all detail panels in the document
function openAllDetails(evt) {
  if(window.location !== window.parent.location){
    evt.preventDefault();
  }
   var arr = document.getElementsByTagName("details");
   var len = arr.length;

   for (var i = 0; i < len; i++) {
      arr[i].open = true;
   }
}

// close all detail panels in the document
function closeAllDetails(evt) {
  if(window.location !== window.parent.location){
    evt.preventDefault();
  }
   var arr = document.getElementsByTagName("details");
   var len = arr.length;

   for (var i = 0; i < len; i++) {
      arr[i].open = false;
   }
}

// add event listeners to all anchor buttons in the sideNav
var navBtnList = document.querySelectorAll('a.navBtn');
var navBtnArray = Array.prototype.slice.call(navBtnList);
navBtnArray.forEach(function(btn, btnIdx, btnArr) {
   var href = btn.getAttribute("href").slice(1);
   var target = document.getElementById(href);
   //hide button if target is not present
   if(target) {
     btn.addEventListener("click", openDetail, false);
   } else {
     btn.style.display = 'none';
   }
});

// add event listener to openAllButton
var elOpen = document.getElementById("openAllButton");
elOpen.addEventListener("click", openAllDetails, false);

// add event listener to closeAllButton
var elClose = document.getElementById("closeAllButton");
elClose.addEventListener("click", closeAllDetails, false);

//replace top links in inframes
if(window.location !== window.parent.location){
  // add event listeners to all "top" links
  var topList = document.querySelectorAll("a[href='#']");
  var topArray = Array.prototype.slice.call(topList);
  topArray.forEach(function(a) {
      a.addEventListener("click", function(evt) {
        evt.preventDefault();
        window.scrollTo(0,0);
      }, false);
  });
}

if ( typeof L === "object") {
   (function() {

      var westBound;
      var eastBound;

      var coordsToLatLng = function(coords) {
         // if computed bounding box spans the antimeridian
         // add 360 to negative longitudes
         var longitude = coords[0];
         if (westBound >= 0 && eastBound < 0) {
            if (longitude < 0) {
               longitude += 360;
            }
         }
         var latitude = coords[1];
         return L.latLng(latitude, longitude);
      };

      var bbox2Poly = function(bbox) {
         var bboxJson = JSON.parse(bbox.textContent || bbox.innerText);
         var sw = [ bboxJson.westLongitude, bboxJson.southLatitude ];
         var nw = [ bboxJson.westLongitude, bboxJson.northLatitude ];
         var ne = [ bboxJson.eastLongitude, bboxJson.northLatitude ];
         var se = [ bboxJson.eastLongitude, bboxJson.southLatitude ];
         var coords = [];
         coords.push(sw);
         coords.push(nw);
         coords.push(ne);
         coords.push(se);
         var bboxCoods = [];
         bboxCoods.push(coords);
         return bboxCoods;
      };

      // collect all geographicExtents sections in document
      var geoExtentNodeList = document.querySelectorAll('section.extent-geographic');
      var geoExtents = Array.prototype.slice.call(geoExtentNodeList);

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

      geoExtents.forEach(function(geoExtent, idx, arr) {
         // instantiate a leaflet map in the map div
         var map = L.map(geoExtent.querySelector('div.map'), {noWrap: true});
         // get a pointer to the map header switch
         var header = geoExtent.querySelector('summary.map-summary');
         // get the GeoJSON from the geojson div
         var geoJsonDiv  = geoExtent.querySelector('div.geojson');
         var geojson = JSON.parse(geoJsonDiv.textContent || geoJsonDiv.innerText);
         // get the user provided bounding box for the extent - if any
         var userBBox = geoExtent.querySelector('div.userBBox');
         if (userBBox) {
            var userCoords = bbox2Poly(userBBox);
            var newUserBBox = {
               "type": "Feature",
               "geometry": {
                  "type": "Polygon",
                  "coordinates": userCoords
               },
               "properties": {
                  "style": {
                     "color": '#f00',
                     "fill": false
                  },
                  "featureName": [
                     "User BBOX"
                  ]
               }
            };
            geojson.push(newUserBBox);
         }

         // get the computed bounding box for the extent - always one
         var computedBBox = geoExtent.querySelector('div.computedBBox');
         if (computedBBox) {
            var compCoords = bbox2Poly(computedBBox);
            var newCompBBox = {
               "type": "Feature",
               "geometry": {
                  "type": "Polygon",
                  "coordinates": compCoords
               },
               "properties": {
                  "style": {
                     "color": '#0f0',
                     "fill": false
                  },
                  "featureName": [
                     "Computed BBOX"
                  ]
               }
            };
            geojson.push(newCompBBox);
            westBound = compCoords[0][0][0];
            eastBound = compCoords[0][2][0];
         }

         var pointCnt = 0;
         var lineStringCnt = 0;
         var polygonCnt = 0;
         var geoCollectCnt = 0;
         var featureCnt = 0;

         geojson.forEach(function(geo, geoIdx, geoArr) {

            // make sure each geo has a properties object
            if (!geo.properties) {
               geo.properties = {};
            }

            // add popup information
            if (geo.type === "Point") {
               pointCnt += 1;
               geo.properties.popup = "Point " + pointCnt;
            }
            if (geo.type === 'LineString') {
               lineStringCnt += 1;
               geo.properties.popup = "LineString " + lineStringCnt;
            }
            if (geo.type === 'Polygon') {
               polygonCnt += 1;
               geo.properties.popup = "Polygon " + polygonCnt;
            }
            if (geo.type === 'GeometryCollection') {
               geoCollectCnt += 1;
               geo.properties.popup =  "Geometry Collection " + geoCollectCnt;
               // popup can't find properties on collection objects
               // placed popup on geometry collection instead
               // geo.geometries.forEach(function (geoG, geoGIdx, geoGArr) {
               //    geoG.properties = {};
               //    geoG.properties.popup =  "Geometry Collection " + geoCollectCnt + " " + geoG.type;
               // });
            }
            if (geo.type === 'Feature') {
               featureCnt += 1;
               var featureName;
               if (geo.properties.featureName !== undefined) {
                  featureName = geo.properties.featureName[0] || geo.id || geo.geometry.type;
               } else featureName = geo.id || "Feature " + featureCnt + " " + geo.geometry.type;
               geo.properties.popup = featureName;
            }
            if (geo.type === 'FeatureCollection') {
               geo.features.forEach(function (geoF, geoFIdx, geoFArr) {
                  featureCnt += 1;
                  var featureName;
                  if (geoF.properties.featureName !== undefined) {
                     featureName = geoF.properties.featureName[0] || geoF.id || geoF.geometry.type;
                  } else featureName = geoF.id || "Feature " + featureCnt + " " + geoF.geometry.type;
                  geoF.properties.popup = featureName;
               });
            }

         });

         var geoLayer = L.geoJSON(geojson, {
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
         map.fitBounds(bnds);

         L.DomEvent.addListener(header, 'click', function() {
            var me = this;
            var i = 0;

            setTimeout(function() {
               check(i, me, bnds);
            }, 100);

         }, map);

         L.DomEvent.addListener(L.DomUtil.get('openAllButton'), 'click', function() {
            var me = this;
            var i = 0;

            setTimeout(function() {
               check(i, me, bnds);
            }, 100);

         }, map);

         // map.addLayer(new L.TileLayer.OSM());
         var stamen = new L.StamenTileLayer("terrain");
         map.addLayer(stamen);
      });
   })();
}
