# repack coordinates

# History:
#  Stan Smith 2017-08-23 added is_polygon_clockwise method
#  Stan Smith 2017-05-24 added checkGeometry method to move objects to real world
#  Stan Smith 2016-11-10 added computedBbox computation
#  Stan Smith 2015-07-16 moved module_coordinates from mdJson reader to internal
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-05-23 added getLevels
# 	Stan Smith 2013-11-13 added getDimension
# 	Stan Smith 2013-11-07 original script

module AdiwgCoordinates

   @spanWorld = 0

   # repack coordinate array into single string for ISO
   def self.stringifyCoords(aCoords, responseObj)

      s = ''
      i = 0
      coordCount = aCoords.length
      aCoords.each do |coord|
         if coord.kind_of?(Array)
            s = s + unpack(coord, responseObj)
         else
            i += 1
            s = s + coord.to_s
            if i < coordCount
               s = s + ','
            end
            s = s + ' '
         end
      end

      return s

   end

   # get the number of dimensions in a coordinate array
   def self.getDimension(aCoords)

      if aCoords[0].kind_of?(Array)
         coordDim = getDimension(aCoords[0])
      else
         coordDim = aCoords.length
      end

      return coordDim

   end

   # get the number of levels in the coordinate array
   def self.getLevels(aCoords)

      i = 1
      if aCoords[0].kind_of?(Array)
         i = i + getLevels(aCoords[0])
      end
      return i

   end

   # compute bounding box
   def self.computeBbox(aGeo)

      # reset spanned world to 0 before computing bounding box
      @spanWorld = 0

      # find all the eastings (x) and northings (y) in the GeoJSON object
      aNorthings = []
      aEastings = []
      aGeo.each do |hGeo|
         unpackGeometry(hGeo, aNorthings, aEastings)
      end

      # return if no coordinates found in geographic object(s)
      return {} if aNorthings.empty? || aEastings.empty?

      # find most north/south points
      north = aNorthings.max
      south = aNorthings.min

      # find most east/west spanning the meridian
      eastM = aEastings.max
      westM = aEastings.min

      # find most east/west spanning the anti-meridian
      aPositiveEast = []
      aNegativeEast = []
      aEastings.each do |east|
         aNegativeEast << east if east < 0.0
         aPositiveEast << east if east >= 0.0
      end
      aNegativeEast.uniq!
      aPositiveEast.uniq!

      eastAM = aNegativeEast.max
      westAM = aPositiveEast.min

      # if eastings are all positive or all negative hemisphere is decided
      if aPositiveEast.empty? || aNegativeEast.empty?
         east = eastM
         west = westM
      else
         # choose which meridian to span based on smaller edge-to-edge distance
         distanceM = eastM - westM
         distanceAM = (180 + eastAM) + (180 - westAM)
         if distanceM.abs <= distanceAM.abs
            # this spanned to  meridian
            east = eastM
            west = westM
         else
            # this spanned tne anti-meridian
            east = eastAM
            west = westAM
         end
      end

      bBox = {}
      bBox[:westLongitude] = west
      bBox[:eastLongitude] = east
      bBox[:southLatitude] = south
      bBox[:northLatitude] = north

      return bBox

   end

   # compute bounding box
   def self.unpackGeometry(hGeo, aNorthings, aEastings)

      # geometry objects
      type = hGeo[:type]
      if %w{ Point LineString Polygon MultiPoint MultiLineString MultiPolygon }.one? {|word| word == type}
         checkGeometry(hGeo[:coordinates], aNorthings, aEastings)
      end

      # geometry collections
      if hGeo[:type] == 'GeometryCollection'
         hGeo[:geometryObjects].each do |aGeoObj|
            checkGeometry(aGeoObj[:coordinates], aNorthings, aEastings)
         end
      end

      # features
      if hGeo[:type] == 'Feature'
         featureType = hGeo[:geometryObject][:type]
         if featureType == 'GeometryCollection'
            unpackGeometry(hGeo[:geometryObject], aNorthings, aEastings)
         else
            checkGeometry(hGeo[:geometryObject][:coordinates], aNorthings, aEastings)
         end
      end

      # feature collections
      if hGeo[:type] == 'FeatureCollection'
         hGeo[:features].each do |hFeature|
            unpackGeometry(hFeature, aNorthings, aEastings)
         end
      end

   end

   # move geometry to real world if possible
   # move geometry to a single spanned meridian
   def self.checkGeometry(aCoords, aNorthings, aEastings)

      aGeoNorthings = []
      aGeoEastings = []

      unpackCoords(aCoords, aGeoNorthings, aGeoEastings)

      minEast = aGeoEastings.min
      maxEast = aGeoEastings.max

      # if all coordinates in -1 or +1 world, move back to real world
      if maxEast < -180
         aGeoEastings.collect! { |x| x + 360 }
      end
      if minEast > 180
         aGeoEastings.collect! { |x| x - 360 }
      end

      minEast = aGeoEastings.min
      maxEast = aGeoEastings.max

      # if geoObject spans a meridian, find out which one and make it default
      if @spanWorld == 0
         @spanWorld = -1 if maxEast < 0 && minEast < -180
         @spanWorld = 1 if minEast > 0 && maxEast > 180
      end

      # bring -1 and +1 world objects back into default meridian world
      if @spanWorld == -1 && maxEast > 180
         aGeoEastings.collect! { |x| x - 360 }
      end
      if @spanWorld == 1 && minEast < -180
         aGeoEastings.collect! { |x| x + 360 }
      end

      aEastings.concat(aGeoEastings)
      aNorthings.concat(aGeoNorthings)

   end

   # unpack coordinate arrays
   def self.unpackCoords(aCoords, aNorthings, aEastings)
      if aCoords[0].kind_of?(Array)
         aCoords.each do |aTuple|
            unpackCoords(aTuple, aNorthings, aEastings)
         end
      else
         addPoint(aCoords, aNorthings, aEastings)
      end
   end

   # add to tuple to an array
   def self.addPoint(aPoint, aNorthings, aEastings)
      aEastings << aPoint[0]
      aNorthings << aPoint[1]
   end

   def self.is_polygon_clockwise(aCoords)
      area = 0.0
      i = 0
      n = aCoords.length - 1
      until i == n
         area += (aCoords[i][0] * aCoords[i+1][1]) - (aCoords[i][1] * aCoords[i+1][0])
         i += 1
      end
      area += (aCoords[n][0] * aCoords[0][1]) - (aCoords[n][1] * aCoords[0][0])
      return area >= 0 ? false : true
   end

end
