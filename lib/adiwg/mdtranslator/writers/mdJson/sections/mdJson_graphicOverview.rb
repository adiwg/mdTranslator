# mdJson 2.0 writer - graphic

# History:
#   Stan Smith 2017-03-12 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module GraphicOverview

               def self.build(hGraphic)

                  Jbuilder.new do |json|
                     json.fileName (hGraphic[:graphicName])
                     # json.fileDescription (hGraphic[:bGDescription])
                     # json.fileType (hGraphic[:bGType])
                     # json.fileUri (hGraphic[:bGURI])
                  end

               end # build
            end # GraphicOverview

         end
      end
   end
end
