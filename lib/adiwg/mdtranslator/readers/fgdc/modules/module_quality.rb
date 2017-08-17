# Reader - fgdc to internal data structure
# unpack fgdc metadata identification

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Identification

               def self.unpack(xIdInfo, hResponseObj)

                  xMetadata = xDoc.xpath('/metadata')

                  # metadata - idinfo > identification information (required)
                  xIdinfo = xMetadata.xpath('//idinfo')
                  puts xIdinfo

               end

            end

         end
      end
   end
end
