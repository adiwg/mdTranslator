#  Stan Smith 2018-02-18 refactored error and warning messaging
# unpack georectified representation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2016-10-19 original script

require_relative 'module_gridRepresentation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeorectifiedRepresentation

               def self.unpack(hGeoRec, responseObj)

                  # return nil object if input is empty
                  if hGeoRec.empty?
                     responseObj[:readerExecutionMessages] <<
                        'WARNING: mdJson reader: georectified spatial representation object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoRec = intMetadataClass.newGeorectifiedInfo

                  # georectified representation - grid representation (required)
                  if hGeoRec.has_key?('gridRepresentation')
                     hObject = hGeoRec['gridRepresentation']
                     unless hObject.empty?
                        hReturn = GridRepresentation.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intGeoRec[:gridRepresentation] = hReturn
                        end
                     end
                  end
                  if intGeoRec[:gridRepresentation].empty?
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson reader: georectified spatial representation grid representation is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
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
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson reader: georectified spatial representation must have either 2 or 4 corner points'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # georectified representation - center points (required)
                  if hGeoRec.has_key?('centerPoint')
                     unless hGeoRec['centerPoint'].empty?
                        intGeoRec[:centerPoint] = hGeoRec['centerPoint']
                     end
                  end
                  if intGeoRec[:centerPoint].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: georectified spatial representation center point is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end
                  unless intGeoRec[:centerPoint].length == 2
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson reader: georectified spatial representation center point must be single 2D coordinate'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # georectified representation - point in pixel (required)
                  if hGeoRec.has_key?('pointInPixel')
                     if hGeoRec['pointInPixel'] != ''
                        intGeoRec[:pointInPixel] = hGeoRec['pointInPixel']
                     end
                  end
                  if intGeoRec[:pointInPixel].nil?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: georectified spatial representation point-in-pixel is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
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

                  return intGeoRec

               end

            end

         end
      end
   end
end
