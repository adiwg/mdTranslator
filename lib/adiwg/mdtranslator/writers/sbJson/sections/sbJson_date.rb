# sbJson 1.0 writer date

# History:
#  Stan Smith 2017-06-01 original script

require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Date

               def self.build(hCitation)

                  aDates = []

                  # dates
                  hCitation[:dates].each do |hDate|
                     sbDate = {}
                     sbDate[:type] = Codelists.codelist_iso_to_sb('iso_sb_date', :isoCode => hDate[:dateType])
                     sbDate[:dateString] = AdiwgDateTimeFun.stringFromDateObject(hDate)
                     sbDate[:label] = hDate[:description] unless hDate[:description].nil?
                     aDates << sbDate unless sbDate[:type].nil?
                  end

                  aDates

               end

            end

         end
      end
   end
end
