# mdJson 2.0 writer - duration

# History:
#   Stan Smith 2017-03-14 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Duration

               def self.build(hDuration)

                  Jbuilder.new do |json|
                     json.years hDuration[:years] unless hDuration[:years] == 0
                     json.months hDuration[:months] unless hDuration[:months] == 0
                     json.days hDuration[:days] unless hDuration[:days] == 0
                     json.hours hDuration[:hours] unless hDuration[:hours] == 0
                     json.minutes hDuration[:minutes] unless hDuration[:minutes] == 0
                     json.seconds hDuration[:seconds] unless hDuration[:seconds] == 0
                  end

               end # build
            end # TimePeriod

         end
      end
   end
end
