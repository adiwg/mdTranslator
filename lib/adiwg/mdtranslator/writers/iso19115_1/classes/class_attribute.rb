# ISO <<Class>> attribute group
# 19115-1 writer output in XML

# History:
#  Stan Smith 2019-04-08 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_rangeDimension'
require_relative 'class_sampleDimension'
require_relative 'class_mdBand'
require_relative 'class_miBand'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class Attribute

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hAttribute, inContext = nil)

                  # classes used
                  rangeClass = MD_RangeDimension.new(@xml, @hResponseObj)
                  sampleClass = MD_SampleDimension.new(@xml, @hResponseObj)
                  mdBandClass = MD_Band.new(@xml, @hResponseObj)
                  miBandClass = MI_Band.new(@xml, @hResponseObj)

                  outContext = 'attribute'
                  outContext = inContext + ' attribute' unless inContext.nil?

                  unless hAttribute.empty?

                     # determine attribute classes to output
                     attributeTag = nil
                     unless hAttribute[:sequenceIdentifier].nil? &&
                        hAttribute[:sequenceIdentifierType].nil? &&
                        hAttribute[:attributeDescription].nil? &&
                        hAttribute[:attributeIdentifiers].nil?
                        attributeTag = 'mrc:MD_RangeDimension'
                     end
                     unless hAttribute[:maxValue].nil? &&
                        hAttribute[:minValue].nil? &&
                        hAttribute[:units].nil? &&
                        hAttribute[:scaleFactor].nil? &&
                        hAttribute[:offset].nil? &&
                        hAttribute[:meanValue].nil? &&
                        hAttribute[:numberOfValues].nil? &&
                        hAttribute[:standardDeviation].nil? &&
                        hAttribute[:bitsPerValue].nil?
                        attributeTag = 'mrc:MD_SampleDimension'
                     end
                     unless hAttribute[:boundMin].nil? &&
                        hAttribute[:boundMax].nil? &&
                        hAttribute[:boundUnits].nil? &&
                        hAttribute[:peakResponse].nil? &&
                        hAttribute[:toneGradations].nil?
                        attributeTag = 'mrc:MD_Band'
                     end
                     unless hAttribute[:bandBoundaryDefinition].nil? &&
                        hAttribute[:nominalSpatialResolution].nil? &&
                        hAttribute[:transferFunctionType].nil? &&
                        hAttribute[:transmittedPolarization].nil? &&
                        hAttribute[:detectedPolarization].nil?
                        attributeTag = 'mrc:MI_Band'
                     end

                     unless attributeTag.nil?
                        @xml.tag!(attributeTag) do
                           if attributeTag == 'mrc:MD_RangeDimension'
                              rangeClass.writeXML(hAttribute, outContext)
                           end
                           if attributeTag == 'mrc:MD_SampleDimension'
                              rangeClass.writeXML(hAttribute, outContext)
                              sampleClass.writeXML(hAttribute, outContext)
                           end
                           if attributeTag == 'mrc:MD_Band'
                              rangeClass.writeXML(hAttribute, outContext)
                              sampleClass.writeXML(hAttribute, outContext)
                              mdBandClass.writeXML(hAttribute)
                           end
                           if attributeTag == 'mrc:MI_Band'
                              rangeClass.writeXML(hAttribute, outContext)
                              sampleClass.writeXML(hAttribute, outContext)
                              mdBandClass.writeXML(hAttribute)
                              miBandClass.writeXML(hAttribute)
                           end
                        end
                     end
                     if attributeTag.nil?
                        @NameSpace.issueWarning(42, 'mrc:attribute', outContext)
                     end

                  end

               end # writeXML
            end # Attribute

         end
      end
   end
end
