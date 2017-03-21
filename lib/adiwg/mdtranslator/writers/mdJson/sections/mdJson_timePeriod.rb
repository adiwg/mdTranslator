# mdJson 2.0 writer - time period

# History:
#   Stan Smith 2017-03-14 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_dateTime'
require_relative 'mdJson_timeInterval'
require_relative 'mdJson_duration'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module TimePeriod

               def self.build(hTimePeriod)

                  Jbuilder.new do |json|
                     json.id hTimePeriod[:timeId]
                     json.description hTimePeriod[:description]
                     json.identifier Identifier.build(hTimePeriod[:identifier]) unless hTimePeriod[:identifier].empty?
                     json.periodName hTimePeriod[:periodNames] unless hTimePeriod[:periodNames].empty?
                     json.startDateTime DateTime.build(hTimePeriod[:startDateTime]) unless hTimePeriod[:startDateTime].empty?
                     json.endDateTime DateTime.build(hTimePeriod[:endDateTime]) unless hTimePeriod[:endDateTime].empty?
                     json.timeInterval TimeInterval.build(hTimePeriod[:timeInterval]) unless hTimePeriod[:timeInterval].empty?
                     json.duration Duration.build(hTimePeriod[:duration]) unless hTimePeriod[:duration].empty?
                  end

               end # build
            end # TimePeriod

         end
      end
   end
end
