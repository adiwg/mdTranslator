# HTML writer
# vector representation

# History:
#  Stan Smith 2017-10-13 trap missing topology level
#  Stan Smith 2017-03-28 original script

require_relative 'html_vectorObject'
require_relative 'html_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_VectorRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hVector)

                  # classes used
                  objectClass = Html_VectorObject.new(@html)
                  scopeClass = Html_Scope.new(@html)

                  # vector representation - scope
                  hVector[:scope].each do |scope|
                     @html.div do
                        @html.div('Scope ', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           scopeClass.writeHtml(hVector[:scope])
                        end
                     end
                  end


                  # vector representation - topology level
                  unless hVector[:topologyLevel].nil?
                     @html.em('Topology Level: ')
                     @html.text!(hVector[:topologyLevel])
                     @html.br
                  end

                  # vector representation - vector object []
                  hVector[:vectorObject].each do |hObject|
                     @html.div do
                        @html.div('Vector Object ', 'class' => 'h5')
                        @html.div(:class => 'block') do
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
