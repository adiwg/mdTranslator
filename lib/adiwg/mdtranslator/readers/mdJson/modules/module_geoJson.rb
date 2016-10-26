# unpack geoJson
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-25 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_geometryObject')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_geometryCollection')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_geometryFeature')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_featureCollection')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeoJson

                    def self.unpack(aGeoJson, responseObj)

                        # return nil object if input is empty
                        if aGeoJson.empty?
                            responseObj[:readerExecutionMessages] << 'GeoJson object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intGeoEle = []

                        aGeoJson.each do |hGeoJson|
                            if hGeoJson.has_key?('type')
                                if hGeoJson['type'] != ''
                                    type = hGeoJson['type']
                                    if %w{ Point LineString Polygon MultiPoint MultiLineString MultiPolygon }.one? { |word| word == type }
                                        hReturn = GeometryObject.unpack(hGeoJson, responseObj)
                                        unless hReturn.nil?
                                            intGeoEle << hReturn
                                        end
                                    end
                                    if type == 'GeometryCollection'
                                        hReturn = GeometryCollection.unpack(hGeoJson, responseObj)
                                        unless hReturn.nil?
                                            intGeoEle << hReturn
                                        end
                                    end
                                    if type == 'Feature'
                                        hReturn = GeometryFeature.unpack(hGeoJson, responseObj)
                                        unless hReturn.nil?
                                            intGeoEle << hReturn
                                        end
                                    end
                                    if type == 'FeatureCollection'
                                        hReturn = FeatureCollection.unpack(hGeoJson, responseObj)
                                        unless hReturn.nil?
                                            intGeoEle << hReturn
                                        end
                                    end
                                end
                            end
                        end

                        return intGeoEle

                    end

                end

            end
        end
    end
end
