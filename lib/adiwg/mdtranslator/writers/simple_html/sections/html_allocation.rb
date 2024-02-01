# HTML writer
# allocation

# History:
#  Stan Smith 2017-08-31 refactored for mdJson 2.3 schema update
#  Stan Smith 2017-04-04 original script

require_relative 'html_responsibility'
require_relative 'html_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Allocation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAllocation)

                  # classes used
                  responsibilityClass = Html_Responsibility.new(@html)
                  onlineClass = Html_OnlineResource.new(@html)

                  # allocation - id
                  unless hAllocation[:id].nil?
                     @html.em('Source Allocation ID: ')
                     @html.text!(hAllocation[:id])
                     @html.br
                  end

                  # allocation - amount
                  unless hAllocation[:amount].nil?
                     @html.em('Amount: ')
                     @html.text!(hAllocation[:amount].to_s)
                     @html.br
                  end

                  # allocation - currency
                  unless hAllocation[:currency].nil?
                     @html.em('Currency: ')
                     @html.text!(hAllocation[:currency])
                     @html.br
                  end

                  # allocation - sourceId
                  unless hAllocation[:sourceId].nil?
                     hContact = Html_Document.getContact(hAllocation[:sourceId])
                     @html.em('Source Contact: ')
                     if hContact.empty?
                        @html.text!("Contact #{hAllocation[:sourceId]} not found!")
                     else
                        @html.a(hContact[:contactId], 'href' => '#CID_'+hContact[:contactId])
                     end
                     @html.br
                  end

                  # allocation - recipientId
                  unless hAllocation[:recipientId].nil?
                     hContact = Html_Document.getContact(hAllocation[:recipientId])
                     @html.em('Recipient Contact: ')
                     if hContact.empty?
                        @html.text!("Contact #{hAllocation[:recipientId]} not found!")
                     else
                        @html.a(hContact[:contactId], 'href' => '#CID_'+hContact[:contactId])
                     end
                     @html.br
                  end

                  # allocation - matching {Boolean}
                  unless hAllocation[:matching].nil?
                     @html.em('Matching Funds Provided: ')
                     @html.text!(hAllocation[:matching].to_s)
                     @html.br
                  end

                  # allocation - responsible parties [] {responsibleParty}
                  hAllocation[:responsibleParties].each do |hResponsibility|
                     @html.div do
                        @html.h5(hResponsibility[:roleName], 'class' => 'h5')
                        @html.div(:class => 'block') do
                           responsibilityClass.writeHtml(hResponsibility)
                        end
                     end
                  end

                  # allocation - online resource [] {onlineResource}
                  hAllocation[:onlineResources].each do |hOnline|
                     @html.div do
                        @html.div('Online Resource', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           onlineClass.writeHtml(hOnline)
                        end
                     end
                  end

                  # allocation - comment
                  unless hAllocation[:comment].nil?
                     @html.em('Comment: ')
                     @html.div(:class => 'block') do
                        @html.text!(hAllocation[:comment])
                     end
                  end

               end # writeHtml
            end # Html_Allocation

         end
      end
   end
end
