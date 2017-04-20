# mdJson 2.0 writer - distribution

# History:
#   Stan Smith 2017-03-20 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_distributor'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Distribution

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hDistribution)

                  Jbuilder.new do |json|
                     json.description hDistribution[:description]
                     json.distributor @Namespace.json_map(hDistribution[:distributor], Distributor)
                  end

               end # build
            end # Distribution

         end
      end
   end
end
