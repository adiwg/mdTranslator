# HTML writer
# vector representation

# History:
#  Stan Smith 2017-10-13 trap missing topology level
#  Stan Smith 2017-03-28 original script

require_relative 'html_vectorObject'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_VectorRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hVector)

                  # classes used
                  objectClass = Html_VectorObject.new(@html)

                  # vector representation - topology level
                  unless hVector[:topologyLevel].nil?
                     @html.em('Topology Level: ')
                     @html.text!(hVector[:topologyLevel])
                     @html.br
                  end

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
            end # Html_VectorRepresentation

         end
      end
   end
end
