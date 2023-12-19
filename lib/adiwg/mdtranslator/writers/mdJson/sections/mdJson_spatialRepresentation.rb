# mdJson 2.0 writer - spatial representation system

# History:
#   Stan Smith 2017-03-14 original script

require 'jbuilder'
require_relative 'mdJson_gridRepresentation'
require_relative 'mdJson_vectorRepresentation'
require_relative 'mdJson_georectifiedRepresentation'
require_relative 'mdJson_georeferenceableRepresentation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module SpatialRepresentation

               def self.build(hSystem)

                  Jbuilder.new do |json|
                     json.gridRepresentation Grid.build(hSystem[:gridRepresentation]) unless hSystem[:gridRepresentation].nil? || hSystem[:gridRepresentation].empty?
                     json.vectorRepresentation Vector.build(hSystem[:vectorRepresentation]) unless hSystem[:vectorRepresentation].nil? || hSystem[:vectorRepresentation].empty?
                     json.georectifiedRepresentation Georectified.build(hSystem[:georectifiedRepresentation]) unless hSystem[:georectifiedRepresentation].nil? || hSystem[:georectifiedRepresentation].empty?
                     json.georeferenceableRepresentation Georeferenceable.build(hSystem[:georeferenceableRepresentation]) unless hSystem[:georeferenceableRepresentation].nil? || hSystem[:georeferenceableRepresentation].empty?
                  end

               end # build
            end # SpatialReference

         end
      end
   end
end
