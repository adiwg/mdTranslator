# HTML writer
# dimension information

# History:
#  Stan Smith 2017-03-28 refactored for mdTranslator 2.0
# 	Stan Smith 2015-07-31 original script

require_relative 'html_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Dimension

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDimension)

                  measureClass = Html_Measure.new(@html)

                  # dimension - type
                  unless hDimension[:dimensionType].nil?
                     @html.em('Type: ')
                     @html.text!(hDimension[:dimensionType])
                     @html.br
                  end

                  # dimension - title
                  unless hDimension[:dimensionTitle].nil?
                     @html.em('Title: ')
                     @html.text!(hDimension[:dimensionTitle])
                     @html.br
                  end

                  # dimension - description
                  unless hDimension[:dimensionDescription].nil?
                     @html.em('Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hDimension[:dimensionDescription])
                     end
                  end

                  # dimension - size
                  unless hDimension[:dimensionSize].nil?
                     @html.em('Number of elements along Axis: ')
                     @html.text!(hDimension[:dimensionSize].to_s)
                     @html.br
                  end

                  # dimension - resolution {resolution}
                  unless hDimension[:resolution].empty?
                     @html.em('Resolution:')
                     @html.section(:class => 'block') do
                        measureClass.writeHtml(hDimension[:resolution])
                     end
                  end

               end # writeHtml
            end # Html_Dimension

         end
      end
   end
end
