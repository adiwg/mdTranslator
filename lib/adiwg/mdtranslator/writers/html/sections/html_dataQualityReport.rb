require_relative 'html_identifier'

module ADIWG
    module Mdtranslator
      module Writers
        module Html
            class Html_DataQualityReport
                def initialize(html)
                    @html = html
                end

                def writeHtml(hDataQualityReport)
                    identifierClass = Html_Identifier.new(@html)

                    # if hDataQualityReport exists it might contain any of the following:
                    #   qualityMeasure object
                    #   evaluationMethod object
                    #   conformanceResult array
                    #   coverageResult array
                    #   descriptiveResult array
                    #   quantitativeResult array

                    # create the report object
                    @html.details do
                        @html.summary('Report', {'class' => 'h5'})
                        @html.section(class: 'block') do

                            # quality measure contains the following:
                            #   identifier object
                            #   description string
                            #   name array of strings
                            unless hDataQualityReport[:qualityMeasure].empty?
                                @html.details do
                                    @html.summary('Quality Measure', {'class' => 'h5'})
                                    @html.section(class: 'block') do
                                        # add the identifier
                                        unless hDataQualityReport[:qualityMeasure][:identifier].empty?
                                            @html.details do
                                                @html.summary('Identifier', {'class' => 'h5'})
                                                @html.section(class: 'block') do
                                                    identifierClass.writeHtml(hDataQualityReport[:qualityMeasure][:identifier])
                                                end
                                            end
                                        end
                                        # add the description
                                        unless hDataQualityReport[:qualityMeasure][:description].nil?
                                            @html.em('Description: ')
                                            @html.text!(hDataQualityReport[:qualityMeasure][:description])
                                            @html.br
                                        end
                                        # add the names
                                        unless hDataQualityReport[:qualityMeasure][:name].empty?
                                            @html.em('Names: ')
                                            @html.text!(hDataQualityReport[:qualityMeasure][:name].join('; '))
                                            @html.br
                                        end
                                    end
                                end
                            end

                            # evaluation method
                            unless hDataQualityReport[:evaluationMethod].empty?
                                @html.details do
                                    @html.summary('Evaluation Method', {'class' => 'h5'})
                                    @html.section(class: 'block') do
                                        # TODO
                                    end
                                end
                            end

                            # conformance results
                            unless hDataQualityReport[:conformanceResult].empty?
                                @html.details do
                                    @html.summary('Conformance Result', {'class' => 'h5'})
                                    @html.section(class: 'block') do
                                        # TODO
                                    end
                                end
                            end

                            # coverage results
                            unless hDataQualityReport[:coverageResult].empty?
                                @html.details do
                                    @html.summary('Coverage Result', {'class' => 'h5'})
                                    @html.section(class: 'block') do
                                        # TODO
                                    end
                                end
                            end

                            # descriptive results
                            unless hDataQualityReport[:descriptiveResult].empty?
                                @html.details do
                                    @html.summary('Descriptive Result', {'class' => 'h5'})
                                    @html.section(class: 'block') do
                                        # TODO
                                    end
                                end
                            end

                            # quantitative results
                            unless hDataQualityReport[:quantitativeResult].empty?
                                @html.details do
                                    @html.summary('Quantitative Result', {'class' => 'h5'})
                                    @html.section(class: 'block') do
                                        # TODO
                                    end
                                end
                            end

                        end
                    end

                    # Return the report object
                    # Add a return statement here if needed
                    # Otherwise, add a comment stating that the report object is being returned
                    return report_object
                   

                end

            end
        end
    end
end
