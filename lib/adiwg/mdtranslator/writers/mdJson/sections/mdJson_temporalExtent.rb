# mdJson 2.0 writer - temporal extent

# History:
#   Stan Smith 2017-03-15 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_timePeriod'
require_relative 'mdJson_timeInstant'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module TemporalExtent

               def self.build(hTemporal)

                  Jbuilder.new do |json|
                     json.timePeriod TimePeriod.build(hTemporal[:timePeriod]) unless hTemporal[:timePeriod].empty?
                     json.timeInstant TimeInstant.build(hTemporal[:timeInstant]) unless hTemporal[:timeInstant].empty?
                  end

               end # build
            end # TemporalExtent

         end
      end
   end
end
