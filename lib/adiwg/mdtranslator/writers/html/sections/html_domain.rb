# HTML writer
# data dictionary domain

# History:
# 	Stan Smith 2015-03-26 original script

require 'html_domainMember'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDictionaryDomain
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hDomain)

                        # classes used
                        htmlDomMem = $HtmlNS::MdHtmlDomainMember.new(@html)

                        # domain - user assigned domain id
                        s = hDomain[:domainId]
                        if !s.nil?
                            @html.em('Domain ID: ')
                            @html.text!(s)
                            @html.br
                        end

                        # domain - domain name
                        s = hDomain[:domainName]
                        if !s.nil?
                            @html.em('Domain name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # domain - domain code
                        s = hDomain[:domainCode]
                        if !s.nil?
                            @html.em('Domain code: ')
                            @html.text!(s)
                            @html.br
                        end

                        # domain - user assigned domain id
                        s = hDomain[:domainDescription]
                        if !s.nil?
                            @html.em('Description: ')
                            @html.blockquote do
                                @html.text!(s)
                            end
                        end

                        # domain - domain members
                        aMembers = hDomain[:domainItems]
                        if !aMembers.empty?
                            @html.em('Domain members: ')
                            aMembers.each do |hDItem|
                                @html.blockquote do
                                    @html.details do
                                        @html.summary(hDItem[:itemValue], {'class'=>'h5'})
                                        @html.blockquote do
                                            htmlDomMem.writeHtml(hDItem)
                                        end
                                    end
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
