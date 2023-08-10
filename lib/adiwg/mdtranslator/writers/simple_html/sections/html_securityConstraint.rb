# HTML writer
# security constraint

# History:
#  Stan Smith 2017-03-31 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_SecurityConstraint

               def initialize(html)
                  @html = html
               end

               def writeHtml(hSecCon)

                  # security constraint - classification code {classification} (required)
                  unless hSecCon[:classCode].nil?
                     @html.em('Classification: ')
                     @html.text!(hSecCon[:classCode])
                     @html.br
                  end

                  # security constraint - classification system
                  unless hSecCon[:classSystem].nil?
                     @html.em('Classification System: ')
                     @html.text!(hSecCon[:classSystem])
                     @html.br
                  end

                  # security constraint - user note
                  unless hSecCon[:userNote].nil?
                     @html.em('User Note:')
                     @html.section(:class => 'block') do
                        @html.text!(hSecCon[:userNote])
                     end
                  end

                  # security constraint - handling instructions
                  unless hSecCon[:handling].nil?
                     @html.em('handling Instructions:')
                     @html.section(:class => 'block') do
                        @html.text!(hSecCon[:handling])
                     end
                  end

               end # writeHtml
            end # Html_SecurityConstraint

         end
      end
   end
end
