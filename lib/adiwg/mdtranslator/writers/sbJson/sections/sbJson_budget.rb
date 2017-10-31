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

                     # federal fiscal year
                     # compute federal fiscal year for timePeriod of funding
                     # use federal fiscal year beginning October 1
                     # if timePeriod occupies more than one fiscal year, use only ending period

                     # if ending date month 1-9 year = year
                     # if ending date month 10-12 year = +1
                     # if no ending date use starting year with same rules

                     # dates will be encoded as zulu when saved
                     # ... add one day to starting date for eastern hemisphere dateTime
                     # ... subtract one day from ending date for western hemisphere dateTime
                     startMonth = nil
                     startYear = nil
                     endMonth = nil
                     endYear = nil
                     unless hFunding[:timePeriod].empty?
                        unless hFunding[:timePeriod][:startDateTime].empty?
                           startDateTime = hFunding[:timePeriod][:startDateTime][:dateTime]
                           date = startDateTime.to_date + 1
                           startMonth = date.month
                           startYear = date.year
                        end
                        unless hFunding[:timePeriod][:endDateTime].empty?
                           endDateTime = hFunding[:timePeriod][:endDateTime][:dateTime]
                           date = endDateTime.to_date - 1
                           endMonth = date.month
                           endYear = date.year
                        end
                        if endYear.nil?
                           month = startMonth
                           year = startYear
                        else
                           month = endMonth
                           year = endYear
                        end
                        if month > 9
                           year += 1
                        end
                        budget[:year] = year.to_s
                     end

                     hBudget[:annualBudgets] << budget
                  end

                  return hBudget

               end

            end

         end
      end
   end
end
