# mdJson 2.0 writer - vector representation

# History:
#   Stan Smith 2017-03-14 original script

require 'jbuilder'
require_relative 'mdJson_vectorObject'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Vector

               def self.build(hVector)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.topologyLevel hVector[:topologyLevel]
                     json.vectorObject @Namespace.json_map(hVector[:vectorObject], VectorObject)
                     json.scope hVector[:scope]
                  end

               end # build
            end # Vector

         end
      end
   end
end
