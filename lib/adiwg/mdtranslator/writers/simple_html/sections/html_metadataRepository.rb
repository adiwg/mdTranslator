# HTML writer
# metadata repository

# History:
#  Stan Smith 2017-06-06 added metadata repository citation
#  Stan Smith 2017-04-05 original script

require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Repository

               def initialize(html)
                  @html = html
               end

               def writeHtml(hRepository)

                  # classes used
                  citationClass = Html_Citation.new(@html)

                  # metadata repository - repository
                  unless hRepository[:repository].nil?
                     @html.em('Repository Name: ')
                     @html.text!(hRepository[:repository])
                     @html.br
                  end

                  # metadata repository - metadata standard
                  unless hRepository[:metadataStandard].nil?
                     @html.em('Metadata Standard: ')
                     @html.text!(hRepository[:metadataStandard])
                     @html.br
                  end

                  # metadata repository - citation
                  unless hRepository[:citation].empty?
                     @html.div do
                        @html.div('Citation', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hRepository[:citation])
                        end
                     end
                  end

               end # writeHtml
            end # Html_Repository

         end
      end
   end
end
