require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Iso19115_3

            module OnlineResource

               def self.unpack(onLink, description, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hURI = intMetadataClass.newOnlineResource

                  hURI[:olResURI] = onLink
                  hURI[:olResDesc] = description

                  return hURI

               end

            end

         end
      end
   end
end
