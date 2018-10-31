# mdJson 2.0 writer - spatial reference system projection parameters

# History:
#  Stan Smith 2018 10-18 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module LocalProjection

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hLocal)

                  Jbuilder.new do |json|
                     json.fixedToEarth hLocal[:fixedToEarth]
                     json.description hLocal[:description]
                     json.georeference hLocal[:georeference]
                  end

               end # build
            end # LocalProjection

         end
      end
   end
end
