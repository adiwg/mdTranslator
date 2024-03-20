# HTML writer
# responsible party

# History:
#  Stan Smith 2017-03-23 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-24 original script

# require_relative 'html_extent'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Responsibility
               def initialize(html)
                  @html = html
               end

               def writeHtml(hResponsibility)

                  # classes used
                  # extentClass = Html_Extent.new(@html)

                  # responsibility - role parties
                  hResponsibility[:parties].each do |hParty|
                     hContact = Html_Document.getContact(hParty[:contactId])
                     @html.div do
                        @html.div(hContact[:name], 'class' => 'h5')
                        @html.div(:class => 'block') do

                           # party - contact ID
                           @html.em('Contact ID: ')
                           @html.a(hContact[:contactId], 'href' => '#CID_'+hContact[:contactId])
                           @html.br

                           # party - contact type
                           unless hContact[:contactType].nil?
                              @html.em('Contact Type: ')
                              @html.text!(hContact[:contactType])
                              @html.br
                           end

                           if hContact[:isOrganization]
                              hParty[:organizationMembers].each do |memberId|
                                 hMemberContact = Html_Document.getContact(memberId)
                                 @html.em('has Member: ')
                                 @html.a(hMemberContact[:name], 'href' => '#CID_'+ memberId)
                                 @html.br
                              end
                           else
                              hMemberContact = Html_Document.getContact(hContact[:contactId])
                              unless hMemberContact[:positionName].nil?
                                 @html.em('Position Name: ')
                                 @html.text!(hMemberContact[:positionName])
                                 @html.br
                              end
                           end

                        end
                     end
                  end

                  # # responsibility - role extent [] {extent}
                  # hResponsibility[:roleExtents].each do |hExtent|
                  #    @html.div do
                  #       @html.h5('Extent', {'class' => 'h5'})
                  #       @html.div(:class => 'block') do
                  #          extentClass.writeHtml(hExtent)
                  #       end
                  #    end
                  # end

               end # writeHtml
            end # Html_Responsibility

         end
      end
   end
end
