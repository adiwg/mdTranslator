# HTML writer
# geographic element

# History:
# 	Stan Smith 2015-03-31 original script

require 'adiwg/mdtranslator/internal/module_geoFormat'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlGeographicElement
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hGeoEle)

                        # classes used

                        # geographic element - element ID
                        s = hGeoEle[:elementId]
                        if !s.nil?
                            @html.em('Element ID: ')
                            @html.text!(s)
                            @html.br
                        end

                        # geographic element - name
                        s = hGeoEle[:elementName]
                        if !s.nil?
                            @html.em('Name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # geographic element - element description
                        s = hGeoEle[:elementDescription]
                        if !s.nil?
                            @html.em('Description: ')
                            @html.blockquote do
                                @html.text!(s)
                            end
                        end

                        # geographic element - scope
                        s = hGeoEle[:elementScope]
                        if !s.nil?
                            @html.em('Scope of the resource defined by geometry: ')
                            @html.text!(s)
                            @html.br
                        end

                        # geographic element - encompasses data
                        b = hGeoEle[:elementIncludeData]
                        if !b.nil?
                            @html.em('Geometry defines an area encompassing data: ')
                            @html.text!(b.to_s)
                            @html.br
                        end

                        # geographic element - method of acquisition
                        s = hGeoEle[:elementAcquisition]
                        if !s.nil?
                            @html.em('Method used to acquire geometry position: ')
                            @html.text!(s)
                            @html.br
                        end

                        # geographic element - coordinate reference system
                        hSRS = hGeoEle[:elementSrs]
                        if !hSRS.empty?
                            @html.em('Coordinate reference system:')
                            @html.blockquote do

                                # coordinate reference system - by name
                                s = hSRS[:srsName]
                                if !s.nil?
                                    @html.em('CRS Name: ')
                                    @html.text!(s)
                                    @html.br
                                end

                                # coordinate reference system - by link
                                s = hSRS[:srsHref]
                                if !s.nil?
                                    @html.em('CRS web link: ')
                                    @html.text!(s)
                                    @html.br
                                end

                                # coordinate reference system - link type
                                s = hSRS[:srsType]
                                if !s.nil?
                                    @html.em('CRS web link type: ')
                                    @html.text!(s)
                                    @html.br
                                end

                            end
                        end

                        # geographic element - element geometry - required
                        @html.em('Element geometry:')
                        @html.blockquote do

                            # multi-geometries need to be written using this class recursively
                            if hGeoEle[:elementGeometry][:geoType] == 'MultiGeometry'
                                eleNun = 0
                                hGeoEle[:elementGeometry][:geometry].each do |hGeometry|
                                    @html.details do
                                        @html.summary('Sub-element ' + eleNun.to_s, {'class'=>'h5'})
                                        eleNun += 1
                                        @html.blockquote do
                                            writeHtml(hGeometry)
                                        end
                                    end
                                end
                            else

                                # geographic element - in GeoJson
                                @html.em('GeoJSON format: ')
                                @html.blockquote do
                                    geoJson = AdiwgGeoFormat.internal_to_geoJson(hGeoEle)
                                    @html.div({'id'=>'geojson-001'}) do
                                        @html.text!(geoJson)
                                    end
                                end

                                # geographic element - in Well-Know-Text
                                @html.em('Well-Know-Text format: ')
                                @html.blockquote do
                                    wkt = AdiwgGeoFormat.internal_to_wkt(hGeoEle[:elementGeometry])
                                    @html.div({'id'=>'wkt-001'}) do
                                        @html.text!(wkt)
                                    end
                                end

                             end
                        end

                        # geographic element - element vertical space
                        @html.em('element vertical space - TODO')
                        @html.br

                        # geographic element - element temporal space
                        @html.em('element temporal space - TODO')
                        @html.br

                        # geographic element - element identifiers
                        @html.em('element identifiers - TODO')
                        @html.br

                    end # writeHtml

                end # class

            end
        end
    end
end
