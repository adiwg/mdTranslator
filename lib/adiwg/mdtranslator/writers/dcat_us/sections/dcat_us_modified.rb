# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

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
                  mostRecentDateIndex = nil

                  dates.each_with_index do |date, index|
                     if date[:dateType] == "lastUpdated" || date[:dateType] == "lastRevised" || date[:dateType] == "revision"
                        mostRecentDate = date[:date]
                        mostRecentDateIndex = index
                        break
                     elsif mostRecentDate.nil? || date[:date] > mostRecentDate
                        mostRecentDate = date[:date]
                        mostRecentDateIndex = index
                     end
                  end

                  return mostRecentDate
               end

            end
         end
      end
   end
end
