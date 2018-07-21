# unpack vector object
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-27 refactored error and warning messaging
# 	Stan Smith 2016-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module VectorObject

               def self.unpack(hVecObj, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hVecObj.empty?
                     @MessagePath.issueWarning(900, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intVecObj = intMetadataClass.newVectorObject

                  # vector object - object type (required)
                  if hVecObj.has_key?('objectType')
                     unless hVecObj['objectType'] == ''
                        intVecObj[:objectType] = hVecObj['objectType']
                     end
                  end
                  if intVecObj[:objectType].nil?
                     @MessagePath.issueError(901, responseObj, inContext)
                  end

                  # vector object - object count
                  if hVecObj.has_key?('objectCount')
                     unless hVecObj['objectCount'] == ''
                        intVecObj[:objectCount] = hVecObj['objectCount']
                     end
                  end

                  return intVecObj

               end

            end

         end
      end
   end
end
