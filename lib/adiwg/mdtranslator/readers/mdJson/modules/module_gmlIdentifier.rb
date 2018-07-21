# unpack GML identifier
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-20 refactored error and warning messaging
# 	Stan Smith 2016-11-30 original script

# TODO verify this method is not used

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GMLIdentifier

               def self.unpack(hIdentifier, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hIdentifier.empty?
                     @MessagePath.issueWarning(420, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intIdentifier = intMetadataClass.newIdentifier

                  # gml identifier - identifier (required)
                  if hIdentifier.has_key?('identifier')
                     intIdentifier[:identifier] = hIdentifier['identifier']
                  end
                  if intIdentifier[:identifier].nil? || intIdentifier[:identifier] == ''
                     @MessagePath.issueError(421, responseObj)
                  end

                  # gml identifier - namespace (required)
                  if hIdentifier.has_key?('namespace')
                     intIdentifier[:namespace] = hIdentifier['namespace']
                  end
                  if intIdentifier[:namespace].nil? || intIdentifier[:namespace] == ''
                     @MessagePath.issueError(422, responseObj)
                  end

                  return intIdentifier

               end
            end

         end
      end
   end
end
