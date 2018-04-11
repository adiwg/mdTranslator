# ISO <<Class>> MD_Band attributes
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-08-27 original script.

require_relative 'class_unitsOfMeasure'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Band

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hAttribute)

                  # classes used
                  uomClass = UnitsOfMeasure.new(@xml, @hResponseObj)

                  # mdBand - max value
                  s = hAttribute[:maxValue]
                  unless s.nil?
                     @xml.tag!('gmd:maxValue') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:maxValue')
                  end

                  # mdBand - min value
                  s = hAttribute[:minValue]
                  unless s.nil?
                     @xml.tag!('gmd:minValue') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:minValue')
                  end

                  # mdBand - units
                  s = hAttribute[:units]
                  unless s.nil?
                     @xml.tag!('gmd:units') do
                        uomClass.writeUnits(s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:units')
                  end

                  # mdBand - peak response
                  s = hAttribute[:peakResponse]
                  unless s.nil?
                     @xml.tag!('gmd:peakResponse') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:peakResponse')
                  end

                  # mdBand - bits per value
                  s = hAttribute[:bitsPerValue]
                  unless s.nil?
                     @xml.tag!('gmd:bitsPerValue') do
                        @xml.tag!('gco:Integer', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:bitsPerValue')
                  end

                  # mdBand - tone gradation
                  s = hAttribute[:toneGradations]
                  unless s.nil?
                     @xml.tag!('gmd:toneGradation') do
                        @xml.tag!('gco:Integer', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:toneGradation')
                  end

                  # mdBand - scale factor
                  s = hAttribute[:scaleFactor]
                  unless s.nil?
                     @xml.tag!('gmd:scaleFactor') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:scaleFactor')
                  end

                  # mdBand - offset
                  s = hAttribute[:offset]
                  unless s.nil?
                     @xml.tag!('gmd:offset') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:offset')
                  end

               end # writeXML
            end # MD_Band attributes

         end
      end
   end
end
