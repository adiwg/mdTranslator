# unpack spatial reference system parameter oblique line point
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
# 	Stan Smith 2017-10-23 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ObliqueLinePoint

               def self.unpack(hLinePt, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hLinePt.empty?
                     @MessagePath.issueWarning(590, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intLinePoint = intMetadataClass.newObliqueLinePoint

                  # oblique line point - azimuth line latitude (required)
                  if hLinePt.has_key?('obliqueLineLatitude')
                     intLinePoint[:obliqueLineLatitude] = hLinePt['obliqueLineLatitude']
                  end
                  if intLinePoint[:obliqueLineLatitude].nil? || intLinePoint[:obliqueLineLatitude] == ''
                     @MessagePath.issueError(591, responseObj, inContext)
                  end

                  # oblique line point - azimuth line longitude (required)
                  if hLinePt.has_key?('obliqueLineLongitude')
                     intLinePoint[:obliqueLineLongitude] = hLinePt['obliqueLineLongitude']
                  end
                  if intLinePoint[:obliqueLineLongitude].nil? || intLinePoint[:obliqueLineLongitude] == ''
                     @MessagePath.issueError(592, responseObj, inContext)
                  end

                  return intLinePoint
               end

            end

         end
      end
   end
end
