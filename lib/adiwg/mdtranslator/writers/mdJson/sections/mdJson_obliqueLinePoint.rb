# mdJson 2.0 writer - spatial reference system oblique line point

# History:
#   Stan Smith 2017-10-24 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ObliqueLinePoint

               def self.build(hLinePoint)

                  Jbuilder.new do |json|
                     json.obliqueLineLatitude hLinePoint[:obliqueLineLatitude]
                     json.obliqueLineLongitude hLinePoint[:obliqueLineLongitude]
                  end

               end # build
            end # ObliqueLinePoint

         end
      end
   end
end
