# unpack primaryITInvestmentUII
# Reader - DCAT-US to internal data structure
# Maps 'primaryITInvestmentUII' to metadataInfo.metadataIdentifier.identifier

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module PrimaryITInvestmentUII

               def self.unpack(hDataset, hMetadataInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hMetadataInfo unless hDataset.has_key?('primaryITInvestmentUII')

                  uii = hDataset['primaryITInvestmentUII']
                  return hMetadataInfo if uii.nil? || uii == ''

                  hIdentifier = intMetadataClass.newIdentifier
                  hIdentifier[:identifier] = uii
                  hMetadataInfo[:metadataIdentifier] = hIdentifier

                  return hMetadataInfo

               end

            end

         end
      end
   end
end
