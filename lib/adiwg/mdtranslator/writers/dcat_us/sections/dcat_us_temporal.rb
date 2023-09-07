module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Temporal

               def self.build(intObj)
                  resourceInfo = intObj.dig(:metadata, :resourceInfo)
                  extent = resourceInfo&.dig(:extents, 0)
                  temporalExtent = extent&.dig(:temporalExtents, 0)
                  timePeriod = temporalExtent&.dig(:timePeriod)

                  if timePeriod
                    startDate = timePeriod[:startDateTime]
                    endDate = timePeriod[:endDateTime]

                    if startDate && endDate
                      return "#{startDate}/#{endDate}"
                    elsif startDate
                      return startDate
                    elsif endDate
                      return endDate
                    end
                  end

                  nil
               end           

            end
         end
      end
   end
end
