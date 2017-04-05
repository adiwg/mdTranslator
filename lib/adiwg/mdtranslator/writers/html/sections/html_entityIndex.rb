# HTML writer
# entity index

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_EntityIndex

               def initialize(html)
                  @html = html
               end

               def writeHtml(hIndex)

                  @html.text!('Nothing Yet')

                  # # entity index - common name
                  # s = hIndex[:indexCode]
                  # if !s.nil?
                  #    @html.em('Common name: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # entity index - duplicate
                  # b = hIndex[:duplicate]
                  # if !b.nil?
                  #    @html.em('Allow duplicates: ')
                  #    @html.text!(b.to_s)
                  #    @html.br
                  # end
                  #
                  # # entity index - attribute names
                  # aIndexKey = hIndex[:attributeNames]
                  # if !aIndexKey.empty?
                  #    @html.em('Index key: ')
                  #    @html.text!(aIndexKey.to_s)
                  #    @html.br
                  # end

               end # writeHtml
            end # Html_EntityIndex

         end
      end
   end
end
