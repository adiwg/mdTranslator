# mdJson 2.0 writer - citation

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_dateTime'
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

                  unless hCitation.nil? || hCitation.empty?
                     Jbuilder.new do |json|
                        json.title hCitation[:title]
                        json.alternateTitle hCitation[:alternateTitles] unless hCitation[:alternateTitles].empty?
                        json.date hCitation[:dates].map { |obj| DateTime.build(obj).attributes! }
                        json.edition hCitation[:edition]
                        json.responsibleParty hCitation[:responsibleParties].map { |obj| ResponsibleParty.build(obj).attributes! }
                        json.presentationForm hCitation[:presentationForms] unless hCitation[:presentationForms].empty?
                        json.identifier hCitation[:identifiers].map { |obj| Identifier.build(obj).attributes! }
                        json.series Series.build(hCitation[:series]) unless hCitation[:series].empty?
                        json.otherCitationDetails hCitation[:otherDetails] unless hCitation[:otherDetails].empty?
                        json.onlineResource hCitation[:onlineResources].map { |obj| OnlineResource.build(obj).attributes! }
                        json.graphic hCitation[:browseGraphics].map { |obj| GraphicOverview.build(obj).attributes! }
                     end
                  end

               end # build
            end # citation

         end
      end
   end
end
