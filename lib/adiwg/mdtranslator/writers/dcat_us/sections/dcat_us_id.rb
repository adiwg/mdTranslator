# DCAT_US 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module DCAT_US

            module Id

               # use metadataInfo identifier
               # else use citation identifier
               # valid identifier must have namespace = 'gov.sciencebase.catalog'
               def self.build(intObj)

                  metadataInfo = intObj[:metadata][:metadataInfo]
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  hMetadataId = metadataInfo[:metadataIdentifier]
                  hCitation = resourceInfo[:citation]

                  unless hMetadataId.empty?
                     if hMetadataId[:namespace] == 'gov.sciencebase.catalog'
                        unless hMetadataId[:identifier].nil?
                           return hMetadataId[:identifier]
                        end
                     end
                  end

                  unless hCitation.empty?
                     hCitation[:identifiers].each do |hIdentifier|
                        if hIdentifier[:namespace] == 'gov.sciencebase.catalog'
                           unless hIdentifier[:identifier].nil?
                              return hIdentifier[:identifier]
                           end
                        end
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
