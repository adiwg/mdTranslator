# mdJson 2.0 writer - algorithm

# History:
#  Stan Smith 2019-09-24 original script

require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Algorithm

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hAlgorithm)

                  Jbuilder.new do |json|
                     json.citation Citation.build(hAlgorithm[:citation]) unless hAlgorithm[:citation].empty?
                     json.description hAlgorithm[:description]
                  end

               end # build
            end # Algorithm

         end
      end
   end
end
