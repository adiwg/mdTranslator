# Reader - fgdc to internal data structure
# unpack fgdc series

# History:
#  Stan Smith 2017-08-17 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Series

               def self.unpack(xSerInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hSeries = intMetadataClass.newSeries

                  # series 8.7.1 (sername) - series name (required)
                  name = xSerInfo.xpath('./sername').text
                  unless name.empty?
                     hSeries[:seriesName] = name
                  end
                  if name.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC citation series name is missing'
                  end

                  # series 8.7.2 (issue) - series issue (required)
                  issue = xSerInfo.xpath('./issue').text
                  unless issue.empty?
                     hSeries[:seriesIssue] = issue
                  end
                  if issue.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC citation series issue is missing'
                  end

                  return hSeries

               end

            end

         end
      end
   end
end
