# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Identifier

               def self.build(intObj)
                  metadataInfo = intObj[:metadata][:metadataInfo]
                  metadataIdentifier = metadataInfo[:metadataIdentifier]
                  unless metadataIdentifier.empty?
                     unless metadataIdentifier[:identifier].nil?
                        return metadataIdentifier[:identifier]
                     end
                  end
                  return nil
               end
               
            end
         end
      end
   end
end
