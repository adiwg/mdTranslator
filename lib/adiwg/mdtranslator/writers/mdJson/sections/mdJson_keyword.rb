require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Keyword
          def self.build(item)
            Jbuilder.new do |json|
              json.keyword (item[:keyword])
              json.keywordType item[:keywordType]
              json.thesaurus Citation.build(item[:keyTheCitation])
            end
          end
        end
      end
    end
  end
end
