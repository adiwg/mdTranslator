# ISO <<Class>> MD_SampleDimension attributes
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-08 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_unitsOfMeasure'
require_relative 'class_rangeElementDescription'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_SampleDimension

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hAttribute, inContext = nil)

                  # classes used
                  uomClass = UnitsOfMeasure.new(@xml, @hResponseObj)
                  rangeElementDescription = MI_RangeElementDescription.new(@xml, @hResponseObj)

                  # sample dimension - max value {real}
                  unless hAttribute[:maxValue].nil?
                     @xml.tag!('mrc:maxValue') do
                        @xml.tag!('gco:Real', hAttribute[:maxValue])
                     end
                  end
                  if hAttribute[:maxValue].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:maxValue')
                  end

                  # sample dimension - min value {real}
                  unless hAttribute[:minValue].nil?
                     @xml.tag!('mrc:minValue') do
                        @xml.tag!('gco:Real', hAttribute[:minValue])
                     end
                  end
                  if hAttribute[:minValue].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:minValue')
                  end

                  # sample dimension - units {gml:unitsOfMeasure}
                  unless hAttribute[:units].nil?
                     @xml.tag!('mrc:units') do
                        uomClass.writeUnits(hAttribute[:units])
                     end
                  end
                  if hAttribute[:units].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:units')
                  end

                  # sample dimension - scale factor {real}
                  unless hAttribute[:scaleFactor].nil?
                     @xml.tag!('mrc:scaleFactor') do
                        @xml.tag!('gco:Real', hAttribute[:scaleFactor])
                     end
                  end
                  if hAttribute[:scaleFactor].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:scaleFactor')
                  end

                  hAttribute[:rangeElementDescriptions].each do |red|
                     @xml.tag!('mrc:rangeElementDescription') do
                        rangeElementDescription.writeXML(red, inContext)
                     end
                  end

                  # sample dimension - offset {real}
                  unless hAttribute[:offset].nil?
                     @xml.tag!('mrc:offset') do
                        @xml.tag!('gco:Real', hAttribute[:offset])
                     end
                  end
                  if hAttribute[:offset].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:offset')
                  end

                  # sample dimension - mean value {real}
                  unless hAttribute[:meanValue].nil?
                     @xml.tag!('mrc:meanValue') do
                        @xml.tag!('gco:Real', hAttribute[:meanValue])
                     end
                  end
                  if hAttribute[:meanValue].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:meanValue')
                  end

                  # sample dimension - number of values {integer}
                  unless hAttribute[:numberOfValues].nil?
                     @xml.tag!('mrc:numberOfValues') do
                        @xml.tag!('gco:Integer', hAttribute[:numberOfValues])
                     end
                  end
                  if hAttribute[:numberOfValues].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:numberOfValues')
                  end

                  # sample dimension - standard deviation {real}
                  unless hAttribute[:standardDeviation].nil?
                     @xml.tag!('mrc:standardDeviation') do
                        @xml.tag!('gco:Real', hAttribute[:standardDeviation])
                     end
                  end
                  if hAttribute[:standardDeviation].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:standardDeviation')
                  end

                  # sample dimension - other property type - not implemented
                  # sample dimension - other property - not implemented

                  # sample dimension - bits per value {integer}
                  unless hAttribute[:bitsPerValue].nil?
                     @xml.tag!('mrc:bitsPerValue') do
                        @xml.tag!('gco:Integer', hAttribute[:bitsPerValue])
                     end
                  end
                  if hAttribute[:bitsPerValue].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:bitsPerValue')
                  end

               end # writeXML
            end # MD_SampleDescription

         end
      end
   end
end
