# sbJson 1.0 writer date

# History:
#  Stan Smith 2017-06-01 original script

require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Date

               def self.build(hResource)

                  aDates = []
                  hCitation = hResource[:citation]

                  # add citation dates to sbJson dates
                  unless hCitation.empty?
                     hCitation[:dates].each do |hDate|
                        sbDate = {}
                        dateType = Codelists.codelist_iso_to_sb('iso_sb_date', :isoCode => hDate[:dateType])

                        # if iso date codes does not map to scienceBase use type = 'Info'
                        if dateType.nil?
                           sbDate[:type] = 'Info'
                           sbDate[:dateString] = AdiwgDateTimeFun.stringFromDateObject(hDate)
                           sbDate[:label] = hDate[:dateType]
                        else
                           sbDate[:type] = dateType
                           sbDate[:dateString] = AdiwgDateTimeFun.stringFromDateObject(hDate)
                           sbDate[:label] = hDate[:description] unless hDate[:description].nil?
                        end

                        aDates << sbDate
                     end
                  end

                  # add resource timePeriod dates to sbJson dates
                  unless hResource[:timePeriod].empty?
                     unless hResource[:timePeriod][:startDateTime].empty?
                        sbDate = {}
                        sbDate[:type] = 'Start'
                        sbDate[:dateString] = AdiwgDateTimeFun.stringFromDateObject(hResource[:timePeriod][:startDateTime])
                        sbDate[:label] = hResource[:timePeriod][:description] unless hResource[:timePeriod][:description].nil?
                        aDates << sbDate
                     end
                     unless hResource[:timePeriod][:endDateTime].empty?
                        sbDate = {}
                        sbDate[:type] = 'End'
                        sbDate[:dateString] = AdiwgDateTimeFun.stringFromDateObject(hResource[:timePeriod][:endDateTime])
                        sbDate[:label] = hResource[:timePeriod][:description] unless hResource[:timePeriod][:description].nil?
                        aDates << sbDate
                     end
                  end

                  if aDates.empty?
                     return nil
                  end

                  aDates

               end

            end

         end
      end
   end
end
