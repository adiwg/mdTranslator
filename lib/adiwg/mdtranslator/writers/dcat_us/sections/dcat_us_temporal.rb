# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Temporal

               def self.build(intObj)
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  extent = resourceInfo[:extents][0]
                  temporalExtent = extent[:temporalExtents][0]
                  timeInstant = temporalExtent[:timeInstant]
                  dateTime = timeInstant[:timeInstant][:dateTime]
                  puts 'dateTime'
                  puts dateTime
                  puts
                  return dateTime
               end           

            end
         end
      end
   end
end
