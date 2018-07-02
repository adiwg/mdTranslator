# unpack feature collection
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-19 refactored error and warning messaging
#  Stan Smith 2016-11-10 added computedBbox computation
#  Stan Smith 2016-10-25 original script

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'module_geoJson'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module FeatureCollection

               def self.unpack(hFeatCol, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hFeatCol.empty?
                     @MessagePath.issueWarning(280, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intFeatCol = intMetadataClass.newFeatureCollection

                  # feature collection - type (required)
                  if hFeatCol.has_key?('type')
                     unless hFeatCol['type'] == ''
                        if hFeatCol['type'] == 'FeatureCollection'
                           intFeatCol[:type] = hFeatCol['type']
                        else
                           @MessagePath.issueError(281, responseObj)
                        end
                     end
                  end
                  if intFeatCol[:type].nil? || intFeatCol[:type] == ''
                     @MessagePath.issueError(282, responseObj)
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
                     @MessagePath.issueError(283, responseObj)
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
