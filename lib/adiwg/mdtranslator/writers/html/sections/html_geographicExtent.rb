# HTML writer
# geographic extent

# History:
#  Stan Smith 2017-04-06 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-31 original script

require_relative 'html_identifier'
require_relative 'html_boundingBox'
require_relative 'html_geographicElement'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GeographicExtent

               def initialize(html)
                  @html = html
               end

               def writeHtml(hElement)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  boundingClass = Html_BoundingBox.new(@html)
                  geographicClass = Html_GeographicElement.new(@html)

                  # geographic extent - contains data {Boolean}
                  @html.em('Geographic Extent Encompasses Data: ')
                  @html.text!(hElement[:containsData].to_s)
                  @html.br

                  # geographic extent - identifier {identifier}

                  # geographic extent - bounding box {boundingBox}
                  unless hElement[:boundingBox].empty?
                     @html.em('Bounding Box:')
                     @html.section(:class => 'block') do
                        boundingClass.writeHtml(hElement[:boundingBox])
                     end
                  end

                  # geographic extent - geographic element [] {geographicElement}

               end # writeHtml
            end # Html_GeographicExtent

         end
      end
   end
end
