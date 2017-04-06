# HTML writer
# metadata repository

# History:
#  Stan Smith 2017-04-05 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Repository

               def initialize(html)
                  @html = html
               end

               def writeHtml(hRepository)

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

               end # writeHtml
            end # Html_Repository

         end
      end
   end
end
