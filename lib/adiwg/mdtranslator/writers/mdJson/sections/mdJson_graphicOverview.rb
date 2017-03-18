# mdJson 2.0 writer - graphic overview

# History:
#   Stan Smith 2017-03-12 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_constraint'
require_relative 'mdJson_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module GraphicOverview

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hGraphic)

                  Jbuilder.new do |json|
                     json.fileName hGraphic[:graphicName]
                     json.fileDescription hGraphic[:graphicDescription]
                     json.fileType hGraphic[:graphicType]
                     json.fileConstraint @Namespace.json_map(hGraphic[:graphicConstraints], Constraint)
                     json.fileUri @Namespace.json_map(hGraphic[:graphicURI], OnlineResource)
                  end

               end # build
            end # GraphicOverview

         end
      end
   end
end
