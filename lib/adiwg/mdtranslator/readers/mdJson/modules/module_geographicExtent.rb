# unpack geoJson
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-25 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_geoJson')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeographicExtent

                    def self.unpack(aGeoJson, responseObj)

                        # return nil object if input is empty
                        if aGeoJson.empty?
                            responseObj[:readerExecutionMessages] << 'GeoJson object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoExtent = intMetadataClass.newGeographicExtent

                        # save native GeoJson
                        intGeoExtent[:nativeGeoJson] = aGeoJson

                        # ingest the GeoJson
                        aReturn = GeoJson.unpack(aGeoJson, responseObj)
                        unless aReturn.nil?
                            intGeoExtent[:geographicElements] = aReturn
                        end

                        return intGeoExtent

                    end

                end

            end
        end
    end
end
