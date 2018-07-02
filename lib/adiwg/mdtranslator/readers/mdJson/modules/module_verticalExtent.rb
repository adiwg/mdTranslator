# unpack vertical extent
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-27 refactored error and warning messaging
#  Stan Smith 2016-10-24 original script

require_relative 'module_spatialReference'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module VerticalExtent

               def self.unpack(hVertical, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hVertical.empty?
                     @MessagePath.issueWarning(930, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intVertical = intMetadataClass.newVerticalExtent

                  outContext = 'vertical extent'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # vertical extent - description
                  if hVertical.has_key?('description')
                     unless hVertical['description'] == ''
                        intVertical[:description] = hVertical['description']
                     end
                  end

                  # vertical extent - min value (required)
                  if hVertical.has_key?('minValue')
                     intVertical[:minValue] = hVertical['minValue']
                  end
                  if intVertical[:minValue].nil? || intVertical[:minValue] == ''
                     @MessagePath.issueError(931, responseObj, inContext)
                  end

                  # vertical extent - max value (required)
                  if hVertical.has_key?('maxValue')
                     intVertical[:maxValue] = hVertical['maxValue']
                  end
                  if intVertical[:maxValue].nil? || intVertical[:maxValue] == ''
                     @MessagePath.issueError(932, responseObj, inContext)
                  end

                  # vertical extent - crs ID {spatialReference} (required)
                  if hVertical.has_key?('crsId')
                     hObject = hVertical['crsId']
                     unless hObject.empty?
                        hReturn = SpatialReferenceSystem.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intVertical[:crsId] = hReturn
                        end
                     end
                  end
                  if intVertical[:crsId].empty?
                     @MessagePath.issueError(933, responseObj, inContext)
                  end

                  return intVertical

               end

            end

         end
      end
   end
end
