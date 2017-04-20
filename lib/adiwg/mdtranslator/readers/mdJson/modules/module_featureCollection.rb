# unpack feature collection
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

                module FeatureCollection

                    def self.unpack(hFeatCol, responseObj)

                        # return nil object if input is empty
                        if hFeatCol.empty?
                            responseObj[:readerExecutionMessages] << 'Feature Collection object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intFeatCol = intMetadataClass.newFeatureCollection

                        # feature collection - type (required)
                        if hFeatCol.has_key?('type')
                            if hFeatCol['type'] != ''
                                if hFeatCol['type'] == 'FeatureCollection'
                                    intFeatCol[:type] = hFeatCol['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Feature Collection type must be GeometryCollection'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intFeatCol[:type].nil? || intFeatCol[:type] == ''
                            responseObj[:readerExecutionMessages] << 'Feature Collection is missing type'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # feature collection - bounding box
                        if hFeatCol.has_key?('bbox')
                            unless hFeatCol['bbox'].empty?
                                intFeatCol[:bbox] = hFeatCol['bbox']
                            end
                        end

                        # feature collection - features (required, but can be empty)
                        if hFeatCol.has_key?('features')
                            hFeatCol['features'].each do |hFeature|
                                hReturn = GeoJson.unpack(hFeature, responseObj)
                                unless hReturn.nil?
                                    intFeatCol[:features] << hReturn
                                end
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Features Collection is missing features'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # geometry feature - computed bounding box for extent
                        unless intFeatCol[:features].empty?
                            intFeatCol[:computedBbox] = AdiwgCoordinates.computeBbox(intFeatCol[:features])
                        end

                        # geometry feature - save native GeoJSON for feature
                        intFeatCol[:nativeGeoJson] = hFeatCol

                        return intFeatCol

                    end

                end

            end
        end
    end
end
