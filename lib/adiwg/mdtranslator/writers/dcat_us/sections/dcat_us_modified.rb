module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Modified

               def self.build(intObj)
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  citation = resourceInfo[:citation]
                  dates = citation[:dates]

                  mostRecentDate = nil

                  dates.each do |date|
                     if date[:dateType] == "lastUpdated" || date[:dateType] == "lastRevised" || date[:dateType] == "revision"
                        if mostRecentDate.nil? || date[:date] > mostRecentDate
                           mostRecentDate = date[:date]
                        end
                     end
                  end

                  return mostRecentDate
               end               

            end
         end
      end
   end
end
