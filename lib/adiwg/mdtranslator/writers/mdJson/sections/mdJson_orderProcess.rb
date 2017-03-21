# mdJson 2.0 writer - order process

# History:
#   Stan Smith 2017-03-20 original script

require 'jbuilder'
require_relative 'mdJson_dateTime'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module OrderProcess

               def self.build(hOrder)

                  Jbuilder.new do |json|
                     json.fees hOrder[:fees]
                     json.plannedAvailability DateTime.build(hOrder[:plannedAvailability]) unless hOrder[:plannedAvailability].empty?
                     json.orderingInstructions hOrder[:orderingInstructions]
                     json.turnaround hOrder[:turnaround]
                  end

               end # build
            end # OrderProcess

         end
      end
   end
end
