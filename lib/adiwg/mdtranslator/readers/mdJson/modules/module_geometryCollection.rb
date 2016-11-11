# unpack geometry collection
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-11-11 added computedBbox computation
#   Stan Smith 2016-10-25 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_geoJson')
require 'adiwg/mdtranslator/internal/module_coordinates'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeometryCollection

                    def self.unpack(hGeoCol, responseObj)

                        # return nil object if input is empty
                        if hGeoCol.empty?
                            responseObj[:readerExecutionMessages] << 'Geometry Collection object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoCol = intMetadataClass.newGeometryCollection

                        # geometry collection - type (required)
                        if hGeoCol.has_key?('type')
                            if hGeoCol['type'] != ''
                                if hGeoCol['type'] == 'GeometryCollection'
                                    intGeoCol[:type] = hGeoCol['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Geometry Collection type must be GeometryCollection'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intGeoCol[:type].nil? || intGeoCol[:type] == ''
                            responseObj[:readerExecutionMessages] << 'Geometry Collection is missing type'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # geometry collection - bounding box
                        if hGeoCol.has_key?('bbox')
                            unless hGeoCol['bbox'].empty?
                                intGeoCol[:bbox] = hGeoCol['bbox']
                            end
                        end

                        # geometry collection - geometries (required, but can be empty)
                        if hGeoCol.has_key?('geometries')
                            unless hGeoCol['geometries'].empty?
                                aReturn = GeoJson.unpack(hGeoCol['geometries'], responseObj)
                                unless aReturn.nil?
                                    intGeoCol[:geometryObjects] = aReturn
                                end
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Geometry Collection is missing geometries'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # compute bbox for geometry collection
                        unless intGeoCol[:geometryObjects].empty?
                            intGeoCol[:computedBbox] = AdiwgCoordinates.computeBbox(intGeoCol[:geometryObjects])
                        end

                        return intGeoCol

                    end

                end

            end
        end
    end
end
