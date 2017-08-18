# Reader - fgdc to internal data structure
# unpack fgdc publication

# History:
#  Stan Smith 2017-08-17 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Publication

               def self.unpack(xPubInfo, hResponseObj)

                  return nil

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hSeries = intMetadataClass.newSeries

                  # publication 8.8.1 (pubplace) - publication place
                  place = xPubInfo.xpath('./pubplace').text
                  unless place.empty?
                     hSeries[:seriesName] = place
                  end

                  # publication 8.8.2 (publish) - publisher
                  publisher = xPubInfo.xpath('./publish').text
                  unless publisher.empty?
                     hSeries[:seriesIssue] = publisher
                  end

                  return hSeries

               end

            end

         end
      end
   end
end
