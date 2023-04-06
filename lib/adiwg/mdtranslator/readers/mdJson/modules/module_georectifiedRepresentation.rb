#  Stan Smith 2018-02-18 refactored error and warning messaging
# unpack georectified representation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-20 refactored error and warning messaging
# 	Stan Smith 2016-10-19 original script

require_relative 'module_gridRepresentation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeorectifiedRepresentation

               def self.unpack(hGeoRec, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGeoRec.empty?
                     @MessagePath.issueWarning(400, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoRec = intMetadataClass.newGeorectifiedInfo

                  outContext = 'georectified representation'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # georectified representation - grid representation (required)
                  if hGeoRec.has_key?('gridRepresentation')
                     hObject = hGeoRec['gridRepresentation']
                     unless hObject.empty?
                        hReturn = GridRepresentation.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intGeoRec[:gridRepresentation] = hReturn
                        end
                     end
                  end
                  if intGeoRec[:gridRepresentation].empty?
                     @MessagePath.issueError(401, responseObj, inContext)
                  end

                  # georectified representation - check point availability (required)
                  if hGeoRec.has_key?('checkPointAvailable')
                     if hGeoRec['checkPointAvailable'] === true
                        intGeoRec[:checkPointAvailable] = hGeoRec['checkPointAvailable']
                     end
                  end

                  # georectified representation - check point description
                  if hGeoRec.has_key?('checkPointDescription')
                     if hGeoRec['checkPointDescription'] != ''
                        intGeoRec[:checkPointDescription] = hGeoRec['checkPointDescription']
                     end
                  end

                  # georectified representation - corner points [2 or 4] (required)
                  if hGeoRec.has_key?('cornerPoints')
                     unless hGeoRec['cornerPoints'].empty?
                        intGeoRec[:cornerPoints] = hGeoRec['cornerPoints']
                     end
                  end
                  unless intGeoRec[:cornerPoints].length == 2 || intGeoRec[:cornerPoints].length == 4
                     @MessagePath.issueError(402, responseObj, inContext)
                  end

                  # georectified representation - center points
                  if hGeoRec.has_key?('centerPoint')
                     unless hGeoRec['centerPoint'].empty?
                        intGeoRec[:centerPoint] = hGeoRec['centerPoint']
                     end
                     unless intGeoRec[:centerPoint].length == 2
                        @MessagePath.issueError(403, responseObj, inContext)
                     end
                  end

                  # georectified representation - point in pixel (required)
                  if hGeoRec.has_key?('pointInPixel')
                     if hGeoRec['pointInPixel'] != ''
                        intGeoRec[:pointInPixel] = hGeoRec['pointInPixel']
                     end
                  end
                  if intGeoRec[:pointInPixel].nil?
                     @MessagePath.issueError(404, responseObj, inContext)
                  end

                  # georectified representation - transformation dimension description
                  if hGeoRec.has_key?('transformationDimensionDescription')
                     if hGeoRec['transformationDimensionDescription'] != ''
                        intGeoRec[:transformationDimensionDescription] = hGeoRec['transformationDimensionDescription']
                     end
                  end

                  # georectified representation - transformation dimension mapping
                  if hGeoRec.has_key?('transformationDimensionMapping')
                     if hGeoRec['transformationDimensionMapping'] != ''
                        intGeoRec[:transformationDimensionMapping] = hGeoRec['transformationDimensionMapping']
                     end
                  end

                  if hGeoRec.has_key?('scope')
                     hGeoRec['scope'].each do |item|
                        scope = Scope.unpack(item, responseObj, inContext)
                        unless scope.nil?
                           intGeoRec[:scope] << scope
                        end
                     end
                  end

                  return intGeoRec

               end

            end

         end
      end
   end
end
