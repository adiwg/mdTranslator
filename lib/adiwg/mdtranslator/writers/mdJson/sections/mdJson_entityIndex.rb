# mdJson 2.0 writer - entity index

# History:
#   Stan Smith 2017-03-19 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module EntityIndex

               def self.build(hIndex)

                  Jbuilder.new do |json|
                     json.codeName hIndex[:indexCode]
                     json.allowDuplicates hIndex[:duplicate]
                     json.attributeCodeName hIndex[:attributeNames] unless hIndex[:attributeNames].empty?
                  end

               end # build
            end # EntityIndex

         end
      end
   end
end
