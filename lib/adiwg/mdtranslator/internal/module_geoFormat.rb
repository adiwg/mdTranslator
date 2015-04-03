# methods for converting geographic formats
# for ADIwg readers and writers

# History:
# 	Stan Smith 2015-04-01 original script

module AdiwgGeoFormat

    def self.internal_to_geoJson(hGeoEle)

        geoType = hGeoEle[:elementGeometry][:geoType]
        hGeometry = hGeoEle[:elementGeometry][:geometry]
        hSRS = hGeoEle[:elementSrs]

        # GeoJson structure as hash
        hGeoJson = Hash.new()

        # add type
        hGeoJson[:type] = geoType

        # add bounding box
        if geoType == 'BoundingBox'
            hGeoJson[:bbox] = [hGeometry[:westLong],hGeometry[:southLat],
                               hGeometry[:eastLong],hGeometry[:northLat]]
        end

        # add point, multi-point, linestring, multi-linestring
        if geoType == 'Point' ||
            geoType == 'MultiPoint' ||
            geoType == 'LineString' ||
            geoType == 'MultiLineString'
            hGeoJson[:coordinates] = hGeometry
        end

        # add polygon
        if geoType == 'Polygon'
            hGeoJson[:coordinates] = polygon_to_coords(hGeometry)
        end

        # add multi-polygon
        if geoType == 'MultiPolygon'
            hGeoJson[:coordinates] = []
            hGeometry.each do |hPolygon|
                hGeoJson[:coordinates] << polygon_to_coords(hPolygon)
            end
        end

        # add coordinate reference system
        if !hSRS.empty?
            hGeoJson[:crs] = {}

            # if srs name is provided use crs name format
            sName = hSRS[:srsName]
            sLink = hSRS[:srsHref]
            if !sName.nil?
                hGeoJson[:crs][:type] = 'name'
                hGeoJson[:crs][:properties]= {}
                hGeoJson[:crs][:properties][:name] = sName
            elsif !sLink.nil?
                hGeoJson[:crs][:type] = 'link'
                hGeoJson[:crs][:properties]= {}
                hGeoJson[:crs][:properties][:href] = sLink
                sType = hSRS[:srsType]
                if !sType.nil?
                    hGeoJson[:crs][:properties][:type] = sType
                end
            end

        end

        # convert internal object polygon format to coordinates
        def self.polygon_to_coords(hPolygon)
            aCoordinates = []

            # add exterior ring
            aCoordinates << hPolygon[:exteriorRing]

            # add exclusion rings
            hPolygon[:exclusionRings].each do |aExRing|
                aCoordinates << aExRing
            end

            return aCoordinates
        end

        # return GeoJSON
        return hGeoJson.to_json

    end


    def self.internal_to_wkt(hGeoEle)
        geoType = hGeoEle[:geoType]
        hGeometry = hGeoEle[:geometry]
        wktString = ''

        if geoType == 'Point'
            wktString = 'POINT ('
            wktString += point_string(hGeometry)
            wktString += ')'
        end

        if geoType == 'LineString'
            wktString = 'LINESTRING ('
            hGeometry.each do |point|
                wktString += point_string(point) + ', '
            end
            wktString.chomp!(', ')
            wktString += ')'
        end

        if geoType == 'Polygon'
            wktString = 'POLYGON ('

            # add exterior ring - required
            wktString += '('
            aExtRing = hGeometry[:exteriorRing]
            aExtRing.each do |point|
                wktString += point_string(point) + ', '
            end
            wktString.chomp!(', ')
            wktString += ')'

            # add any exclusion rings
            aExcRings = hGeometry[:exclusionRings]
            aExcRings.each do |excPolygon|
                wktString += ', ('
                excPolygon.each do |point|
                    wktString += point_string(point) + ', '
                end
                wktString.chomp!(', ')
                wktString += ')'
            end

            wktString += ')'
        end

        if geoType == 'MultiPoint'
            wktString = 'MULTIPOINT ('
            hGeometry.each do |point|
                wktString += '('
                wktString += point_string(point) + '), '
            end
            wktString.chomp!(', ')
            wktString += ')'
        end

        if geoType == 'MultiLineString'
            wktString = 'MULTILINESTRING ('
                hGeometry.each do |line|
                    wktString += '('
                    line.each do |point|
                        wktString += point_string(point) + ', '
                    end
                    wktString.chomp!(', ')
                    wktString += '), '
                end
            wktString.chomp!(', ')
            wktString += ')'
        end

        if geoType == 'MultiPolygon'
            wktString = 'MULTIPOLYGON ('
            hGeometry.each do |polygon|
                wktString += '('

                # add exterior ring - required
                wktString += '('
                aExtRing = polygon[:exteriorRing]
                aExtRing.each do |point|
                    wktString += point_string(point) + ', '
                end
                wktString.chomp!(', ')
                wktString += ')'

                # add any exclusion rings
                aExcRings = polygon[:exclusionRings]
                aExcRings.each do |excPolygon|
                    wktString += ', ('
                    excPolygon.each do |point|
                        wktString += point_string(point) + ', '
                    end
                    wktString.chomp!(', ')
                    wktString += ')'
                end

                wktString += '), '
            end
            wktString.chomp!(', ')
            wktString += ')'
        end

        def self.point_string(aTuple)
            sTuple = ''
            aTuple.each do |element|
                sTuple += element.to_s + ' '
            end
            return sTuple.chomp(' ')
        end

        return wktString

    end

end
