# mdJson 2.0 writer - attribute

# History:
#   Stan Smith 2017-03-16 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Attribute

               def self.build(hAttribute)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.sequenceIdentifier hAttribute[:sequenceIdentifier]
                     json.sequenceIdentifierType hAttribute[:sequenceIdentifierType]
                     json.attributeDescription hAttribute[:attributeDescription]
                     json.attributeIdentifier @Namespace.json_map(hAttribute[:attributeIdentifiers], Identifier)
                     json.minValue hAttribute[:minValue]
                     json.maxValue hAttribute[:maxValue]
                     json.units hAttribute[:units]
                     json.scaleFactor hAttribute[:scaleFactor]
                     json.offset hAttribute[:offset]
                     json.meanValue hAttribute[:meanValue]
                     json.numberOfValues hAttribute[:numberOfValues]
                     json.standardDeviation hAttribute[:standardDeviation]
                     json.bitsPerValue hAttribute[:bitsPerValue]
                     json.rangeElementDescription hAttribute[:rangeElementDescription]
                     json.boundMin hAttribute[:boundMin]
                     json.boundMax hAttribute[:boundMax]
                     json.boundUnits hAttribute[:boundUnits]
                     json.peakResponse hAttribute[:peakResponse]
                     json.toneGradations hAttribute[:toneGradations]
                     json.bandBoundaryDefinition hAttribute[:bandBoundaryDefinition]
                     json.nominalSpatialResolution hAttribute[:nominalSpatialResolution]
                     json.transferFunctionType hAttribute[:transferFunctionType]
                     json.transmittedPolarization hAttribute[:transmittedPolarization]
                     json.detectedPolarization hAttribute[:detectedPolarization]
                  end

               end # build
            end # Attribute

         end
      end
   end
end
