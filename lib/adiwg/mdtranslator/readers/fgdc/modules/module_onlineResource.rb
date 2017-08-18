# Reader - fgdc to internal data structure
# unpack fgdc online resource

# History:
#  Stan Smith 2017-08-17 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module OnlineResource

               def self.unpack(onLink, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hURI = intMetadataClass.newOnlineResource

                  hURI[:olResURI] = onLink
                  hURI[:olResDesc] = 'Link to resource described in this citation'

                  return hURI

               end

            end

         end
      end
   end
end
