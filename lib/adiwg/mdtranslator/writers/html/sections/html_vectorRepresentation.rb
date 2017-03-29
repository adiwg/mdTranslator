# HTML writer
# vector representation

# History:
#  Stan Smith 2017-03-28 original script

require_relative 'html_vectorObject'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class HTML_VectorRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hVector)

                  # classes used
                  objectClass = HTML_VectorObject.new(@html)

                  # vector representation - topology level
                  @html.em('Topology Level: ')
                  @html.text!(hVector[:topologyLevel])
                  @html.br

                  # vector representation - vector object []
                  hVector[:vectorObject].each do |hObject|
                     @html.details do
                        @html.summary('Vector Object ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           objectClass.writeHtml(hObject)
                        end
                     end
                  end

               end # writeHtml
            end # HTML_VectorRepresentation

         end
      end
   end
end
