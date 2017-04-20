# mdJson 2.0 writer - attribute group

# History:
#   Stan Smith 2017-03-16 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_attribute'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module AttributeGroup

               def self.build(hGroup)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.attributeContentType hGroup[:attributeContentTypes] unless hGroup[:attributeContentTypes].empty?
                     json.attribute @Namespace.json_map(hGroup[:attributes], Attribute)
                  end

               end # build
            end # AttributeGroup

         end
      end
   end
end
