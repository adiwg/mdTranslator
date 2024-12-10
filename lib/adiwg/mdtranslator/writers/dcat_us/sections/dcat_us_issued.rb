require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Issued

               def self.build(intObj)
                  dates = intObj[:metadata][:resourceInfo][:citation][:dates].map { |obj| obj[:date] }
                  earliest_date = dates.min
                  return earliest_date
                end
                
            end
         end
      end
   end
end
