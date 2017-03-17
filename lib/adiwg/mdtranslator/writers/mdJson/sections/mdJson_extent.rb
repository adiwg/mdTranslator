# mdJson 2.0 writer - extent

# History:
#   Stan Smith 2017-03-13 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_geographicExtent'
require_relative 'mdJson_temporalExtent'
require_relative 'mdJson_verticalExtent'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Extent

               def self.build(hExtent)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.description hExtent[:description]
                     json.geographicExtent @Namespace.json_map(hExtent[:geographicExtents], GeographicExtent)
                     json.temporalExtent @Namespace.json_map(hExtent[:temporalExtents], TemporalExtent)
                     json.verticalExtent @Namespace.json_map(hExtent[:verticalExtents], VerticalExtent)
                  end

               end # build
            end # Extent

         end
      end
   end
end
