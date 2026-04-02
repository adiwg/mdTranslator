# unpack landingPage
# Reader - DCAT-US to internal data structure
# Maps 'landingPage' URL to resourceInfo.citation.onlineResources[function=landingPage]

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module LandingPage

               def self.unpack(hDataset, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hCitation unless hDataset.has_key?('landingPage')

                  landing_page = hDataset['landingPage']
                  return hCitation if landing_page.nil? || landing_page == ''

                  hOlRes = intMetadataClass.newOnlineResource
                  hOlRes[:olResURI] = landing_page
                  hOlRes[:olResFunction] = 'landingPage'
                  hCitation[:onlineResources] << hOlRes

                  return hCitation

               end

            end

         end
      end
   end
end
