# HTML writer
# extents (geographic, temporal, vertical)

# History:
#  Stan Smith 2017-04-06 refactor for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-31 original script

require_relative 'html_geographicExtent'
require_relative 'html_temporalExtent'
require_relative 'html_verticalExtent'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Extent

               def initialize(html)
                  @html = html
               end

               def writeHtml(hExtent)

                  # classes used
                  geographicClass = Html_GeographicExtent.new(@html)
                  temporalClass = Html_TemporalExtent.new(@html)
                  verticalClass = Html_VerticalExtent.new(@html)

                  # extent - description
                  unless hExtent[:description].nil?
                     @html.em('Description: ')
                     @html.div(:class => 'block') do
                        @html.text!(hExtent[:description])
                     end
                  end

                  # extent - geographic extents
                  hExtent[:geographicExtents].each do |hGeographic|
                     @html.div do
                        @html.div('Geographic Extent', {'class' => 'h5'})
                        @html.div(:class => 'block extent-geographic') do
                           geographicClass.writeHtml(hGeographic)
                        end
                     end
                  end

                  # extent - temporal extents
                  hExtent[:temporalExtents].each do |hTemporal|
                     @html.div do
                        @html.div('Temporal Extent', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           temporalClass.writeHtml(hTemporal)
                        end
                     end
                  end

                  # extent - vertical extents
                  hExtent[:verticalExtents].each do |hVertical|
                     @html.div do
                        @html.div('Vertical Extent', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           verticalClass.writeHtml(hVertical)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Extent

         end
      end
   end
end
