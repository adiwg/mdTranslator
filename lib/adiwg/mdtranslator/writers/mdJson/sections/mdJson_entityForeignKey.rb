# mdJson 2.0 writer - entity foreign key

# History:
#   Stan Smith 2017-03-19 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module EntityForeignKey

               def self.build(hKey)

                  Jbuilder.new do |json|
                     json.localAttributeCodeName hKey[:fkLocalAttributes] unless hKey[:fkLocalAttributes].empty?
                     json.referencedEntityCodeName hKey[:fkReferencedEntity]
                     json.referencedAttributeCodeName hKey[:fkReferencedAttributes] unless hKey[:fkReferencedAttributes].empty?
                  end

               end # build
            end # EntityForeignKey

         end
      end
   end
end
