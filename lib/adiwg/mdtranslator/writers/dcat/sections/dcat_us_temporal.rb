module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Temporal

               def self.build(intObj)
                  resourceInfo = intObj.dig(:metadata, :resourceInfo)
                  extent = resourceInfo&.dig(:extents, 0)
                  temporalExtents = extent&.dig(:temporalExtents)
                
                  if temporalExtents
                    temporalExtents.each do |temporalExtent|
                      timePeriod = temporalExtent&.dig(:timePeriod)
                      next unless timePeriod
                
                      startDateHash = timePeriod[:startDateTime]
                      endDateHash = timePeriod[:endDateTime]
                      
                      startDate = startDateHash&.dig(:dateTime)
                      endDate = endDateHash&.dig(:dateTime)
                
                      if startDate && endDate
                        return "#{startDate}/#{endDate}"
                      elsif startDate
                        return startDate
                      elsif endDate
                        return endDate
                      end
                    end
                  end
                
                  nil
               end

            end
         end
      end
   end
end
