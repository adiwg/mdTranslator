# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-17 refactored error and warning messaging
# 	Stan Smith 2017-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module CoordinateResolution

               def self.unpack(hCoordRes, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson


                  # return nil object if input is empty
                  if hCoordRes.empty?
                     @MessagePath.issueWarning(120, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intCoordRes = intMetadataClass.newCoordinateResolution

                  # coordinate resolution - abscissa (X) (required)
                  if hCoordRes.has_key?('abscissaResolutionX')
                     intCoordRes[:abscissaResolutionX] = hCoordRes['abscissaResolutionX']
                  end
                  if intCoordRes[:abscissaResolutionX].nil? || intCoordRes[:abscissaResolutionX] == ''
                     @MessagePath.issueError(121, responseObj, inContext)
                  end

                  # coordinate resolution - ordinate (Y) (required)
                  if hCoordRes.has_key?('ordinateResolutionY')
                     intCoordRes[:ordinateResolutionY] = hCoordRes['ordinateResolutionY']
                  end
                  if intCoordRes[:ordinateResolutionY].nil? || intCoordRes[:ordinateResolutionY] == ''
                     @MessagePath.issueError(122, responseObj, inContext)
                  end

                  # coordinate resolution - units of measure (required)
                  if hCoordRes.has_key?('unitOfMeasure')
                     intCoordRes[:unitOfMeasure] = hCoordRes['unitOfMeasure']
                  end
                  if intCoordRes[:unitOfMeasure].nil? || intCoordRes[:unitOfMeasure] == ''
                     @MessagePath.issueError(123, responseObj, inContext)
                  end

                  return intCoordRes

               end

            end

         end
      end
   end
end
