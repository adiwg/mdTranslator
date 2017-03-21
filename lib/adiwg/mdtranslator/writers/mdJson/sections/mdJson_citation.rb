# mdJson 2.0 writer - citation

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_date'
require_relative 'mdJson_identifier'
require_relative 'mdJson_onlineResource'
require_relative 'mdJson_series'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_graphicOverview'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Citation

               def self.build(hCitation)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  unless hCitation.nil? || hCitation.empty?
                     Jbuilder.new do |json|
                        json.title hCitation[:title]
                        json.alternateTitle hCitation[:alternateTitles] unless hCitation[:alternateTitles].empty?
                        json.date @Namespace.json_map(hCitation[:dates], Date)
                        json.edition hCitation[:edition]
                        json.responsibleParty @Namespace.json_map(hCitation[:responsibleParties], ResponsibleParty)
                        json.presentationForm hCitation[:presentationForms] unless hCitation[:presentationForms].empty?
                        json.identifier @Namespace.json_map(hCitation[:identifiers], Identifier)
                        json.series Series.build(hCitation[:series]) unless hCitation[:series].empty?
                        json.otherCitationDetails hCitation[:otherDetails] unless hCitation[:otherDetails].empty?
                        json.onlineResource @Namespace.json_map(hCitation[:onlineResources], OnlineResource)
                        json.graphic @Namespace.json_map(hCitation[:browseGraphics], GraphicOverview)
                     end
                  end

               end # build
            end # citation

         end
      end
   end
end
