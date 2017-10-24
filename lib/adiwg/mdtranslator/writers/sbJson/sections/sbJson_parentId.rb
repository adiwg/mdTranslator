# sbJson 1.0 writer

# History:
#  Stan Smith 2017-10-24 fix bug that returns first identifier if no SB namespace is found
#  Stan Smith 2017-05-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module ParentId

               def self.build(hCitation)

                  # return identifier as parentId where namespace = 'gov.sciencebase.catalog'
                  hCitation[:identifiers].each do |hIdentifier|
                     unless hIdentifier[:namespace].nil?
                        if hIdentifier[:namespace] == 'gov.sciencebase.catalog'
                           return hIdentifier[:identifier]
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
