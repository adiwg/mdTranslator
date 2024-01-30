# HTML writer
# contact

# History:
#  Stan Smith 2017-03-23 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2015-06-23 replace global ($response) with passed in object (responseObj)
# 	Stan Smith 2015-03-23 original script

require_relative 'html_onlineResource'
require_relative 'html_graphic'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Contact

               def initialize(html)
                  @html = html
               end

               def writeHtml(hContact)

                  # classes used
                  onlineClass = Html_OnlineResource.new(@html)
                  graphicClass = Html_Graphic.new(@html)

                  @html.div do
                     @html.div(hContact[:name], {'id' => 'CID_' + hContact[:contactId], 'class' => 'h3'})
                     @html.div(:class => 'block') do

                        # contact - contact ID
                        unless hContact[:contactId].nil?
                           @html.em('Contact ID: ')
                           @html.text!(hContact[:contactId])
                           @html.br
                        end

                        # contact - isOrganization
                        @html.em('is Organization: ')
                        @html.text!(hContact[:isOrganization].to_s)
                        @html.br

                        # contact - type
                        unless hContact[:contactType].nil?
                           @html.em('Contact Type: ')
                           @html.text!(hContact[:contactType])
                           @html.br
                        end

                        # contact - position
                        unless hContact[:positionName].nil?
                           @html.em('Position Name: ')
                           @html.text!(hContact[:positionName])
                           @html.br
                        end

                        # contact - member of organizations []
                        hContact[:memberOfOrgs].each do |org|
                           hMember = Html_Document.getContact(org)
                           unless hMember.empty?
                              @html.em('is Member of: ')
                              @html.a(hMember[:name], 'href' => '#CID_'+hMember[:contactId])
                              @html.br
                           end
                        end

                        # contact - address
                        hContact[:addresses].each do |hAddress|
                           @html.div do
                              @html.div('Address', {'class' => 'h5'})
                              @html.div(:class => 'block') do

                                 # address - delivery points
                                 hAddress[:deliveryPoints].each do |addLine|
                                    @html.text!(addLine)
                                    @html.br
                                 end

                                 # address - city, adminArea postalCode
                                 unless hAddress[:city].nil?
                                    @html.text!(hAddress[:city])
                                 end
                                 unless hAddress[:adminArea].nil?
                                    @html.text!(', ' + hAddress[:adminArea])
                                 end
                                 unless hAddress[:postalCode].nil?
                                    @html.text!(' ' + hAddress[:postalCode])
                                 end
                                 @html.br

                                 # address - country
                                 unless hAddress[:country].nil?
                                    @html.text!(hAddress[:country])
                                    @html.br
                                 end

                                 # address - type
                                 hAddress[:addressTypes].each do |addType|
                                    @html.em('Address Type: ')
                                    @html.text!(addType)
                                    @html.br
                                 end

                                 # address - description
                                 if hAddress[:description]
                                    @html.em('Description: ')
                                    @html.text!(hAddress[:description])
                                    @html.br
                                 end

                              end
                           end
                        end


                        # contact - phones
                        hContact[:phones].each do |hPhone|
                           @html.div do
                              @html.div('Phone', {'class' => 'h5'})
                              @html.div(:class => 'block') do

                                 # phone - name
                                 unless hPhone[:phoneName].nil?
                                    @html.em('Phone Name: ')
                                    @html.text!(hPhone[:phoneName])
                                    @html.br
                                 end

                                 # phone - number
                                 unless hPhone[:phoneNumber].nil?
                                    @html.em('Phone Number: ')
                                    @html.text!(hPhone[:phoneNumber])
                                    @html.br
                                 end

                                 # phone - service types
                                 unless hPhone[:phoneServiceTypes].empty?
                                    @html.em('Service Types: ')
                                    hPhone[:phoneServiceTypes].each do |phoneType|
                                       @html.text!(phoneType + ' ')
                                    end
                                    @html.br
                                 end

                              end
                           end
                        end

                        # contact - email []
                        hContact[:eMailList].each do |email|
                           @html.em('Electronic Mail: ')
                           @html.text!(email)
                           @html.br
                        end

                        # contact - online resource []
                        hContact[:onlineResources].each do |hOnline|
                           @html.div do
                              @html.div('Online Resource', {'class' => 'h5'})
                              @html.div(:class => 'block') do
                                 onlineClass.writeHtml(hOnline)
                              end
                           end
                        end

                        # contact - logos []
                        hContact[:logos].each do |hLogo|
                           @html.div do
                              @html.div('Logo Graphic', {'class' => 'h5'})
                              @html.div(:class => 'block') do
                                 graphicClass.writeHtml(hLogo)
                              end
                           end
                        end

                        # contact - hours of service []
                        hContact[:hoursOfService].each do |hours|
                           @html.em('Hours of Service: ')
                           @html.text!(hours)
                           @html.br
                        end

                        # contact - instructions
                        unless hContact[:contactInstructions].nil?
                           @html.em('Contact Instructions: ')
                           @html.text!(hContact[:contactInstructions])
                           @html.br
                        end

                        # contact - external identifiers []
                        if hContact.key?(:externalIdentifier) && !hContact[:externalIdentifier].empty?
                           hContact[:externalIdentifier].each do |identifier|
                              @html.div do
                                 @html.div("External Identifier", {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    @html.em('Identifier: ')
                                    @html.text!(identifier[:identifier])
                                    @html.br

                                    unless identifier[:namespace].nil?
                                       @html.em('Namespace: ')
                                       @html.text!(identifier[:namespace])
                                       @html.br
                                    end

                                    unless identifier[:version].nil?
                                       @html.em('Version: ')
                                       @html.text!(identifier[:version])
                                       @html.br
                                    end

                                    unless identifier[:description].nil?
                                       @html.em('Description: ')
                                       @html.text!(identifier[:description])
                                       @html.br
                                    end
                                 end
                              end
                           end
                        end

                     end
                  end

               end # writeHtml
            end # Html_Contact

         end
      end
   end
end
