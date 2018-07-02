# unpack resourceType
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-24 refactored error and warning messaging
#  Stan Smith 2017-02-15 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ResourceType

               def self.unpack(hType, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hType.empty?
                     @MessagePath.issueWarning(690, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intType = intMetadataClass.newResourceType

                  # resource type - type (required) {MD_ScopeCode}
                  if hType.has_key?('type')
                     unless hType['type'] == ''
                        intType[:type] = hType['type']
                     end
                  end
                  if intType[:type].nil?
                     @MessagePath.issueError(691, responseObj, inContext)
                  end

                  # resource type - name
                  if hType.has_key?('name')
                     unless hType['name'] == ''
                        intType[:name] = hType['name']
                     end
                  end

                  return intType

               end

            end

         end
      end
   end
end
