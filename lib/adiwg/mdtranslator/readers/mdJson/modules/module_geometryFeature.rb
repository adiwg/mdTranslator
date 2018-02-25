# unpack geometry feature
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
#  Stan Smith 2016-11-10 added computedBbox computation
#  Stan Smith 2016-10-25 original script

require_relative 'module_geometryObject'
require_relative 'module_geometryProperties'
require_relative 'module_geometryCollection'
require 'adiwg/mdtranslator/internal/module_coordinates'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeometryFeature

               def self.unpack(hFeature, responseObj)

                  # return nil object if input is empty
                  if hFeature.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson GeoJSON geometry feature object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intFeature = intMetadataClass.newGeometryFeature

                  # geometry feature - type (required)
                  if hFeature.has_key?('type')
                     unless hFeature['type'] == ''
                        if hFeature['type'] == 'Feature'
                           intFeature[:type] = hFeature['type']
                        else
                           responseObj[:readerExecutionMessages] << 'ERROR: mdJson GeoJSON geometry feature type must be Feature'
                           responseObj[:readerExecutionPass] = false
                           return nil
                        end
                     end
                  end
                  if intFeature[:type].nil? || intFeature[:type] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson GeoJSON geometry feature type is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geometry feature - id
                  if hFeature.has_key?('id')
                     unless hFeature['id'] == ''
                        intFeature[:id] = hFeature['id']
                     end
                  end

                  # geometry feature - bounding box
                  if hFeature.has_key?('bbox')
                     unless hFeature['bbox'].empty?
                        intFeature[:bbox] = hFeature['bbox']
                     end
                  end

                  # geometry feature - geometry (required, but may be JSON null)
                  if hFeature.has_key?('geometry')
                     unless hFeature['geometry'].empty?
                        hGeometry = hFeature['geometry']
                        if hGeometry['type'] == 'GeometryCollection'
                           hReturn = GeometryCollection.unpack(hGeometry, responseObj)
                        else
                           hReturn = GeometryObject.unpack(hGeometry, responseObj)
                        end
                        unless hReturn.nil?
                           intFeature[:geometryObject] = hReturn
                        end
                     end
                  else
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson GeoJSON geometry feature geometry is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geometry feature - properties
                  if hFeature.has_key?('properties')
                     hObject = hFeature['properties']
                     unless hObject.empty?
                        hReturn = GeometryProperties.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intFeature[:properties] = hReturn
                        end
                     end
                  end

                  # geometry feature - computed bounding box for feature
                  unless intFeature[:geometryObject].empty?
                     intFeature[:computedBbox] = AdiwgCoordinates.computeBbox([intFeature[:geometryObject]])
                  end

                  # geometry feature - save native GeoJSON for feature
                  intFeature[:nativeGeoJson] = hFeature

                  return intFeature

               end

            end

         end
      end
   end
end
