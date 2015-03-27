# HTML writer
# citation

# History:
# 	Stan Smith 2015-03-23 original script

require 'html_dateTime'
require 'html_resourceId'
require 'html_responsibleParty'
require 'html_onlineResource'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlCitation
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hCitation)

                        # classes used
                        htmlDateTime = $HtmlNS::MdHtmlDateTime.new(@html)
                        htmlResId = $HtmlNS::MdHtmlResourceId.new(@html)
                        htmlResParty = $HtmlNS::MdHtmlResponsibleParty.new(@html)
                        htmlOlRes = $HtmlNS::MdHtmlOnlineResource.new(@html)

                        # citation - title - required
                        @html.em('Title: ')
                        @html.text!(hCitation[:citTitle])
                        @html.br

                        # citation - date
                        aDates = hCitation[:citDate]
                        aDates.each do |hDatetime|
                            @html.em('Date: ')
                            htmlDateTime.writeHtml(hDatetime)
                        end

                        # citation - edition
                        s = hCitation[:citEdition]
                        if s
                            @html.em('Edition: ')
                            @html.text!(s)
                            @html.br
                        end

                        # citation - resource ids - resource identifier
                        aIds = hCitation[:citResourceIds]
                        aIds.each do |hId|
                            htmlResId.writeHtml(hId)
                        end

                        # citation - responsible parties
                        aResPart = hCitation[:citResponsibleParty]
                        if !aResPart.empty?
                            @html.em('Responsible party: ')
                            @html.blockquote do
                                aResPart.each do |hParty|
                                    htmlResParty.writeHtml(hParty)
                                end
                            end
                        end

                        # citation - presentation forms
                        aForms = hCitation[:citResourceForms]
                        aForms.each do |form|
                            @html.em('Resource form: ')
                            @html.text!(form)
                            @html.br
                        end

                        # citation - online resources
                        aOlRes = hCitation[:citOlResources]
                        aOlRes.each do |hOlRes|
                            @html.em('Online resource: ')
                            @html.blockquote do
                                htmlOlRes.writeHtml(hOlRes)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
