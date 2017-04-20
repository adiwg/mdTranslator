# repack coordinates

# History:
#   Stan Smith 2016-11-10 added computedBbox computation
#   Stan Smith 2015-07-16 moved module_coordinates from mdJson reader to internal
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-05-23 added getLevels
# 	Stan Smith 2013-11-13 added getDimension
# 	Stan Smith 2013-11-07 original script

module AdiwgCoordinates

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

        # find all the eastings (x) and northings (y) in the GeoJSON object
        aNorthings = []
        aEastings = []
        aGeo.each do |hGeo|
            unpackGeometry(hGeo, aNorthings, aEastings)
        end

        # find most north/south points
        north = aNorthings.max
        south = aNorthings.min

        # find most east/west spanning the meridian
        eastM = aEastings.max
        westM = aEastings.min

        # find most east/west spanning the anti-meridian
        positiveEast = []
        negativeEast = []
        aEastings.each do |east|
            negativeEast << east if east < 0.0
            positiveEast << east if east >= 0.0
        end
        eastAM = negativeEast.max
        westAM = positiveEast.min

        # if eastings are all positive or all negative no meridian was spanned
        if positiveEast.empty? || negativeEast.empty?
            east = eastM
            west = westM
        else
            # choose which meridian was spanned based on smaller edge-to-edge distance
            distanceM = eastM - westM
            distanceAM = (180 + eastAM) + (180 - westAM)
            if distanceM <= distanceAM
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
        if %w{ Point LineString Polygon MultiPoint MultiLineString MultiPolygon }.one? { |word| word == type }
            unpackCoords(hGeo[:coordinates], aNorthings, aEastings)
        end

        # geometry collections
        if hGeo[:type] == 'GeometryCollection'
            hGeo[:geometryObjects].each do |aGeoObj|
                unpackCoords(aGeoObj[:coordinates], aNorthings, aEastings)
            end
        end

        # features
        if hGeo[:type] == 'Feature'
            featureType = hGeo[:geometryObject][:type]
            if featureType == 'GeometryCollection'
                unpackGeometry(hGeo[:geometryObject], aNorthings, aEastings)
            else
                unpackCoords(hGeo[:geometryObject][:coordinates], aNorthings, aEastings)
            end
        end

        # feature collections
        if hGeo[:type] == 'FeatureCollection'
            hGeo[:features].each do |hFeature|
                unpackGeometry(hFeature, aNorthings, aEastings)
            end
        end

    end

    # compute bounding box
    def self.unpackCoords(aCoords, aNorthings, aEastings)
        if aCoords[0].kind_of?(Array)
            aCoords.each do |aTuple|
                unpackCoords(aTuple, aNorthings, aEastings)
            end
        else
            addPoint(aCoords, aNorthings, aEastings)
        end
    end

    # compute bounding box
    def self.addPoint(aPoint, aNorthings, aEastings)
        aEastings << aPoint[0]
        aNorthings << aPoint[1]
    end

end
