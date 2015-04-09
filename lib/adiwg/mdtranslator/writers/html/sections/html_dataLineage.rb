# HTML writer
# data lineage

# History:
# 	Stan Smith 2015-03-27 original script

require 'html_processStep'
require 'html_dataSource'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDataLineage
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hLineage)

                        # classes used
                        htmlPStep = $HtmlNS::MdHtmlProcessStep.new(@html)
                        htmlDSource = $HtmlNS::MdHtmlDataSource.new(@html)

                        # lineage - statement
                        s = hLineage[:statement]
                        if !s.nil?
                            @html.em('Statement: ')
                            @html.text!(s)
                            @html.br
                        end

                        # lineage - process steps
                        aSteps = hLineage[:processSteps]
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

                        # lineage - data sources
                        aSource = hLineage[:dataSources]
                        aSource.each do |hSource|
                            @html.details do
                                @html.summary('Data source', {'class'=>'h5'})
                                @html.section(:class=>'block') do
                                    htmlDSource.writeHtml(hSource)
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
