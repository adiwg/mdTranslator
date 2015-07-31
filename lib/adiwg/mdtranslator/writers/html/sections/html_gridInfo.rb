# HTML writer
# grid information

# History:
# 	Stan Smith 2015-07-31 original script

require_relative 'html_dimension'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlGridInfo
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hGrid)

                        # classes used
                        htmlDim = MdHtmlDimension.new(@html)

                        # grid information - number of dimensions - required
                        @html.em('Number of dimensions: ')
                        @html.text!(hGrid[:dimensions].to_s)
                        @html.br

                        # grid information - cell geometry
                        s = hGrid[:dimensionGeometry]
                        if !s.nil?
                            @html.em('Cell Geometry: ')
                            @html.text!(s)
                            @html.br
                        end

                        # grid information - transformation parameters available
                        @html.em('Transformation parameters available: ')
                        s = hGrid[:dimensionTransformParams]
                        if s
                            @html.text!('true')
                        else
                            @html.text!('false')
                        end
                        @html.br

                        # grid information - dimensions
                        aDims = hGrid[:dimensionInfo]
                        aDims.each do |hDim|
                            @html.details do
                                @html.summary('Dimension', {'class'=>'h4'})
                                @html.section(:class=>'block') do
                                    htmlDim.writeHtml(hDim)
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
