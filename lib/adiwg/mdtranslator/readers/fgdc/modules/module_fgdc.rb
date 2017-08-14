# unpack fgdc
# Reader - fgdc to internal data structure

# History:
#  Stan Smith 2017-08-10 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Fgdc

               def self.unpack(xDoc, hResponseObj)

                  aMetadata = xDoc.xpath('/metadata')

               end

            end

         end
      end
   end
end
