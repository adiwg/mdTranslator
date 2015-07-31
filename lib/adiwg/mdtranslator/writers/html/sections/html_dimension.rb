# HTML writer
# dimension information

# History:
# 	Stan Smith 2015-07-31 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDimension
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hDim)

                        # dimension information - dimension type
                        @html.em('Type of dimension: ')
                        @html.text!(hDim[:dimensionType])
                        @html.br

                        # dimension information - dimension type
                        s = hDim[:dimensionTitle]
                        if !s.nil?
                            @html.em('Axis title: ')
                            @html.text!(s)
                            @html.br
                        end

                        # dimension information - dimension description
                        s = hDim[:dimensionDescription]
                        if !s.nil?
                            @html.em('Axis description: ')
                            @html.text!(s)
                            @html.br
                        end

                        # dimension information - dimension size
                        s = hDim[:dimensionSize]
                        if !s.nil?
                            @html.em('Number of elements along Axis: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # dimension information - dimension resolution
                        s = hDim[:resolution]
                        if !s.nil?
                            @html.em('Resolution of the grid: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # dimension information - resolution units of measure
                        s = hDim[:resolutionUnits]
                        if !s.nil?
                            @html.em('Resolution units of measure: ')
                            @html.text!(s)
                            @html.br
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
