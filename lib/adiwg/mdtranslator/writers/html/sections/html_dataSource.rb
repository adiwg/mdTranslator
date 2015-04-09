# HTML writer
# data source

# History:
# 	Stan Smith 2015-03-27 original script

require 'html_citation'
require 'html_processStep'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDataSource
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hSource)

                        # classes used
                        htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)
                        htmlPStep = $HtmlNS::MdHtmlProcessStep.new(@html)

                        # data source - description
                        s = hSource[:sourceDescription]
                        if !s.nil?
                            @html.em('Description: ')
                            @html.section(:class=>'block') do
                                @html.text!(s)
                            end
                        end

                        # data source - citation
                        hCitation = hSource[:sourceCitation]
                        if !hCitation.empty?
                            @html.em('Citation: ')
                            @html.section(:class=>'block') do
                                htmlCitation.writeHtml(hCitation)
                            end
                        end

                        # data source - source steps
                        aSteps = hSource[:sourceSteps]
                        if !aSteps.empty?
                            @html.em('Process steps: ')
                            @html.section(:class=>'block') do
                                @html.ol do
                                    aSteps.each do |hStep|
                                        @html.li do
                                            htmlPStep.writeHtml(hStep)
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
