# ISO <<Class>> attribute group
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-11-29 original script.

require_relative 'class_rangeDimension'
require_relative 'class_mdBand'
require_relative 'class_miBand'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class Attribute

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hAttribute)

                  # classes used
                  rangeClass = MD_RangeDimension.new(@xml, @hResponseObj)
                  mdBandClass = MD_Band.new(@xml, @hResponseObj)
                  miBandClass = MI_Band.new(@xml, @hResponseObj)

                  # determine attribute classes to write
                  if !(hAttribute[:bandBoundaryDefinition].nil? &&
                     hAttribute[:nominalSpatialResolution].nil? &&
                     hAttribute[:transferFunctionType].nil? &&
                     hAttribute[:transmittedPolarization].nil? &&
                     hAttribute[:detectedPolarization].nil?)
                     dimClass = 'gmi:MI_Band'
                  elsif !(hAttribute[:maxValue].nil? &&
                     hAttribute[:minValue].nil? &&
                     hAttribute[:units].nil? &&
                     hAttribute[:peakResponse].nil? &&
                     hAttribute[:bitsPerValue].nil? &&
                     hAttribute[:toneGradations].nil? &&
                     hAttribute[:scaleFactor].nil? &&
                     hAttribute[:offset].nil?)
                     dimClass = 'gmd:MD_Band'
                  else
                     dimClass = 'gmd:MD_RangeDimension'
                  end

                  @xml.tag!(dimClass) do

                     if dimClass == 'gmi:MI_Band'
                        rangeClass.writeXML(hAttribute)
                        mdBandClass.writeXML(hAttribute)
                        miBandClass.writeXML(hAttribute)
                     elsif dimClass =='gmd:MD_Band'
                        rangeClass.writeXML(hAttribute)
                        mdBandClass.writeXML(hAttribute)
                     else
                        rangeClass.writeXML(hAttribute)
                     end

                  end # dimClass tag

               end # writeXML
            end # AttributeGroup class

         end
      end
   end
end
