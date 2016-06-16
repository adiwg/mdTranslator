require 'jbuilder'

require_relative 'mdJson_base'
require_relative 'mdJson_citation'
require_relative 'mdJson_domain'
require_relative 'mdJson_entity'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Dictionary
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.dictionaryInfo do
                  dict = intObj[:dictionaryInfo]
                  json.citation Citation.build(dict[:dictCitation])
                  json.resourceType dict[:dictResourceType]
                  json.description dict[:dictDescription]
                  json.language dict[:dictLanguage]
                  json.includedWithDataset dict[:includedWithDataset]
              end unless intObj[:dictionaryInfo].empty?
              json.domain json_map(intObj[:domains], Domain)
              json.entity json_map(intObj[:entities], Entity)
            end
          end
        end
      end
    end
  end
end
