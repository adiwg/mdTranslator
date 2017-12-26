# HTML writer
# data attribute

# History:
#  Stan Smith 2017-11-03 added new elements for fgdc
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-26 original script

require_relative 'html_timePeriod'
require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_EntityAttribute

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAttribute)

                  # classes used
                  periodClass = Html_TimePeriod.new(@html)
                  citationClass = Html_Citation.new(@html)

                  # entity attribute - common name
                  unless hAttribute[:attributeName].nil?
                     @html.em('Name: ')
                     @html.text!(hAttribute[:attributeName])
                     @html.br
                  end

                  # entity attribute - code name
                  unless hAttribute[:attributeCode].nil?
                     @html.em('Code: ')
                     @html.text!(hAttribute[:attributeCode])
                     @html.br
                  end

                  # entity attribute - aliases
                  hAttribute[:attributeAlias].each do |otherName|
                     @html.em('Alias: ')
                     @html.text!(otherName)
                     @html.br
                  end

                  # entity attribute - definition
                  unless hAttribute[:attributeDefinition].nil?
                     @html.em('Definition: ')
                     @html.section(:class => 'block') do
                        @html.text!(hAttribute[:attributeDefinition])
                     end
                  end

                  # entity attribute - datatype
                  unless hAttribute[:dataType].nil?
                     @html.em('Datatype: ')
                     @html.text!(hAttribute[:dataType])
                     @html.br
                  end

                  # entity attribute - allow nulls {Boolean}
                  @html.em('Allow NULL Values: ')
                  @html.text!(hAttribute[:allowNull].to_s)
                  @html.br

                  # entity attribute - allow many {Boolean}
                  @html.em('Allow Many Values: ')
                  @html.text!(hAttribute[:allowMany].to_s)
                  @html.br

                  # entity attribute - unit of measure
                  unless hAttribute[:unitOfMeasure].nil?
                     @html.em('Unit of Measure: ')
                     @html.text!(hAttribute[:unitOfMeasure])
                     @html.br
                  end

                  # entity attribute - measure resolution {real}
                  unless hAttribute[:measureResolution].nil?
                     @html.em('Unit of Measure Resolution: ')
                     @html.text!(hAttribute[:measureResolution].to_s)
                     @html.br
                  end

                  # entity attribute - case sensitive {Boolean}
                  @html.em('Value is Case Sensitive: ')
                  @html.text!(hAttribute[:isCaseSensitive].to_s)
                  @html.br

                  # entity attribute - field width {integer}
                  unless hAttribute[:fieldWidth].nil?
                     @html.em('Field Width: ')
                     @html.text!(hAttribute[:fieldWidth].to_s)
                     @html.br
                  end

                  # entity attribute - missing value
                  unless hAttribute[:missingValue].nil?
                     @html.em('Missing Value: ')
                     @html.text!(hAttribute[:missingValue])
                     @html.br
                  end

                  # entity attribute - domain ID
                  unless hAttribute[:domainId].nil?
                     @html.em('Domain ID: ')
                     @html.text!(hAttribute[:domainId])
                     @html.br
                  end

                  # entity attribute - minimum value
                  unless hAttribute[:minValue].nil?
                     @html.em('Minimum Value: ')
                     @html.text!(hAttribute[:minValue].to_s)
                     @html.br
                  end

                  # entity attribute - code name
                  unless hAttribute[:maxValue].nil?
                     @html.em('Maximum Value: ')
                     @html.text!(hAttribute[:maxValue].to_s)
                     @html.br
                  end

                  # entity attribute - range of values [] {citation}
                  hAttribute[:valueRange].each do |hRange|
                     @html.details do
                        @html.summary('Range of Values', {'class' => 'h5'})
                        @html.section(:class => 'block') do

                           # range of values - minimum value
                           unless hRange[:minRangeValue].nil?
                              @html.em('Range Minimum: ')
                              @html.text!(hRange[:minRangeValue].to_s)
                              @html.br
                           end

                           # range of values - maximum value
                           unless hRange[:maxRangeValue].nil?
                              @html.em('Range Maximum: ')
                              @html.text!(hRange[:maxRangeValue].to_s)
                              @html.br
                           end

                        end
                     end
                  end

                  # entity attribute - time period of values {timePeriod}
                  hAttribute[:timePeriodOfValues].each do |hPeriod|
                     @html.details do
                        @html.summary('Time Period of Values', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           periodClass.writeHtml(hPeriod)
                        end
                     end
                  end

                  # entity attribute - attribute reference {citation}
                  unless hAttribute[:attributeReference].empty?
                     @html.details do
                        @html.summary('Reference', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hAttribute[:attributeReference])
                        end
                     end
                  end

               end # writeHtml
            end # Html_EntityAttribute

         end
      end
   end
end
