# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'
require_relative 'dcat_us_id'
require_relative 'dcat_us_keyword'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us

            def self.build(intObj, responseObj)
               metadataInfo = intObj[:metadata][:metadataInfo]
               resourceInfo = intObj[:metadata][:resourceInfo]
               citation = resourceInfo[:citation]

               metaId = Id.build(intObj)
               keyword = Keyword.build(intObj)

               datasetArray = [{
                  id: metaId,
                  type: 'dcat:Dataset',
                  title: citation[:title],
                  description: resourceInfo[:abstract],
                  keyword: keyword,
               }]

               @Namespace = ADIWG::Mdtranslator::Writers::Dcat_us

               Jbuilder.new do |json|
                  json.set!('@context', 'http://www.w3.org/ns/dcat#')
                  json.set!('@id', metaId)
                  json.set!('@type', 'dcat:Catalog')
                  json.set!('title', metadataInfo[:metadataTitle])
                  json.conformsTo 'http://project-open-data.cio.gov/v1.1/schema'
                  json.describedBy 'http://project-open-data.cio.gov/v1.1/schema/catalog.json'
                  json.dataset do
                     json.array! datasetArray do |data|
                        json.set!('@id', data[:id])
                        json.set!('@type', data[:type])
                        json.title data[:title]
                        json.description data[:description]
                        json.keyword data[:keyword]
                     end
                  end
               end
            end

         end
      end
   end
end
