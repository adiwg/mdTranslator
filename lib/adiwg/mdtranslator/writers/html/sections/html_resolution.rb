# HTML writer
# resolution

# History:
#  Stan Smith 2017-03-29 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-26 original script

require_relative 'html_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Resolution

               def initialize(html)
                  @html = html
               end

               def writeHtml(hResolution)

                  measureClass = Html_Measure.new(@html)

                  # resolution - scale factor
                  unless hResolution[:scaleFactor].nil?
                     @html.em('Scale Factor: ')
                     @html.text!(hResolution[:scaleFactor].to_s)
                     @html.br
                  end

                  # resolution - measure
                  unless hResolution[:measure].empty?
                     @html.em('Spatial Resolution Measure: ')
                     @html.section(:class => 'block') do
                        measureClass.writeHtml(hResolution[:measure])
                     end
                  end

                  # resolution - level of detail
                  unless hResolution[:levelOfDetail].nil?
                     @html.em('Level of Detail: ')
                     @html.section(:class => 'block') do
                        @html.text!(hResolution[:levelOfDetail])
                     end
                  end

               end # writeHtml
            end # Html_Resolution

         end
      end
   end
end
