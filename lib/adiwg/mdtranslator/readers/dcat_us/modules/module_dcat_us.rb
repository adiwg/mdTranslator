# unpack DCAT-US catalog or dataset
# Reader - DCAT-US to internal data structure
# Main orchestration module for DCAT-US Schema v1.1

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative '../version'
require_relative 'module_title'
require_relative 'module_description'
require_relative 'module_keyword'
require_relative 'module_modified'
require_relative 'module_issued'
require_relative 'module_publisher'
require_relative 'module_contact_point'
require_relative 'module_identifier'
require_relative 'module_access_level'
require_relative 'module_bureau_code'
require_relative 'module_program_code'
require_relative 'module_distribution'
require_relative 'module_license'
require_relative 'module_rights'
require_relative 'module_spatial'
require_relative 'module_temporal'
require_relative 'module_periodicity'
require_relative 'module_described_by'
require_relative 'module_is_part_of'
require_relative 'module_language'
require_relative 'module_landing_page'
require_relative 'module_primary_it_investment_uii'
require_relative 'module_references'
require_relative 'module_system_of_records'
require_relative 'module_theme'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module DcatUs

               def self.unpack(hDcatUs, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  intObj = intMetadataClass.newBase

                  hMetadata    = intMetadataClass.newMetadata
                  hMetadataInfo = intMetadataClass.newMetadataInfo
                  hResourceInfo = intMetadataClass.newResourceInfo
                  hCitation    = intMetadataClass.newCitation
                  hSchema      = intMetadataClass.newSchema

                  # schema
                  hSchema[:name] = 'dcat_us'
                  hSchema[:version] = ADIWG::Mdtranslator::Readers::Dcat_us::VERSION

                  # Extract the dataset to process (first dataset from catalog or the object itself)
                  hDataset = extract_dataset(hDcatUs)

                  if hDataset.nil?
                     hResponseObj[:readerStructureMessages] << 'ERROR: No dataset found in DCAT-US input'
                     hResponseObj[:readerStructurePass] = false
                     return {}
                  end

                  # title
                  Title.unpack(hDataset, hCitation, hResponseObj)

                  # description
                  Description.unpack(hDataset, hResourceInfo, hResponseObj)

                  # keyword
                  Keyword.unpack(hDataset, hResourceInfo, hResponseObj)

                  # modified
                  Modified.unpack(hDataset, hCitation, hResponseObj)

                  # issued
                  Issued.unpack(hDataset, hCitation, hResponseObj)

                  # publisher (adds contact to intObj[:contacts], party to hCitation)
                  Publisher.unpack(hDataset, hCitation, intObj[:contacts], hResponseObj)

                  # contactPoint (adds contact to intObj[:contacts], party to hResourceInfo)
                  ContactPoint.unpack(hDataset, hResourceInfo, intObj[:contacts], hResponseObj)

                  # identifier
                  Identifier.unpack(hDataset, hCitation, hResponseObj)

                  # landingPage (added to citation.onlineResources)
                  LandingPage.unpack(hDataset, hCitation, hResponseObj)

                  # accessLevel
                  AccessLevel.unpack(hDataset, hResourceInfo, hResponseObj)

                  # bureauCode (adds contacts and responsible parties)
                  BureauCode.unpack(hDataset, hCitation, intObj[:contacts], hResponseObj)

                  # programCode (adds contacts and responsible parties)
                  ProgramCode.unpack(hDataset, hCitation, intObj[:contacts], hResponseObj)

                  # license
                  License.unpack(hDataset, hResourceInfo, hResponseObj)

                  # rights
                  Rights.unpack(hDataset, hResourceInfo, hResponseObj)

                  # spatial
                  Spatial.unpack(hDataset, hResourceInfo, hResponseObj)

                  # temporal (appends to existing extent created by Spatial, or creates new)
                  Temporal.unpack(hDataset, hResourceInfo, hResponseObj)

                  # distribution
                  Distribution.unpack(hDataset, hMetadata, hResponseObj)

                  # accrualPeriodicity
                  AccrualPeriodicity.unpack(hDataset, hMetadataInfo, hResponseObj)

                  # describedBy + describedByType
                  DescribedBy.unpack(hDataset, intObj[:dataDictionaries], hResponseObj)

                  # isPartOf
                  IsPartOf.unpack(hDataset, hMetadata, hResponseObj)

                  # language
                  Language.unpack(hDataset, hMetadataInfo, hResponseObj)

                  # primaryITInvestmentUII
                  PrimaryITInvestmentUII.unpack(hDataset, hMetadataInfo, hResponseObj)

                  # references
                  References.unpack(hDataset, hMetadata, hResponseObj)

                  # systemOfRecords
                  SystemOfRecords.unpack(hDataset, hMetadata, hResponseObj)

                  # theme
                  Theme.unpack(hDataset, hResourceInfo, hResponseObj)

                  # Assemble the internal object
                  hResourceInfo[:citation]      = hCitation
                  hMetadata[:metadataInfo]      = hMetadataInfo
                  hMetadata[:resourceInfo]       = hResourceInfo
                  intObj[:schema]               = hSchema
                  intObj[:metadata]             = hMetadata

                  return intObj

               end

               # Extract the first dataset from a DCAT-US catalog, or return the
               # input object directly if it is already a single dataset.
               def self.extract_dataset(hInput)
                  # Full catalog with dataset array
                  if hInput.has_key?('dataset')
                     datasets = hInput['dataset']
                     return nil if datasets.nil? || datasets.empty?
                     return datasets.first
                  end

                  # Single dataset object
                  return hInput
               end

            end

         end
      end
   end
end
