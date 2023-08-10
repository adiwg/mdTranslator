# HTML writer
# entity index

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_EntityIndex

               def initialize(html)
                  @html = html
               end

               def writeHtml(hIndex)

                  # entity index - name
                  unless hIndex[:indexCode].nil?
                     @html.em('Code: ')
                     @html.text!(hIndex[:indexCode])
                     @html.br
                  end

                  # entity index - duplicate {Boolean}
                  @html.em('Allow Duplicates: ')
                  @html.text!(hIndex[:duplicate].to_s)
                  @html.br

                  # entity index - attribute names
                  unless hIndex[:attributeNames].empty?
                     @html.em('Index Attribute(s):')
                     @html.div(:class => 'block') do
                        hIndex[:attributeNames].each do |attribute|
                           @html.text!(attribute)
                           @html.br
                        end
                     end
                  end

               end # writeHtml
            end # Html_EntityIndex

         end
      end
   end
end
