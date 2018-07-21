# unpack bounding box
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-15 refactored error and warning messaging
#  Stan Smith 2017-09-28 add altitude to support fgdc
#  Stan Smith 2016-12-01 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module BoundingBox

               def self.unpack(hBBox, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hBBox.empty?
                     @MessagePath.issueWarning(70, responseObj, inContext)
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
                     @MessagePath.issueError(71, responseObj, inContext)
                  elsif intBBox[:westLongitude].abs > 180
                     @MessagePath.issueError(72, responseObj, inContext)
                  end

                  # bounding box - east longitude (required)
                  if hBBox.has_key?('eastLongitude')
                     intBBox[:eastLongitude] = hBBox['eastLongitude']
                  end
                  if intBBox[:eastLongitude].nil? || intBBox[:eastLongitude] == ''
                     @MessagePath.issueError(73, responseObj, inContext)
                  elsif intBBox[:eastLongitude].abs > 180
                     @MessagePath.issueError(72, responseObj, inContext)
                  end

                  # bounding box - south latitude (required)
                  if hBBox.has_key?('southLatitude')
                     intBBox[:southLatitude] = hBBox['southLatitude']
                  end
                  if intBBox[:southLatitude].nil? || intBBox[:southLatitude] == ''
                     @MessagePath.issueError(74, responseObj, inContext)
                  elsif intBBox[:southLatitude].abs > 90
                     @MessagePath.issueError(75, responseObj, inContext)
                  end

                  # bounding box - north latitude (required)
                  if hBBox.has_key?('northLatitude')
                     intBBox[:northLatitude] = hBBox['northLatitude']
                  end
                  if intBBox[:northLatitude].nil? || intBBox[:northLatitude] == ''
                     @MessagePath.issueError(76, responseObj, inContext)
                  elsif intBBox[:northLatitude].abs > 90
                     @MessagePath.issueError(75, responseObj, inContext)
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
                        @MessagePath.issueError(77, responseObj, inContext)
                     end
                  end

                  return intBBox

               end

            end

         end
      end
   end
end
