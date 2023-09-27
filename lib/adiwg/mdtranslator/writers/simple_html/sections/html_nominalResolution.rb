# HTML writer
# nominal resolution

# History:
#  Stan Smith 2019-09-24 original script

require_relative 'html_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_NominalResolution

               def initialize(html)
                  @html = html
               end

               def writeHtml(hResolution)

                  # classes used
                  measureClass = Html_Measure.new(@html)

                  # nominal resolution - scanning resolution {measure}
                  unless hResolution[:scanningResolution].empty?
                     @html.div do
                        @html.div('Scanning Resolution', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           measureClass.writeHtml(hResolution[:scanningResolution])
                        end
                     end
                  end

                  # nominal resolution - ground resolution {measure}
                  unless hResolution[:groundResolution].empty?
                     @html.div do
                        @html.div('Ground Resolution', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           measureClass.writeHtml(hResolution[:groundResolution])
                        end
                     end
                  end

               end # writeHtml
            end # Html_NominalResolution

         end
      end
   end
end
