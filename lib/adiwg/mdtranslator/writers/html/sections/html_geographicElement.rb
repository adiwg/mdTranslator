# HTML writer
# geographic element

# History:
# 	Stan Smith 2015-03-31 original script

require 'adiwg/mdtranslator/internal/module_geoFormat'
require 'html_temporalElement'
require 'html_verticalElement'
require 'html_resourceId'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlGeographicElement
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hGeoEle, geoPre)

                        # classes used
                        htmlTempEle = $HtmlNS::MdHtmlTemporalElement.new(@html)
                        htmlVertEle = $HtmlNS::MdHtmlVerticalElement.new(@html)
                        htmlResID = $HtmlNS::MdHtmlResourceId.new(@html)

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
                            @html.section(:class=>'block') do
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
                            @html.section(:class=>'block') do

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
                                    @html.section(:class=>'block') do
                                        @html.a(s)
                                    end
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
                        @html.section(:class=>'block') do

                            # multi-geometries need to be written using this class recursively
                            if hGeoEle[:elementGeometry][:geoType] == 'MultiGeometry'
                                geoNum = 0
                                hGeoEle[:elementGeometry][:geometry].each do |hGeometry|
                                    @html.details do
                                        eleNum = geoPre + '.' + geoNum.to_s
                                        @html.summary('Sub-element ' + eleNum, {'class'=>'h5'})
                                        geoNum += 1
                                        @html.section(:class=>'block') do
                                            writeHtml(hGeometry, eleNum)
                                        end
                                    end
                                end
                            else

                                # geographic element - in GeoJson
                                @html.em('GeoJSON format: ')
                                @html.section(:class=>'block') do
                                    geoJson = AdiwgGeoFormat.internal_to_geoJson(hGeoEle)
                                    popData = hGeoEle[:elementName] || hGeoEle[:elementDescription] || hGeoEle[:elementId]
                                    @html.div({'id'=>'geojson-' + geoPre, 'class'=>'geojson', 'data-popup' => popData}) do
                                        @html.text!(geoJson)
                                    end
                                end

                                # geographic element - in Well-Know-Text
                                @html.em('Well-Know-Text format: ')
                                @html.section(:class=>'block') do
                                    wkt = AdiwgGeoFormat.internal_to_wkt(hGeoEle[:elementGeometry])
                                    @html.div({'id'=>'wkt-' + geoPre, 'class'=>'wkt'}) do
                                        @html.text!(wkt)
                                    end
                                end

                             end
                        end

                        # geographic element - element vertical space
                        aVertEle = hGeoEle[:verticalElements]
                        if !aVertEle.empty?
                            @html.details do
                                @html.summary('Vertical Elements ', {'class'=>'h6'})
                                eleNun = 0
                                aVertEle.each do |hVertEle|
                                    @html.section(:class=>'block') do
                                        @html.details do
                                            @html.summary('Element ' + eleNun.to_s, {'class'=>'h6'})
                                            eleNun += 1
                                            @html.section(:class=>'block') do
                                                htmlVertEle.writeHtml(hVertEle)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # geographic element - element temporal space
                        aTempEle = hGeoEle[:temporalElements]
                        if !aTempEle.empty?
                            @html.details do
                                @html.summary('Temporal Elements ', {'class'=>'h6'})
                                @html.section(:class=>'block') do
                                    aTempEle.each do |hTempEle|
                                        htmlTempEle.writeHtml(hTempEle)
                                    end
                                end
                            end
                        end

                        # geographic element - element identifiers
                        aIDs = hGeoEle[:elementIdentifiers]
                        if !aIDs.empty?
                            @html.details do
                                @html.summary('Elements Identifiers', {'class'=>'h6'})
                                aIDs.each do |hEleID|
                                    s = hEleID[:identifier]
                                    @html.section(:class=>'block') do
                                        @html.details do
                                            @html.summary(s, {'class'=>'h6'})
                                            @html.section(:class=>'block') do
                                                htmlResID.writeHtml(hEleID)
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
