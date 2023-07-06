# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Id

               def self.build(intObj)
                  metadataInfo = intObj[:metadata][:metadataInfo]
                  hMetadataId = metadataInfo[:metadataIdentifier]
                  unless hMetadataId.empty?
                     unless hMetadataId[:identifier].nil?
                        return hMetadataId[:identifier]
                     end
                  end
                  return nil
               end
               
            end
         end
      end
   end
end
