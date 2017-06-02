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
                     budget[:fundingSources] = []
                     hFunding[:allocations].each do |hAllocation|
                        hSource = {}
                        hSource[:amount] = hAllocation[:amount] unless hAllocation[:amount].nil?
                        hSource[:matching] = hAllocation[:matching].to_s
                        hSource[:recipient] = hAllocation[:recipientId] unless hAllocation[:recipientId].nil?
                        hSource[:source] = hAllocation[:sourceId] unless hAllocation[:sourceId].nil?
                        budget[:fundingSources] << hSource
                     end
                     dateTime = hFunding[:timePeriod][:startDateTime][:dateTime]
                     unless dateTime.nil?
                        budget[:year] = AdiwgDateTimeFun.stringDateFromDateTime(dateTime, 'Y')
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
