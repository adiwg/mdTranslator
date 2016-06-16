require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Phone
          def self.build(intObj)
            Jbuilder.new do |json|
              json.phoneName intObj[:phoneName]
              json.phoneNumber intObj[:phoneNumber]
              json.service([intObj[:phoneServiceType]])
            end
          end
        end
      end
    end
  end
end
