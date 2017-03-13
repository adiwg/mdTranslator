# mdJson 2.0 writer - dictionary

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_responsibleParty'
# require_relative 'mdJson_domain'
# require_relative 'mdJson_entity'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Dictionary

               def self.build(hDictionary)

                  Jbuilder.new do |json|
                     json.citation Citation.build(hDictionary[:citation])
                     json.subject(hDictionary[:subjects]) unless hDictionary[:subjects].empty?
                     json.responsibleParty ResponsibleParty.build(hDictionary[:responsibleParty])
                     # json.dictionaryInfo do
                     #     dict = hDictionary[:dictionaryInfo]
                     #     json.citation Citation.build(dict[:dictCitation])
                     #     json.resourceType dict[:dictResourceType]
                     #     json.description dict[:dictDescription]
                     #     json.language dict[:dictLanguage]
                     #     json.includedWithDataset dict[:includedWithDataset]
                     # end unless hDictionary[:dictionaryInfo].empty?
                     # json.domain json_map(hDictionary[:domains], Domain)
                     # json.entity json_map(hDictionary[:entities], Entity)
                  end

               end # build
            end # Dictionary

         end
      end
   end
end
