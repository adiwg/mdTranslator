# mdJson 2.0 writer - georeferenceable representation

# History:
#   Stan Smith 2017-03-14 original script

require 'jbuilder'
require_relative 'mdJson_gridRepresentation'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Georeferenceable

               def self.build(hGeoRef)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.scope hGeoRef[:scope]
                     json.gridRepresentation Grid.build(hGeoRef[:gridRepresentation]) unless hGeoRef[:gridRepresentation].empty?
                     json.controlPointAvailable hGeoRef[:controlPointAvailable]
                     json.orientationParameterAvailable hGeoRef[:orientationParameterAvailable]
                     json.orientationParameterDescription hGeoRef[:orientationParameterDescription]
                     json.georeferencedParameter hGeoRef[:georeferencedParameter]
                     json.parameterCitation @Namespace.json_map(hGeoRef[:parameterCitation], Citation)
                     json.scope hGeoRef[:scope]
                  end

               end # build
            end # Georeferenceable

         end
      end
   end
end
