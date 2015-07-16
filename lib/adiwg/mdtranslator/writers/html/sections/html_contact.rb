# HTML writer
# contact

# History:
# 	Stan Smith 2015-03-23 original script
#   Stan Smith 2015-06-23 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_onlineResource'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlContact
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(contactId)

                        # classes used
                        htmlOlRes = MdHtmlOnlineResource.new(@html)

                        # find contact in contact list
                        hContact = MdHtmlWriter.getContact(contactId)

                        # contact - individual name
                        s = hContact[:indName]
                        if s
                            @html.text!(s)
                            @html.br
                        end

                        # contact - title or position
                        s = hContact[:position]
                        if s
                            @html.text!(s)
                            @html.br
                        end

                        # contact - organization name
                        s = hContact[:orgName]
                        if s
                            @html.text!(s)
                            @html.br
                        end

                        # contact - address
                        hAddress = hContact[:address]
                        if !hAddress.empty?

                            # address - delivery points
                            a = hAddress[:deliveryPoints]
                            a.each do |addLine|
                                @html.text!(addLine)
                                @html.br
                            end

                            # address - city
                            s = hAddress[:city]
                            if s
                                @html.text!(s)
                            end

                            # address - admin area
                            s = hAddress[:adminArea]
                            if s
                                @html.text!(', ' + s)
                            end

                            # address - postal code
                            s = hAddress[:postalCode]
                            if s
                                @html.text!(' ' + s)
                            end

                            @html.br

                            # contact - email
                            a = hContact[:address][:eMailList]
                            a.each do |eMail|
                                @html.text!(eMail)
                                @html.br
                            end

                        end

                        # contact - phones
                        aPhones = hContact[:phones]
                        if !aPhones.empty?
                            aPhones.each do |hPhone|
                                @html.text!(hPhone[:phoneServiceType] + ': ')
                                @html.text!(hPhone[:phoneNumber] + ' ')
                                @html.text!(hPhone[:phoneName]) if !hPhone[:phoneName].nil?
                                @html.br
                            end
                        end

                        # contact - online resource
                        aOline = hContact[:onlineRes]
                        if !aOline.empty?
                            aOline.each do |olRes|
                                @html.em('Online presence: ')
                                @html.section(:class=>'block') do
                                    htmlOlRes.writeHtml(olRes)
                                end
                            end
                        end

                        # contact - special instructions
                        s = hContact[:contactInstructions]
                        if s
                            @html.em('Note: ')
                            @html.text!(s)
                            @html.br
                        end


                    end # writeHtml

                end # class

            end
        end
    end
end
