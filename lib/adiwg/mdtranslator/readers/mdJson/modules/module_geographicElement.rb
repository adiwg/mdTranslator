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

                module GeographicElement

                    def self.unpack(hElement, responseObj)

                        # return nil object if input is empty
                        if hElement.empty?
                            responseObj[:readerExecutionMessages] << 'geographicElement object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoEle = intMetadataClass.newGeographicElement

                        # save native GeoJson
                        intGeoEle[:nativeGeoJson] = hElement

                        # ingest the GeoJson into mdTranslator
                        hReturn = GeoJson.unpack(hElement, responseObj)
                        unless hReturn.nil?
                            intGeoEle[:geographicElement] = hReturn
                        end

                        return intGeoEle

                    end

                end

            end
        end
    end
end
