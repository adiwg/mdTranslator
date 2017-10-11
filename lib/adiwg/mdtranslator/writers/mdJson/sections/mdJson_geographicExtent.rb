# mdJson 2.0 writer - geographic extent

# History:
#  Stan Smith 2017-09-28 add description to support fgdc
#  Stan Smith 2017-03-15 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_boundingBox'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module GeographicExtent

               def self.build(hGeographic)

                  Jbuilder.new do |json|
                     json.description hGeographic[:description]
                     json.containsData hGeographic[:containsData]
                     json.identifier Identifier.build(hGeographic[:identifier]) unless hGeographic[:identifier].empty?
                     json.boundingBox BoundingBox.build(hGeographic[:boundingBox]) unless hGeographic[:boundingBox].empty?
                     json.geographicElement hGeographic[:nativeGeoJson]
                  end

               end # build
            end # GeographicExtent

         end
      end
   end
end
