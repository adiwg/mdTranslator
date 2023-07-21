# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'
require_relative 'dcat_us_keyword'
require_relative 'dcat_us_publisher'
require_relative 'dcat_us_contact_point'
require_relative 'dcat_us_identifier'
require_relative 'dcat_us_distribution'
require_relative 'dcat_us_spatial'
require_relative 'dcat_us_temporal'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us

            def self.build(intObj, responseObj)
               metadataInfo = intObj[:metadata][:metadataInfo]
               resourceInfo = intObj[:metadata][:resourceInfo]
               citation = resourceInfo[:citation]

               title = citation[:title]
               description = citation[:abstract]
               keyword = Keyword.build(intObj)
               modified = citation[:dates][0][:date] # ToDo: create Date section
               publisher = Publisher.build(intObj)
               contactPoint = ContactPoint.build(intObj)
               identifier = Identifier.build(intObj)
               distribution = Distribution.build(intObj)
               spatial = Spatial.build(intObj)
               temporal = Temporal.build(intObj)
               puts 'temporal'
               puts temporal
               puts

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
                  json.set!('dcat:accessLevel', 'public')
                  json.set!('dcat:bureauCode', 'ToDo')
                  json.set!('dcat:programCode', 'ToDo')
                  json.set!('dcat:distribution', distribution)

                  # json.set!('dcat:license', metadataInfo[:metadataUseConstraints][0][:useLimitation])
                  # json.set!('dcat:rights', metadataInfo[:metadataUseConstraints][0][:useLimitation])
                  json.set!('dcat:spatial', spatial)
                  json.set!('dcat:temporal', temporal)

                  # json.set!('dcat:issued', metadataInfo[:metadataDates][0][:date])
                  # json.set!('dcat:accrualPeriodicity', metadataInfo[:metadataMaintenance][:maintenanceFrequency])
                  # json.set!('dcat:language', metadataInfo[:metadataLocales][0][:languageCode])
                  # json.set!('dcat:dataQuality', metadataInfo[:metadataMaintenance][:maintenanceNote])
                  # json.set!('dcat:theme', metadataInfo[:metadataTopics][0][:topicCategory])
                  # json.set!('dcat:references', metadataInfo[:metadataCitation])
                  # json.set!('dcat:landingPage', metadataInfo[:metadataOnlineOptions][0][:olResURI])
                  # json.set!('dcat:isPartOf', metadataInfo[:metadataHierarchy][0][:parentMetadata][:metadataId])
                  # json.set!('dcat:systemOfRecords', metadataInfo[:metadataHierarchy][0][:parentMetadata][:metadataId])
                  # json.set!('dcat:primaryITInvestmentUII', metadataInfo[:metadataId])
                  # json.set!('dcat:describedBy', metadataInfo[:metadataOnlineOptions][0][:olResURI])
                  # json.set!('dcat:describedByType', metadataInfo[:metadataOnlineOptions][0][:olResProtocol])
                  # json.set!('dcat:conformsTo', metadataInfo[:metadataStandards][0][:standardName])
               end
            end
         end
      end
   end
end
