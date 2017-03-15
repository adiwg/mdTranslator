# mdJson 2.0 writer - vector object

# History:
#   Stan Smith 2017-03-14 original script

# TODO complete tests

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module VectorObject

               def self.build(hObject)

                  Jbuilder.new do |json|
                     json.objectType hObject[:objectType]
                     json.objectCount hObject[:objectCount]
                  end

               end # build
            end # VectorObject

         end
      end
   end
end
