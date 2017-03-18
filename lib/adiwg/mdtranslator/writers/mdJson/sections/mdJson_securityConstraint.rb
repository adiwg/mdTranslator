# mdJson 2.0 writer - security constraint

# History:
#   Stan Smith 2017-03-17 original script

# TODO complete

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module SecurityConstraint

               def self.build(hSecurity)

                  Jbuilder.new do |json|
                     json.classification hSecurity[:classCode]
                     json.userNote hSecurity[:userNote]
                     json.classificationSystem hSecurity[:classSystem]
                     json.handlingDescription hSecurity[:handling]
                  end

               end # build
            end # SecurityConstraint

         end
      end
   end
end
