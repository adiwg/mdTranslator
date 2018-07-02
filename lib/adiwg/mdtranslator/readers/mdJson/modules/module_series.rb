# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-25 refactored error and warning messaging
# 	Stan Smith 2016-10-12 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Series

               def self.unpack(hSeries, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hSeries.empty?
                     @MessagePath.issueWarning(760, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intSeries = intMetadataClass.newSeries

                  # series - seriesName
                  if hSeries.has_key?('seriesName')
                     unless hSeries['seriesName'] == ''
                        intSeries[:seriesName] = hSeries['seriesName']
                     end
                  end

                  # series - series issue
                  if hSeries.has_key?('seriesIssue')
                     unless hSeries['seriesIssue'] == ''
                        intSeries[:seriesIssue] = hSeries['seriesIssue']
                     end
                  end

                  # series - issue page
                  if hSeries.has_key?('issuePage')
                     unless hSeries['issuePage'] == ''
                        intSeries[:issuePage] = hSeries['issuePage']
                     end
                  end

                  return intSeries

               end

            end

         end
      end
   end
end
