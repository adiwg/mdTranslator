# mdJson 2.0 writer - dictionary

# History:
#  Stan Smith 2017-11-09 add data dictionary description
#  Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_locale'
require_relative 'mdJson_domain'
require_relative 'mdJson_entity'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Dictionary

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hDictionary)

                  Jbuilder.new do |json|
                     json.description hDictionary[:description]
                     json.subject hDictionary[:subjects] unless hDictionary[:subjects].empty?
                     json.citation Citation.build(hDictionary[:citation]) unless hDictionary[:citation].empty?
                     json.recommendedUse hDictionary[:recommendedUses] unless hDictionary[:recommendedUses].empty?
                     json.locale @Namespace.json_map(hDictionary[:locales], Locale)
                     json.responsibleParty ResponsibleParty.build(hDictionary[:responsibleParty])
                     json.dictionaryFormat hDictionary[:dictionaryFormat]
                     json.dictionaryIncludedWithResource hDictionary[:includedWithDataset]
                     json.domain @Namespace.json_map(hDictionary[:domains], Domain)
                     json.entity @Namespace.json_map(hDictionary[:entities], Entity)
                  end

               end # build
            end # Dictionary

         end
      end
   end
end
