require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Format
          def self.build(intObj)
            Jbuilder.new do |json|
              json.formatName intObj[:formatName]
              json.version intObj[:formatVersion]
              json.compressionMethod intObj[:compressionMethod] unless intObj[:compressionMethod].nil?
            end
          end
        end
      end
    end
  end
end
