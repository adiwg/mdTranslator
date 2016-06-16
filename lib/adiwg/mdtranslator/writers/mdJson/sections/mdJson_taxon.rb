require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Taxon
          def self.build(intObj)
            Jbuilder.new do |json|
              json.taxonRank (intObj[:taxRankName])
              json.taxonValue (intObj[:taxRankValue])
              json.common (intObj[:commonName])
            end
          end
        end
      end
    end
  end
end
