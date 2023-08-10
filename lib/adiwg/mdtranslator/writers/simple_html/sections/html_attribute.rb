# HTML writer
# attribute

# History:
#  Stan Smith 2017-04-02 original script

require_relative 'html_identifier'
require_relative 'html_rangeElementDescription'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_Attribute

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAttribute)
                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  rangeElementDescriptionClass = Html_RangeElementDescription.new(@html)

                  # attribute - sequence identifier
                  unless hAttribute[:sequenceIdentifier].nil?
                     @html.em('Sequence Identifier: ')
                     @html.text!(hAttribute[:sequenceIdentifier])
                     @html.br
                  end

                  # attribute - sequence identifier type
                  unless hAttribute[:sequenceIdentifierType].nil?
                     @html.em('Sequence Identifier Type: ')
                     @html.text!(hAttribute[:sequenceIdentifierType])
                     @html.br
                  end

                  # attribute - attribute description
                  unless hAttribute[:attributeDescription].nil?
                     @html.em('Attribute Description:')
                     @html.div(:class => 'block') do
                        @html.text!(hAttribute[:attributeDescription])
                     end
                  end

                  # attribute - attribute identifiers [] {identifier}
                  hAttribute[:attributeIdentifiers].each do |hIdentifier|
                     @html.div do
                        @html.div('Identifier', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hIdentifier)
                        end
                     end
                  end

                  # attribute - minimum value
                  unless hAttribute[:minValue].nil?
                     @html.em('Minimum Value: ')
                     @html.text!(hAttribute[:minValue].to_s)
                     @html.br
                  end

                  # attribute - maximum value
                  unless hAttribute[:maxValue].nil?
                     @html.em('Maximum Value: ')
                     @html.text!(hAttribute[:maxValue].to_s)
                     @html.br
                  end

                  # attribute - units
                  unless hAttribute[:units].nil?
                     @html.em('Units: ')
                     @html.text!(hAttribute[:units])
                     @html.br
                  end

                  # attribute - scale factor
                  unless hAttribute[:scaleFactor].nil?
                     @html.em('Scale Factor: ')
                     @html.text!(hAttribute[:scaleFactor].to_s)
                     @html.br
                  end

                  # attribute - offset
                  unless hAttribute[:offset].nil?
                     @html.em('Offset: ')
                     @html.text!(hAttribute[:offset].to_s)
                     @html.br
                  end

                  # attribute - mean value
                  unless hAttribute[:meanValue].nil?
                     @html.em('Mean Value: ')
                     @html.text!(hAttribute[:meanValue].to_s)
                     @html.br
                  end

                  # attribute - number of values
                  unless hAttribute[:numberOfValues].nil?
                     @html.em('Number of Values: ')
                     @html.text!(hAttribute[:numberOfValues].to_s)
                     @html.br
                  end

                  # attribute - standard deviation
                  unless hAttribute[:standardDeviation].nil?
                     @html.em('Standard Deviation: ')
                     @html.text!(hAttribute[:standardDeviation].to_s)
                     @html.br
                  end

                  # attribute - bits per value
                  unless hAttribute[:bitsPerValue].nil?
                     @html.em('Bits Per Value: ')
                     @html.text!(hAttribute[:bitsPerValue].to_s)
                     @html.br
                  end

                  # attribute - range element description
                  hAttribute[:rangeElementDescription].each do |red|
                     @html.div do
                        @html.div('Range Element Description', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           rangeElementDescriptionClass.writeHtml(red)
                        end
                     end
                  end

                  # attribute - bound minimum
                  unless hAttribute[:boundMinimum].nil?
                     @html.em('Bound Minimum: ')
                     @html.text!(hAttribute[:boundMinimum].to_s)
                     @html.br
                  end

                  # attribute - bound maximum
                  unless hAttribute[:boundMaximum].nil?
                     @html.em('Bound Maximum: ')
                     @html.text!(hAttribute[:boundMaximum].to_s)
                     @html.br
                  end

                  # attribute - peak response
                  unless hAttribute[:peakResponse].nil?
                     @html.em('Peak Response: ')
                     @html.text!(hAttribute[:peakResponse].to_s)
                     @html.br
                  end

                  # attribute - tone gradations
                  unless hAttribute[:toneGradations].nil?
                     @html.em('Tone Gradations: ')
                     @html.text!(hAttribute[:toneGradations].to_s)
                     @html.br
                  end

                  # attribute - band boundary definitions
                  unless hAttribute[:bandBoundaryDefinition].nil?
                     @html.em('Band Boundary Definition:')
                     @html.div(:class => 'block') do
                        @html.text!(hAttribute[:bandBoundaryDefinition])
                     end
                  end

                  # attribute - nominal spatial resolution
                  unless hAttribute[:nominalSpatialResolution].nil?
                     @html.em('Nominal Spatial Resolution: ')
                     @html.text!(hAttribute[:nominalSpatialResolution].to_s)
                     @html.br
                  end

                  # attribute - transfer function type
                  unless hAttribute[:transferFunctionType].nil?
                     @html.em('Transfer Function Type: ')
                     @html.text!(hAttribute[:transferFunctionType])
                     @html.br
                  end

                  # attribute - transmitted polarization
                  unless hAttribute[:transmittedPolarization].nil?
                     @html.em('Transmitted Polarization: ')
                     @html.text!(hAttribute[:transmittedPolarization])
                     @html.br
                  end

                  # attribute - detected polarization
                  unless hAttribute[:detectedPolarization].nil?
                     @html.em('Detected Polarization: ')
                     @html.text!(hAttribute[:detectedPolarization])
                     @html.br
                  end

               end # writeHtml
            end # Html_Attribute

         end
      end
   end
end
