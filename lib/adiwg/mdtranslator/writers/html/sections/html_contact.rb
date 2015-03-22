

require 'html_onlineResource'

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
                        htmlOlRes = $HtmlNS::MdHtmlOnlineResource.new(@html)

                        # find contact in contact list
                        hContact = {}
                        $aContacts.each do |hCont|
                            if hCont[:contactId] == contactId
                                hContact = hCont
                                break
                            end
                        end

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
                                @html.text(', ' + s)
                            end

                            # address - postal code
                            s = hAddress[:postalCode]
                            if s
                                @html.text!(' ' + s)
                            end

                            @html.br

                        end

                        # contact - email
                        a = hContact[:address][:eMailList]
                        a.each do |eMail|
                            @html.text!(eMail)
                            @html.br
                        end

                        # contact - phones
                        aPhones = hContact[:phones]
                        aPhones.each do |hPhone|
                            @html.text!(hPhone[:phoneServiceType] + ': ')
                            @html.text!(hPhone[:phoneNumber] + ' ')
                            @html.text!(hPhone[:phoneName])
                            @html.br
                        end

                        # contact - online resource
                        a = hContact[:onlineRes]
                        a.each do |olRes|
                            htmlOlRes.writeHtml(olRes)
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
