# mdJson 2.0 writer - spatial reference system

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_spatialReferenceParameters'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module SpatialReference

               def self.build(hSystem)

                  Jbuilder.new do |json|
                     json.referenceSystemType hSystem[:systemType]
                     json.referenceSystemIdentifier Identifier.build(hSystem[:systemIdentifier]) unless hSystem[:systemIdentifier].empty?
                     json.referenceSystemWKT hSystem[:systemWKT]
                     json.referenceSystemParameterSet SpatialReferenceParameters.build(hSystem[:systemParameterSet]) unless hSystem[:systemParameterSet].empty?
                  end

               end # build
            end # SpatialReference

         end
      end
   end
end
