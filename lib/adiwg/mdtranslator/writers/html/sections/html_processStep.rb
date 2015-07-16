# HTML writer
# process step

# History:
# 	Stan Smith 2015-03-27 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_dateTime'
require_relative 'html_responsibleParty'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlProcessStep
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hStep)

                        # classes used
                        htmlDateTime = MdHtmlDateTime.new(@html)
                        htmlResParty = MdHtmlResponsibleParty.new(@html)

                        # process step - id
                        s = hStep[:stepId]
                        if !s.nil?
                            @html.em('Step ID: ')
                            @html.text!(s)
                            @html.br
                        end

                        # process step - description
                        s = hStep[:stepDescription]
                        if !s.nil?
                            @html.em('Description: ')
                            @html.section(:class=>'block') do
                                @html.text!(s)
                            end
                        end

                        # process step - step rationale
                        s = hStep[:stepRationale]
                        if !s.nil?
                            @html.em('Rationale: ')
                            @html.text!(s)
                            @html.br
                        end

                        # process step - dateTime
                        hDateTime = hStep[:stepDateTime]
                        if !hDateTime.empty?
                            @html.em('DateTime: ')
                            htmlDateTime.writeHtml(hDateTime)
                        end

                        # process step - processors
                        aProcessor = hStep[:stepProcessors]
                        aProcessor.each do |hResParty|
                            @html.em('Responsible party: ')
                            @html.section(:class=>'block') do
                                htmlResParty.writeHtml(hResParty)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
