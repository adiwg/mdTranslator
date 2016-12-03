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

                    def self.unpack(aGeoEle, responseObj)

                        # return nil object if input is empty
                        if aGeoEle.empty?
                            responseObj[:readerExecutionMessages] << 'geographicElement object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoEle = intMetadataClass.newGeographicElement

                        # save native GeoJson
                        intGeoEle[:nativeGeoJson] = aGeoEle

                        # ingest the GeoJson into mdTranslator
                        aReturn = GeoJson.unpack(aGeoEle, responseObj)
                        unless aReturn.nil?
                            intGeoEle[:geographicElements] = aReturn
                        end

                        # compute bbox for extent
                        unless intGeoEle[:geographicElements].empty?
                            intGeoEle[:computedBbox] = AdiwgCoordinates.computeBbox(intGeoEle[:geographicElements])
                        end

                        return intGeoEle

                    end

                end

            end
        end
    end
end
