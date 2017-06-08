# sbJson 1.0 writer budget

# History:
#  Stan Smith 2017-06-02 original script

require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Budget

               def self.build(aFunding)

                  hBudget = {}
                  hBudget[:className] = 'gov.sciencebase.catalog.item.facet.BudgetFacet'
                  hBudget[:annualBudgets] = []

                  aFunding.each do |hFunding|
                     budget = {}
                     fundingSources = []
                     hFunding[:allocations].each do |hAllocation|
                        hSource = {}
                        hSource[:amount] = hAllocation[:amount] unless hAllocation[:amount].nil?
                        hSource[:matching] = hAllocation[:matching].to_s
                        hSource[:recipient] = hAllocation[:recipientId] unless hAllocation[:recipientId].nil?
                        hSource[:source] = hAllocation[:sourceId] unless hAllocation[:sourceId].nil?
                        fundingSources << hSource
                     end
                     unless fundingSources.empty?
                        budget[:fundingSources] = fundingSources
                     end

                     # give priority to ending dateTime
                     # write year only
                     # use fiscal year beginning October 1
                     unless hFunding[:timePeriod].empty?
                        unless hFunding[:timePeriod][:startDateTime].empty?
                           startDateTime = hFunding[:timePeriod][:startDateTime][:dateTime]
                        end
                        unless hFunding[:timePeriod][:endDateTime].empty?
                           endDateTime = hFunding[:timePeriod][:endDateTime][:dateTime]
                        end
                        dateTime = endDateTime.nil? ? startDateTime : endDateTime
                        unless dateTime.nil?
                           year = AdiwgDateTimeFun.stringDateFromDateTime(dateTime, 'Y')
                           if dateTime.month > 9
                              year = year.to_i
                              year += 1
                           end
                           budget[:year] = year.to_s
                        end
                     end

                     hBudget[:annualBudgets] << budget

                  end

                  hBudget

               end

            end

         end
      end
   end
end
