# unpack GML identifier
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2016-11-30 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GMLIdentifier

               def self.unpack(hIdentifier, responseObj)

                  # return nil object if input is empty
                  if hIdentifier.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: GML Identifier object is empty'
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
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: GML Identifier identifier is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # gml identifier - namespace (required)
                  if hIdentifier.has_key?('namespace')
                     intIdentifier[:namespace] = hIdentifier['namespace']
                  end
                  if intIdentifier[:namespace].nil? || intIdentifier[:namespace] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: GML Identifier namespace is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intIdentifier

               end
            end

         end
      end
   end
end
