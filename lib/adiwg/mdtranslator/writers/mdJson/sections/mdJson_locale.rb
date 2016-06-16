require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Locale
          def self.build(intObj)
            Jbuilder.new do |json|
              json.language intObj[:languageCode]
              json.country intObj[:countryCode]
              json.characterSet intObj[:characterEncoding]
            end
          end
        end
      end
    end
  end
end
