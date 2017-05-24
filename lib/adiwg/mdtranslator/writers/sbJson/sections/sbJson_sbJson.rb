# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-12 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'sbJson_id'
require_relative 'sbJson_citation'
require_relative 'sbJson_identifier'
require_relative 'sbJson_rights'
require_relative 'sbJson_provenance'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            def self.build(intObj, responseObj)

               metadataInfo = intObj[:metadata][:metadataInfo]
               resourceInfo = intObj[:metadata][:resourceInfo]
               hCitation = resourceInfo[:citation]

               @Namespace = ADIWG::Mdtranslator::Writers::SbJson

               Jbuilder.new do |json|

                  # id
                  json.id Id.build(intObj)

                  # title / alternateTitles (incorporates subTitle)
                  unless hCitation.empty?
                     json.title hCitation[:title]
                     json.alternateTitles hCitation[:alternateTitles] unless hCitation[:alternateTitles].empty?
                  end

                  # body / summary
                  json.body resourceInfo[:abstract]
                  json.summary resourceInfo[:shortAbstract]

                  # citation / identifier
                  unless hCitation.empty?
                     json.citation Citation.build(hCitation)
                     json.identifiers @Namespace.json_map(hCitation[:identifiers], Identifier)
                  end

                  # purpose
                  json.purpose resourceInfo[:purpose]

                  # rights
                  unless resourceInfo[:constraints].empty?
                     json.rights Rights.build(resourceInfo[:constraints])
                  end

                  # provenance
                  json.provenance Provenance.build(metadataInfo)

               end

            end

         end
      end
   end
end
