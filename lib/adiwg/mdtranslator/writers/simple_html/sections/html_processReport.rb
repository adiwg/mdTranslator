# HTML writer
# process step report

# History:
#  Stan Smith 2019-09-24 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_ProcessStepReport

               def initialize(html)
                  @html = html
               end

               def writeHtml(hReport)

                  # process step report - name
                  unless hReport[:name].nil?
                     @html.em('Name: ')
                     @html.text!(hReport[:name])
                     @html.br
                  end

                  # process step report - description
                  unless hReport[:description].nil?
                     @html.em('Description: ')
                     @html.text!(hReport[:description])
                     @html.br
                  end

                  # process step report - file type
                  unless hReport[:fileType].nil?
                     @html.em('File Type: ')
                     @html.text!(hReport[:fileType])
                     @html.br
                  end

               end # writeHtml
            end # Html_ProcessStepReport

         end
      end
   end
end
