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

                  @html.text!('Nothing Yet')

                  # # domain - user assigned domain id
                  # s = hDomain[:domainId]
                  # if !s.nil?
                  #    @html.em('Domain ID: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # domain - domain name
                  # s = hDomain[:domainName]
                  # if !s.nil?
                  #    @html.em('Domain name: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # domain - domain code
                  # s = hDomain[:domainCode]
                  # if !s.nil?
                  #    @html.em('Domain code: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # domain - user assigned domain id
                  # s = hDomain[:domainDescription]
                  # if !s.nil?
                  #    @html.em('Description: ')
                  #    @html.section(:class => 'block') do
                  #       @html.text!(s)
                  #    end
                  # end
                  #
                  # # domain - domain members
                  # aMembers = hDomain[:domainItems]
                  # if !aMembers.empty?
                  #    @html.em('Domain members: ')
                  #    aMembers.each do |hDItem|
                  #       @html.section(:class => 'block') do
                  #          @html.details do
                  #             @html.summary(hDItem[:itemValue], {'class' => 'h5'})
                  #             @html.section(:class => 'block') do
                  #                itemClass.writeHtml(hDItem)
                  #             end
                  #          end
                  #       end
                  #    end
                  # end

               end # writeHtml
            end # Html_Domain

         end
      end
   end
end
