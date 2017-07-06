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

                  @Namespace = ADIWG::Mdtranslator::Writers::SbJson

                  hBudget = {}
                  hBudget[:className] = 'gov.sciencebase.catalog.item.facet.BudgetFacet'
                  hBudget[:annualBudgets] = []

                  aFunding.each do |hFunding|
                     budget = {}

                     # funding sources
                     fundingSources = []
                     total = 0.0
                     hFunding[:allocations].each do |hAllocation|
                        hSource = {}
                        hSource[:amount] = hAllocation[:amount] unless hAllocation[:amount].nil?
                        total += hAllocation[:amount] unless hAllocation[:amount].nil?
                        hSource[:matching] = hAllocation[:matching].to_s

                        # recipient id
                        unless hAllocation[:recipientId].nil?
                           hContact = @Namespace.get_contact_by_id(hAllocation[:recipientId])
                           unless hContact.empty?
                              hSource[:recipient] = hContact[:name]
                           end
                        end

                        # source id
                        unless hAllocation[:sourceId].nil?
                           hContact = @Namespace.get_contact_by_id(hAllocation[:sourceId])
                           unless hContact.empty?
                              hSource[:source] = hContact[:name]
                           end
                        end

                        fundingSources << hSource
                     end
                     unless fundingSources.empty?
                        budget[:fundingSources] = fundingSources
                     end

                     # total funds
                     unless total == 0.0
                        budget[:totalFunds] = total
                     end

                     # year
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
                              year.succ!
                           end
                           budget[:year] = year
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
