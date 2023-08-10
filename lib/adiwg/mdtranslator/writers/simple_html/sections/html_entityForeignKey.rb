# HTML writer
# entity foreign key

# History:
#  Stan Smith 2017-04-05 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_EntityForeignKey

               def initialize(html)
                  @html = html
               end

               def writeHtml(hKey)

                  # foreign key - attributes []
                  unless hKey[:fkLocalAttributes].empty?
                     @html.em('Local Attribute(s):')
                     @html.div(:class => 'block') do
                        hKey[:fkLocalAttributes].each do |attribute|
                           @html.text!(attribute)
                           @html.br
                        end
                     end
                  end

                  # foreign key - referenced entity
                  unless hKey[:fkReferencedEntity].nil?
                     @html.em('Referenced Entity Code: ')
                     @html.text!(hKey[:fkReferencedEntity])
                     @html.br
                  end

                  # foreign key - referenced attributes []
                  unless hKey[:fkReferencedAttributes].empty?
                     @html.em('Referenced Attribute(s):')
                     @html.div(:class => 'block') do
                        hKey[:fkReferencedAttributes].each do |attribute|
                           @html.text!(attribute)
                           @html.br
                        end
                     end
                  end

               end # writeHtml
            end # Html_EntityForeignKey

         end
      end
   end
end
