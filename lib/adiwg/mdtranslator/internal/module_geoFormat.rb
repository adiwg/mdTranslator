# methods for converting geographic formats
# for ADIwg readers and writers

# History:
# 	Stan Smith 2015-04-01 original script

module AdiwgGeoFormat

    def self.internal_to_geoJson(hGeoEle)

        require 'pp'
        pp hGeoEle
        puts '----------------------'
        geoType = hGeoEle[:geoType]
        hGeometry = hGeoEle[:geometry]

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
        if geoType == 'Point' || 'MultiPoint' || 'LineString' || 'MultiLineString'
            hGeoJson[:coordinates] = hGeometry
        end

        # add polygon
        if geoType == 'Polygon'
            hGeoJson[:coordinates] = []

            # add exterior ring
            hGeoJson[:coordinates] << hGeometry[:exteriorRing]

            # add exclusion rings
            hGeometry[:exclusionRings].each do |aExRing|
                hGeoJson[:coordinates] << aExRing
            end

        end

        # add coordinate reference system

        return hGeoJson.to_json

    end

end
