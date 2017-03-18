# mdJson 2.0 writer - keyword object

# History:
#   Stan Smith 2017-03-18 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module KeywordObject

               def self.build(hKeyword)

                  Jbuilder.new do |json|
                     json.keyword hKeyword[:keyword]
                     json.keywordId hKeyword[:keywordId]
                  end

               end # build
            end # KeywordObject

         end
      end
   end
end
