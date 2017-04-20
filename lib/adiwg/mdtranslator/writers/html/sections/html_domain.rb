# HTML writer
# domain

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-26 original script

require_relative 'html_domainItem'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Domain

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDomain)

                  # classes used
                  itemClass = Html_DomainItem.new(@html)

                  # domain - id
                  unless hDomain[:domainId].nil?
                     @html.em('ID: ')
                     @html.text!(hDomain[:domainId])
                     @html.br
                  end

                  # domain - name
                  unless hDomain[:domainName].nil?
                     @html.em('Name: ')
                     @html.text!(hDomain[:domainName])
                     @html.br
                  end

                  # domain - code
                  unless hDomain[:domainCode].nil?
                     @html.em('Code: ')
                     @html.text!(hDomain[:domainCode])
                     @html.br
                  end

                  # domain - description
                  unless hDomain[:domainDescription].nil?
                     @html.em('Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hDomain[:domainDescription])
                     end
                  end

                  # domain - domain items [] {domainItem}
                  hDomain[:domainItems].each do |hItem|
                     @html.details do
                        @html.summary(hItem[:itemValue], {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           itemClass.writeHtml(hItem)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Domain

         end
      end
   end
end
