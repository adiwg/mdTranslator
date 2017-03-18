# mdJson 2.0 writer - keyword

# History:
#   Stan Smith 2017-03-18 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_keywordObject'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Keyword

               def self.build(hKeyword)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.keyword @Namespace.json_map(hKeyword[:keywords], KeywordObject)
                     json.keywordType hKeyword[:keywordType]
                     json.thesaurus Citation.build(hKeyword[:thesaurus]) unless hKeyword[:thesaurus].empty?
                  end

               end # build
            end # Keyword

         end
      end
   end
end
