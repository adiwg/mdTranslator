# HTML writer
# entity foreign key

# History:
#  Stan Smith 2017-04-05 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_EntityForeignKey

               def initialize(html)
                  @html = html
               end

               def writeHtml(hKey)

                  # foreign key

                  aFKs = hEntity[:foreignKeys]
                  if !aFKs.empty?
                     aFKs.each do |hFK|
                        @html.em('Foreign Key: ')
                        @html.section(:class => 'block') do

                           # foreign key - local attribute list
                           @html.em('Local attribute: ')
                           @html.text!(hFK[:fkLocalAttributes].to_s)
                           @html.br

                           # foreign key - referenced entity
                           @html.em('Referenced entity: ')
                           @html.text!(hFK[:fkReferencedEntity])
                           @html.br

                           # foreign key - referenced attribute list
                           @html.em('Referenced attribute: ')
                           @html.text!(hFK[:fkReferencedAttributes].to_s)
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
