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

                  # series 8.7.1 (sername) - series name
                  name = xSerInfo.xpath('./sername').text
                  unless name.empty?
                     hSeries[:seriesName] = name
                  end

                  # series 8.7.2 (issue) - series issue
                  issue = xSerInfo.xpath('./issue').text
                  unless issue.empty?
                     hSeries[:seriesIssue] = issue
                  end

                  return hSeries

               end

            end

         end
      end
   end
end
