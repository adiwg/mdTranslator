# unpack budget facet
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-25 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Budget

               def self.unpack(hFacet, hMetadata, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                     if hFacet.has_key?('annualBudgets')
                        hFacet['annualBudgets'].each do |hBudget|

                           hFunding = intMetadataClass.newFunding

                           # funding source
                           # ignore source and recipient
                           if hBudget.has_key?('fundingSources')
                              hBudget['fundingSources'].each do |hSource|
                                 hAllocation = intMetadataClass.newAllocation
                                 if hSource.has_key?('amount')
                                    unless hSource['amount'].nil? || hSource == ''
                                       hAllocation[:amount] = hSource['amount']
                                    end
                                 end
                                 if hSource.has_key?('matching')
                                    if !!hSource['matching'] == hSource['matching']
                                       hAllocation[:matching] = hSource['matching']
                                    else
                                       hAllocation[:matching] = false
                                    end
                                 end

                                 hFunding[:allocations] << hAllocation
                              end
                           end

                           # year
                           if hBudget.has_key?('year')
                              unless hBudget['year'].nil? || hBudget['year'] == ''
                                 hPeriod = intMetadataClass.newTimePeriod
                                 hDateTime = intMetadataClass.newDateTime
                                 aReturn = AdiwgDateTimeFun.dateTimeFromString(hBudget['year'])
                                 unless aReturn.nil?
                                    hDateTime[:dateTime] = aReturn[0]
                                    hDateTime[:dateResolution] = aReturn[1]
                                    hPeriod[:endDateTime] = hDateTime
                                    hFunding[:timePeriod] = hPeriod
                                 end
                              end
                           end

                           unless hFunding.empty?
                              hMetadata[:funding] << hFunding
                           end

                        end
                     end

                  return hMetadata

               end

            end

         end
      end
   end
end
