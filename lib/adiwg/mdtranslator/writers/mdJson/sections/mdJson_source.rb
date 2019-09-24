# mdJson 2.0 writer - source

# History:
#  Stan Smith 2019-09-24 support for LE_Source
#  Stan Smith 2017-03-19 original script

require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_spatialResolution'
require_relative 'mdJson_spatialReference'
require_relative 'mdJson_processStep'
require_relative 'mdJson_scope'
require_relative 'mdJson_identifier'
require_relative 'mdJson_nominalResolution'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Source

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hSource)

                  Jbuilder.new do |json|
                     json.sourceId hSource[:sourceId]
                     json.description hSource[:description]
                     json.sourceCitation Citation.build(hSource[:sourceCitation]) unless hSource[:sourceCitation].empty?
                     json.metadataCitation @Namespace.json_map(hSource[:metadataCitations], Citation)
                     json.spatialResolution SpatialResolution.build(hSource[:spatialResolution]) unless hSource[:spatialResolution].empty?
                     json.referenceSystem SpatialReference.build(hSource[:referenceSystem]) unless hSource[:referenceSystem].empty?
                     json.sourceProcessStep @Namespace.json_map(hSource[:sourceSteps], ProcessStep)
                     json.scope Scope.build(hSource[:scope]) unless hSource[:scope].empty?
                     json.processedLevel Identifier.build(hSource[:processedLevel]) unless hSource[:processedLevel].empty?
                     json.resolution NominalResolution.build(hSource[:resolution]) unless hSource[:resolution].empty?
                  end

               end # build
            end # Source

         end
      end
   end
end
