# mdJson 2.0 writer - duration

# History:
#   Stan Smith 2017-03-14 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete tests after extent

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Duration

               def self.build(hDuration)

                  Jbuilder.new do |json|
                     json.years hDuration[:years]
                     json.months hDuration[:months]
                     json.days hDuration[:days]
                     json.hours hDuration[:hours]
                     json.minutes hDuration[:minutes]
                     json.seconds hDuration[:seconds]
                  end

               end # build
            end # TimePeriod

         end
      end
   end
end
