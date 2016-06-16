require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module GraphicOverview
          def self.build(intObj)
            Jbuilder.new do |json|
              json.fileName (intObj[:bGName])
              json.fileDescription (intObj[:bGDescription])
              json.fileType (intObj[:bGType])
              json.fileUri (intObj[:bGURI])
            end
          end
        end
      end
    end
  end
end
