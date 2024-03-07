require 'jbuilder'
require_relative 'dcat_us_keyword'
require_relative 'dcat_us_publisher'
require_relative 'dcat_us_contact_point'
require_relative 'dcat_us_identifier'
require_relative 'dcat_us_distribution'
require_relative 'dcat_us_spatial'
require_relative 'dcat_us_temporal'
require_relative 'dcat_us_modified'
require_relative 'dcat_us_access_level'
require_relative 'dcat_us_rights'
require_relative 'dcat_us_license'
require_relative 'dcat_us_issued'
require_relative 'dcat_us_described_by'
require_relative 'dcat_us_is_part_of'
require_relative 'dcat_us_theme'
require_relative 'dcat_us_references'
require_relative 'dcat_us_landing_page'
require_relative 'dcat_us_system_of_records'
require_relative 'dcat_us_description'
require_relative 'dcat_us_language'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us

            def self.build(intObj, responseObj)
               metadataInfo = intObj[:metadata][:metadataInfo]
               resourceInfo = intObj[:metadata][:resourceInfo]
               citation = resourceInfo[:citation]

               title = citation[:title]
               description = Description.build(intObj)
               keyword = Keyword.build(intObj)
               modified = Modified.build(intObj)
               publisher = Publisher.build(intObj)
               contactPoint = ContactPoint.build(intObj)
               accessLevel = AccessLevel.build(intObj)
               identifier = Identifier.build(intObj)
               distribution = Distribution.build(intObj)
               rights = Rights.build(intObj, accessLevel)
               spatial = Spatial.build(intObj)
               temporal = Temporal.build(intObj)
               license = License.build(intObj)
               issued = Issued.build(intObj)
               language = Language.build(intObj)
               describedBy = DescribedBy.build(intObj)
               isPartOf = IsPartOf.build(intObj)
               theme = Theme.build(intObj)
               references = References.build(intObj)
               landingPage = LandingPage.build(intObj)
               systemOfRecords = SystemOfRecords.build(intObj)

               @Namespace = ADIWG::Mdtranslator::Writers::Dcat_us

               Jbuilder.new do |json|
                  json.set!('@type', 'dcat:Dataset')
                  json.set!('title', title)
                  json.set!('description', description)
                  json.set!('keyword', keyword)
                  json.set!('modified', modified)
                  json.set!('publisher', publisher) 
                  json.set!('contactPoint', contactPoint)
                  json.set!('identifier', identifier)
                  json.set!('accessLevel', accessLevel)
                  # json.set!('bureauCode', 'ToDo')
                  # json.set!('programCode', 'ToDo')
                  json.set!('distribution', distribution)

                  json.set!('license', license)
                  json.set!('rights', rights)
                  json.set!('spatial', spatial)
                  json.set!('temporal', temporal)

                  json.set!('issued', issued)
                  # json.set!('accrualPeriodicity', metadataInfo[:metadataMaintenance][:maintenanceFrequency])
                  json.set!('language', language)
                  # json.set!('dataQuality', metadataInfo[:metadataMaintenance][:maintenanceNote])
                  json.set!('theme', theme)
                  json.set!('references', references)
                  json.set!('landingPage', landingPage)
                  json.set!('isPartOf', isPartOf)
                  json.set!('systemOfRecords', systemOfRecords)
                  # json.set!('primaryITInvestmentUII', metadataInfo[:metadataId])
                  json.set!('describedBy', describedBy)
                  # json.set!('describedByType', metadataInfo[:metadataOnlineOptions][0][:olResProtocol])
                  # json.set!('conformsTo', metadataInfo[:metadataStandards][0][:standardName])
               end
            end
         end
      end
   end
end
