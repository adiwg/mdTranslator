# mdJson 2.0 writer - spatial representation system

# History:
#   Stan Smith 2017-03-14 original script

# TODO complete tests

require 'jbuilder'
require_relative 'mdJson_grid'
require_relative 'mdJson_vector'
require_relative 'mdJson_georectified'
require_relative 'mdJson_georeferenceable'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module SpatialRepresentation

               def self.build(hSystem)

                  Jbuilder.new do |json|
                     json.gridRepresentation Grid.build(hSystem[:gridRepresentation]) unless hSystem[:gridRepresentation].empty?
                     json.vectorRepresentation Vector.build(hSystem[:vectorRepresentation]) unless hSystem[:vectorRepresentation].empty?
                     json.georectifiedRepresentation Georectified.build(hSystem[:georectifiedRepresentation]) unless hSystem[:georectifiedRepresentation].empty?
                     json.georeferenceableRepresentation Georeferenceable.build(hSystem[:georeferenceableRepresentation]) unless hSystem[:georeferenceableRepresentation].empty?
                  end

               end # build
            end # SpatialReference

         end
      end
   end
end
