# HTML writer
# extents (geographic, temporal, vertical)

# History:
# 	Stan Smith 2015-03-31 original script

require 'html_geographicElement'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlExtent
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hExtent)

                        # classes used
                        htmlGeoEle = $HtmlNS::MdHtmlGeographicElement.new(@html)

                        aGeoEle = hExtent[:extGeoElements]
                        aIdEle = hExtent[:extIdElements]
                        aTempEle = hExtent[:extTempElements]
                        aVertEle = hExtent[:extVertElements]

                        # extent - description
                        s = hExtent[:extDesc]
                        if !s.nil?
                            @html.em('Extent description: ')
                            @html.blockquote do
                                @html.text!(s)
                            end
                        end

                        # extent - geographic elements
                        if !aGeoEle.empty?
                            @html.details do
                                @html.summary('Geographic elements', {'class'=>'h4'})
                                eleNun = 0
                                aGeoEle.each do |hGeoEle|
                                    @html.blockquote do
                                        @html.details do
                                            @html.summary('Element ' + eleNun.to_s, {'class'=>'h5'})
                                            eleNun += 1
                                            @html.blockquote do
                                                htmlGeoEle.writeHtml(hGeoEle)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # extent - vertical elements
                        if !aVertEle.empty?
                            @html.details do
                                @html.summary('Vertical elements', {'class'=>'h4'})
                                eleNun = 0
                                aVertEle.each do |hVertEle|
                                    @html.blockquote do
                                        @html.details do
                                            @html.summary('Element ' + eleNun.to_s, {'class'=>'h5'})
                                            eleNun += 1
                                            @html.blockquote do

                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # extent - temporal elements
                        if !aTempEle.empty?
                            @html.details do
                                @html.summary('Temporal elements', {'class'=>'h4'})
                                eleNun = 0
                                aTempEle.each do |hTempEle|
                                    @html.blockquote do
                                        @html.details do
                                            @html.summary('Element ' + eleNun.to_s, {'class'=>'h5'})
                                            eleNun += 1
                                            @html.blockquote do

                                            end
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
