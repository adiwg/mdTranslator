# unpack duration
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2016-10-03 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Duration

               def self.unpack(hDuration, responseObj)

                  # return nil object if input is empty
                  if hDuration.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: duration object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDuration = intMetadataClass.newDuration

                  # duration - years
                  if hDuration.has_key?('years')
                     if hDuration['years'].nil?
                        intDuration[:years] = 0
                     else
                        intDuration[:years] = hDuration['years']
                     end
                  else
                     intDuration[:years] = 0
                  end

                  # duration - months
                  if hDuration.has_key?('months')
                     if hDuration['months'].nil?
                        intDuration[:months] = 0
                     else
                        intDuration[:months] = hDuration['months']
                     end
                  else
                     intDuration[:months] = 0
                  end

                  # duration - days
                  if hDuration.has_key?('days')
                     if hDuration['days'].nil?
                        intDuration[:days] = 0
                     else
                        intDuration[:days] = hDuration['days']
                     end
                  else
                     intDuration[:days] = 0
                  end

                  # duration - hours
                  if hDuration.has_key?('hours')
                     if hDuration['hours'].nil?
                        intDuration[:hours] = 0
                     else
                        intDuration[:hours] = hDuration['hours']
                     end
                  else
                     intDuration[:hours] = 0
                  end

                  # duration - minutes
                  if hDuration.has_key?('minutes')
                     if hDuration['minutes'].nil?
                        intDuration[:minutes] = 0
                     else
                        intDuration[:minutes] = hDuration['minutes']
                     end
                  else
                     intDuration[:minutes] = 0
                  end

                  # duration - seconds
                  if hDuration.has_key?('seconds')
                     if hDuration['seconds'].nil?
                        intDuration[:seconds] = 0
                     else
                        intDuration[:seconds] = hDuration['seconds']
                     end
                  else
                     intDuration[:seconds] = 0
                  end

                  # error messages
                  totalDuration = intDuration[:years] +
                     intDuration[:months] +
                     intDuration[:days] +
                     intDuration[:hours] +
                     intDuration[:minutes] +
                     intDuration[:seconds]
                  unless totalDuration > 0
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson duration not specified'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intDuration
               end
            end

         end
      end
   end
end
