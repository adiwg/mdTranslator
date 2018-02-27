# unpack spatial reference system parameter oblique line point
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2017-10-23 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ObliqueLinePoint

               def self.unpack(hLinePt, responseObj)

                  # return nil object if input is empty
                  if hLinePt.empty?
                     responseObj[:readerExecutionMessages] <<
                        'WARNING: mdJson reader: spatial reference oblique line-point object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intLinePoint = intMetadataClass.newObliqueLinePoint

                  # oblique line point - azimuth line latitude (required)
                  if hLinePt.has_key?('azimuthLineLatitude')
                     intLinePoint[:azimuthLineLatitude] = hLinePt['azimuthLineLatitude']
                  end
                  if intLinePoint[:azimuthLineLatitude].nil? || intLinePoint[:azimuthLineLatitude] == ''
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson spatial reference oblique line-point latitude is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # oblique line point - azimuth line longitude (required)
                  if hLinePt.has_key?('azimuthLineLongitude')
                     intLinePoint[:azimuthLineLongitude] = hLinePt['azimuthLineLongitude']
                  end
                  if intLinePoint[:azimuthLineLongitude].nil? || intLinePoint[:azimuthLineLongitude] == ''
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson spatial reference oblique line-point longitude is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intLinePoint
               end

            end

         end
      end
   end
end
