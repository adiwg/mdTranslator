# mdJson 2.0 writer - citation

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'
# require_relative 'mdJson_resourceIdentifier'
# require_relative 'mdJson_onlineResource'
# require_relative 'mdJson_dateTime'
# require_relative 'mdJson_responsibleParty'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Citation

               def self.build(hCitation)

                  unless hCitation.nil? || hCitation.empty?
                     Jbuilder.new do |json|
                        json.title hCitation[:title]
                        # json.alternateTitle hCitation[:citAltTitle]
                        # json.date json_map(hCitation[:citDate], DateTime) unless hCitation[:citDate].empty?
                        # json.edition hCitation[:citEdition]
                        # json.identifier json_map(hCitation[:citResourceIds], ResourceIdentifier)
                        # json.responsibleParty json_map(hCitation[:citResponsibleParty], ResponsibleParty)
                        # json.presentationForm(hCitation[:citResourceForms]) unless hCitation[:citResourceForms].empty?
                        # json.onlineResource json_map(hCitation[:citOlResources], OnlineResource)
                     end
                  end

               end # build
            end # citation

         end
      end
   end
end
