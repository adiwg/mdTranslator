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
               describedBy = DescribedBy.build(intObj)
               isPartOf = IsPartOf.build(intObj)
               theme = Theme.build(intObj)
               references = References.build(intObj)
               landingPage = LandingPage.build(intObj)
               systemOfRecords = SystemOfRecords.build(intObj)

               @Namespace = ADIWG::Mdtranslator::Writers::Dcat_us

               Jbuilder.new do |json|
                  json.set!('@type', 'dcat:Dataset')
                  json.set!('dcat:title', title)
                  json.set!('dcat:description', description)
                  json.set!('dcat:keyword', keyword)
                  json.set!('dcat:modified', modified)
                  json.set!('dcat:publisher', publisher) 
                  json.set!('dcat:contactPoint', contactPoint)
                  json.set!('dcat:identifier', identifier)
                  json.set!('dcat:accessLevel', accessLevel)
                  # json.set!('dcat:bureauCode', 'ToDo')
                  # json.set!('dcat:programCode', 'ToDo')
                  json.set!('dcat:distribution', distribution)

                  json.set!('dcat:license', license)
                  json.set!('dcat:rights', rights)
                  json.set!('dcat:spatial', spatial)
                  json.set!('dcat:temporal', temporal)

                  json.set!('dcat:issued', issued)
                  # json.set!('dcat:accrualPeriodicity', metadataInfo[:metadataMaintenance][:maintenanceFrequency])
                  # json.set!('dcat:language', metadataInfo[:metadataLocales][0][:languageCode])
                  # json.set!('dcat:dataQuality', metadataInfo[:metadataMaintenance][:maintenanceNote])
                  json.set!('dcat:theme', theme)
                  json.set!('dcat:references', references)
                  json.set!('dcat:landingPage', landingPage)
                  json.set!('dcat:isPartOf', isPartOf)
                  json.set!('dcat:systemOfRecords', systemOfRecords)
                  # json.set!('dcat:primaryITInvestmentUII', metadataInfo[:metadataId])
                  json.set!('dcat:describedBy', describedBy)
                  # json.set!('dcat:describedByType', metadataInfo[:metadataOnlineOptions][0][:olResProtocol])
                  # json.set!('dcat:conformsTo', metadataInfo[:metadataStandards][0][:standardName])
               end
            end
         end
      end
   end
end