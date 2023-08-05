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
                  lastDateIndex = dates.length - 1
                  modified = dates[lastDateIndex][:date]
                  return modified
               end
               
            end
         end
      end
   end
end
