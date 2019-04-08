# ISO <<Class>> MD_Band attributes
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-08 original script.

require_relative 'class_unitsOfMeasure'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Band

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hAttribute)

                  # classes used
                  uomClass = UnitsOfMeasure.new(@xml, @hResponseObj)

                  # mdBand - bound max {real}
                  unless hAttribute[:boundMax].nil?
                     @xml.tag!('mrc:boundMax') do
                        @xml.tag!('gco:Real', hAttribute[:boundMax])
                     end
                  end
                  if hAttribute[:boundMax].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:boundMax')
                  end

                  # mdBand - bound min {real}
                  unless hAttribute[:boundMin].nil?
                     @xml.tag!('mrc:boundMin') do
                        @xml.tag!('gco:Real', hAttribute[:boundMin])
                     end
                  end
                  if hAttribute[:boundMin].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:boundMin')
                  end

                  # mdBand - units {gml:unitsOfMeasure}
                  unless hAttribute[:boundUnits].nil?
                     @xml.tag!('mrc:boundUnits') do
                        uomClass.writeUnits(hAttribute[:boundUnits])
                     end
                  end
                  if hAttribute[:boundUnits].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:boundUnits')
                  end

                  # mdBand - peak response {real}
                  unless hAttribute[:peakResponse].nil?
                     @xml.tag!('mrc:peakResponse') do
                        @xml.tag!('gco:Real', hAttribute[:peakResponse])
                     end
                  end
                  if hAttribute[:peakResponse].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:peakResponse')
                  end

                  # mdBand - tone gradation {integer}
                  unless hAttribute[:toneGradations].nil?
                     @xml.tag!('mrc:toneGradation') do
                        @xml.tag!('gco:Integer', hAttribute[:toneGradations])
                     end
                  end
                  if hAttribute[:toneGradations].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:toneGradation')
                  end

               end # writeXML
            end # MI_Band attributes

         end
      end
   end
end
