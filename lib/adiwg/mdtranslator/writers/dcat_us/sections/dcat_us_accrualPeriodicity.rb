require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module AccrualPeriodicity

               def self.build(intObj)

                  frequency_mapping = {
                     'decennial' => 'R/P10Y',
                     'quadrennial' => 'R/P4Y',
                     'annual' => 'R/P1Y',
                     'bimonthly' => 'R/P2M or R/P0.5M',
                     'semiweekly' => 'R/P3.5D',
                     'daily' => 'R/P1D',
                     'biweekly' => 'R/P2W or R/P0.5W',
                     'semiannual' => 'R/P6M',
                     'biennial' => 'R/P2Y',
                     'triennial' => 'R/P3Y',
                     'three times a week' => 'R/P0.33W',
                     'three times a month' => 'R/P0.33M',
                     'continuously updated' => 'R/PT1S',
                     'monthly' => 'R/P1M',
                     'quarterly' => 'R/P3M',
                     'semimonthly' => 'R/P0.5M',
                     'three times a year' => 'R/P4M',
                     'weekly' => 'R/P1W',
                     'hourly' => 'R/PT1H'
                  }

                  frequency = intObj[:metadata][:metadataInfo][:metadataMaintenance][:frequency]
                  
                  unless frequency.nil?
                     frequency_code = frequency_mapping[frequency.downcase]
                  end
                  return frequency_code
                end                

            end
         end
      end
   end
end
