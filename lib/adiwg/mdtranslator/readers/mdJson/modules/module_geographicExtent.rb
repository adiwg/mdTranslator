# unpack geoJson
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-11-10 added computedBbox computation
#   Stan Smith 2016-10-25 original script

require_relative 'module_geoJson'
require 'adiwg/mdtranslator/internal/module_coordinates'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeographicExtent

                    def self.unpack(hGeoJson, responseObj)

                        # return nil object if input is empty
                        if hGeoJson.empty?
                            responseObj[:readerExecutionMessages] << 'GeoJson object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoExtent = intMetadataClass.newGeographicExtent

                        # save native GeoJson
                        if hGeoJson.has_key?('geoJson')
                            unless hGeoJson['geoJson'].empty?
                                intGeoExtent[:nativeGeoJson] = hGeoJson['geoJson']
                            end
                        end

                        # ingest the GeoJson into mdTranslator
                        aReturn = GeoJson.unpack(hGeoJson['geoJson'], responseObj)
                        unless aReturn.nil?
                            intGeoExtent[:geographicElements] = aReturn
                        end

                        # compute bbox for extent
                        unless intGeoExtent[:geographicElements].empty?
                            intGeoExtent[:computedBbox] = AdiwgCoordinates.computeBbox(intGeoExtent[:geographicElements])
                        end

                        return intGeoExtent

                    end

                end

            end
        end
    end
end
