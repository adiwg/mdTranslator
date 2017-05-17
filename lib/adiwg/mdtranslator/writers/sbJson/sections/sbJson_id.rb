# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-15 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'uuidtools'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Id

               # use metadataInfo identifier
               # else use citation identifier [0]
               # else use generated UUID
               def self.build(intObj)

                  metadataInfo = intObj[:metadata][:metadataInfo]
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  hIdentifier = metadataInfo[:metadataIdentifier]
                  hCitation = resourceInfo[:citation]

                  id = nil
                  metadataId = nil
                  citationId = nil
                  unless hIdentifier.empty?
                     metadataId = hIdentifier[:identifier]
                  end

                  unless hCitation.empty?
                     unless hCitation[:identifiers].empty?
                        citationId = hCitation[:identifiers][0][:identifier]
                     end
                  end

                  if !metadataId.nil?
                     id = metadataId
                  elsif !citationId.nil?
                     id = citationId
                  else
                     id = UUIDTools::UUID.random_create.to_s
                  end

               end

            end

         end
      end
   end
end
