# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module ParentId

               def self.build(hCitation)

                  parentId = ''

                  hCitation[:identifiers].each_with_index do |hIdentifier, index|
                     if index == 0
                        parentId = hIdentifier[:identifier]
                     end
                     unless hIdentifier[:namespace].nil?
                        if hIdentifier[:namespace] == 'gov.sciencebase.catalog'
                           parentId = hIdentifier[:identifier]
                        end
                     end
                  end

                  parentId

               end

            end

         end
      end
   end
end
