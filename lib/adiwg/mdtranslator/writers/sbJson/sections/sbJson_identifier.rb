require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module SbJson
        module Identifier
          def self.build(intObj)
            Jbuilder.new do |json|
              json.type intObj[:identifierType]
              json.scheme intObj[:identifierNamespace] ||
                          unless intObj[:identifierCitation].empty?
                            intObj[:identifierCitation][:citOlResources][0][:olResURI] unless intObj[:identifierCitation][:citOlResources].empty?
                          end
              json.key intObj[:identifier]
            end
          end
        end
      end
    end
  end
end
