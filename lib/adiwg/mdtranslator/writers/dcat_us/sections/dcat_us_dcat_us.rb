# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'
require_relative 'dcat_us_id'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us

            def self.build(intObj, responseObj)
               metadataInfo = intObj[:metadata][:metadataInfo]
               resourceInfo = intObj[:metadata][:resourceInfo]
               distributorInfo = intObj[:metadata][:distributorInfo]
               hCitation = resourceInfo[:citation]

               datasetArray = [{
                  id: Id.build(intObj),
                  type: 'dcat:Dataset',
                  title: hCitation[:title]
               }]

               @Namespace = ADIWG::Mdtranslator::Writers::Dcat_us

               Jbuilder.new do |json|
                  json.dataset do
                     json.array! datasetArray do |data|
                        json.set!('@id', data[:id])
                        json.set!('@type', data[:type])
                        json.title data[:title]
                     end
                  end
               end
            end

         end
      end
   end
end
