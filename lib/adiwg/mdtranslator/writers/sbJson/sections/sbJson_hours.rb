# sbJson 1.0 writer hours

# History:
#  Stan Smith 2017-05-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Hours

               def self.build(aHours)

                  hours = ''

                  aHours.each do |hour|
                     hours += hour + '; '
                  end

                  # clean off last semicolon
                  if hours.length > 2
                     hours = hours[0...-2]
                  end

                  hours

               end

            end

         end
      end
   end
end
