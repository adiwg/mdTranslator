# unpack bounding box
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2017-09-28 add altitude to support fgdc
#  Stan Smith 2016-12-01 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module BoundingBox

               def self.unpack(hBBox, responseObj)

                  # return nil object if input is empty
                  if hBBox.empty?
                     responseObj[:readerExecutionMessages] << 'boundingBox object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intBBox = intMetadataClass.newBoundingBox

                  # bounding box - west longitude (required)
                  if hBBox.has_key?('westLongitude')
                     intBBox[:westLongitude] = hBBox['westLongitude']
                  end
                  if intBBox[:westLongitude].nil? || intBBox[:westLongitude] == ''
                     responseObj[:readerExecutionMessages] << 'boundingBox west boundary is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end
                  if intBBox[:westLongitude].abs > 180
                     responseObj[:readerExecutionMessages] << 'boundingBox longitude must be between -180 and +180'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bounding box - east longitude (required)
                  if hBBox.has_key?('eastLongitude')
                     intBBox[:eastLongitude] = hBBox['eastLongitude']
                  end
                  if intBBox[:eastLongitude].nil? || intBBox[:eastLongitude] == ''
                     responseObj[:readerExecutionMessages] << 'boundingBox east boundary is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end
                  if intBBox[:eastLongitude].abs > 180
                     responseObj[:readerExecutionMessages] << 'boundingBox longitude must be between -180 and +180'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bounding box - south latitude (required)
                  if hBBox.has_key?('southLatitude')
                     intBBox[:southLatitude] = hBBox['southLatitude']
                  end
                  if intBBox[:southLatitude].nil? || intBBox[:southLatitude] == ''
                     responseObj[:readerExecutionMessages] << 'boundingBox south boundary is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end
                  if intBBox[:southLatitude].abs > 90
                     responseObj[:readerExecutionMessages] << 'boundingBox latitude must be between -90 and +90'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bounding box - north latitude (required)
                  if hBBox.has_key?('northLatitude')
                     intBBox[:northLatitude] = hBBox['northLatitude']
                  end
                  if intBBox[:northLatitude].nil? || intBBox[:northLatitude] == ''
                     responseObj[:readerExecutionMessages] << 'boundingBox north boundary is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end
                  if intBBox[:northLatitude].abs > 90
                     responseObj[:readerExecutionMessages] << 'boundingBox latitude must be between -90 and +90'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bounding box - minimum altitude
                  if hBBox.has_key?('minimumAltitude')
                     unless hBBox['minimumAltitude'].nil? || hBBox['minimumAltitude'] == ''
                        intBBox[:minimumAltitude] = hBBox['minimumAltitude']
                     end
                  end

                  # bounding box - maximum altitude
                  if hBBox.has_key?('maximumAltitude')
                     unless hBBox['maximumAltitude'].nil? || hBBox['maximumAltitude'] == ''
                        intBBox[:maximumAltitude] = hBBox['maximumAltitude']
                     end
                  end

                  # bounding box - altitude units of measure
                  if hBBox.has_key?('unitsOfAltitude')
                     unless hBBox['unitsOfAltitude'].nil? || hBBox['unitsOfAltitude'] == ''
                        intBBox[:unitsOfAltitude] = hBBox['unitsOfAltitude']
                     end
                  end
                  unless intBBox[:minimumAltitude].nil? && intBBox[:maximumAltitude].nil?
                     if intBBox[:unitsOfAltitude].nil? || intBBox[:unitsOfAltitude] == ''
                        responseObj[:readerExecutionMessages] << 'boundingBox altitude unit of measure is missing'
                        responseObj[:readerExecutionPass] = false
                        return nil
                     end
                  end

                  return intBBox

               end

            end

         end
      end
   end
end
