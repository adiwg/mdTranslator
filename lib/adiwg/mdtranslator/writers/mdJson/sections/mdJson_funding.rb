# mdJson 2.0 writer - funding

# History:
#  Stan Smith 2017-08-31 refactored for mdJson schema 2.3
#  Stan Smith 2017-03-20 original script

require 'jbuilder'
require_relative 'mdJson_allocation'
require_relative 'mdJson_timePeriod'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Funding

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hFunding)

                  Jbuilder.new do |json|
                     json.description hFunding[:description]
                     json.timePeriod TimePeriod.build(hFunding[:timePeriod]) unless hFunding[:timePeriod].empty?
                     json.allocation @Namespace.json_map(hFunding[:allocations], Allocation)
                  end

               end # build
            end # Funding

         end
      end
   end
end
