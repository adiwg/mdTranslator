require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Iso19115_3

            module MetadataInformation

               def self.unpack(xMetaInfo, hResponseObj)
                  intMetadataClass = InternalMetadata.new
                  hMetadataInfo = intMetadataClass.newMetadataInfo
                  return hMetadataInfo
               end

            end

         end
      end
   end
end
