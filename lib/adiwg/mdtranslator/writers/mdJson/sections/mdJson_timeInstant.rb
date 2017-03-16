# mdJson 2.0 writer - time instant

# History:
#   Stan Smith 2017-03-15 original script

# TODO complete tests after extent

require 'jbuilder'
require_relative 'mdJson_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module TimeInstant

               def self.build(hTimeInstant)

                  instantDate = hTimeInstant[:timeInstant][:dateTime]
                  instantRes = hTimeInstant[:timeInstant][:dateResolution]
                  instantString = ''

                  unless instantDate.nil?
                     case instantRes
                        when 'Y', 'YM', 'YMD'
                           instantString = AdiwgDateTimeFun.stringDateFromDateTime(instantDate, instantRes)
                        else
                           instantString = AdiwgDateTimeFun.stringDateTimeFromDateTime(instantDate, instantRes)
                     end
                  end

                  Jbuilder.new do |json|
                     json.id hTimeInstant[:timeId]
                     json.description hTimeInstant[:description]
                     json.identifier Identifier.build(hTimeInstant[:identifier]) unless hTimeInstant[:identifier].empty?
                     json.instantName hTimeInstant[:instantNames] unless hTimeInstant[:instantNames].empty?
                     json.dateTime instantString unless instantString == ''
                     # duration
                  end

               end # build
            end # TimeInstant

         end
      end
   end
end
