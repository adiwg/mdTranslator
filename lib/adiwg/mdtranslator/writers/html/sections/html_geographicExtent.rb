# HTML writer
# geographic extent

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-31 original script

require_relative 'html_temporalExtent'
require_relative 'html_verticalExtent'
require_relative 'html_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GeographicExtent

               def initialize(html)
                  @html = html
               end

               def writeHtml(hElement)

                  @html.text!('Nothing yet')

                  # # classes used
                  # htmlTempEle = MdHtmlTemporalElement.new(@html)
                  # htmlVertEle = MdHtmlVerticalElement.new(@html)
                  # htmlResID = MdHtmlResourceId.new(@html)
                  #
                  # # geographic element - element ID
                  # s = hElement[:elementId]
                  # if !s.nil?
                  #    @html.em('Element ID: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # geographic element - name
                  # s = hElement[:elementName]
                  # if !s.nil?
                  #    @html.em('Name: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # geographic element - element description
                  # s = hElement[:elementDescription]
                  # if !s.nil?
                  #    @html.em('Description: ')
                  #    @html.section(:class => 'block') do
                  #       @html.text!(s)
                  #    end
                  # end
                  #
                  # # geographic element - scope
                  # s = hElement[:elementScope]
                  # if !s.nil?
                  #    @html.em('Scope of the resource defined by geometry: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # geographic element - encompasses data
                  # b = hElement[:elementIncludeData]
                  # if !b.nil?
                  #    @html.em('Geometry defines an area encompassing data: ')
                  #    @html.text!(b.to_s)
                  #    @html.br
                  # end
                  #
                  # # geographic element - method of acquisition
                  # s = hElement[:elementAcquisition]
                  # if !s.nil?
                  #    @html.em('Method used to acquire geometry position: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # geographic element - coordinate reference system
                  # hSRS = hElement[:elementSrs]
                  # if !hSRS.empty?
                  #    @html.em('Coordinate reference system:')
                  #    @html.section(:class => 'block') do
                  #
                  #       # coordinate reference system - by name
                  #       s = hSRS[:srsName]
                  #       if !s.nil?
                  #          @html.em('CRS Name: ')
                  #          @html.text!(s)
                  #          @html.br
                  #       end
                  #
                  #       # coordinate reference system - by link
                  #       s = hSRS[:srsHref]
                  #       if !s.nil?
                  #          @html.em('CRS web link: ')
                  #          @html.section(:class => 'block') do
                  #             @html.a(s)
                  #          end
                  #       end
                  #
                  #       # coordinate reference system - link type
                  #       s = hSRS[:srsType]
                  #       if !s.nil?
                  #          @html.em('CRS web link type: ')
                  #          @html.text!(s)
                  #          @html.br
                  #       end
                  #
                  #    end
                  # end
                  #
                  # # geographic element - element geometry - required
                  # @html.em('Element geometry:')
                  # @html.section(:class => 'block') do
                  #
                  #    # multi-geometries need to be written using this class recursively
                  #    if hElement[:elementGeometry][:geoType] == 'MultiGeometry'
                  #       geoNum = 0
                  #       hElement[:elementGeometry][:geometry].each do |hGeometry|
                  #          @html.details do
                  #             eleNum = geoPre + '.' + geoNum.to_s
                  #             @html.summary('Sub-element ' + eleNum, {'class' => 'h5'})
                  #             geoNum += 1
                  #             @html.section(:class => 'block') do
                  #                writeHtml(hGeometry, eleNum)
                  #             end
                  #          end
                  #       end
                  #    else
                  #
                  #       # geographic element - in GeoJson
                  #       @html.em('GeoJSON format: ')
                  #       @html.section(:class => 'block') do
                  #          geoJson = AdiwgGeoFormat.internal_to_geoJson(hElement)
                  #          popData = hElement[:elementName] || hElement[:elementDescription] || hElement[:elementId] || geoPre
                  #          @html.div({'id' => 'geojson-' + geoPre, 'class' => 'geojson', 'data-popup' => popData}) do
                  #             @html.text!(geoJson)
                  #          end
                  #       end
                  #
                  #       # geographic element - in Well-Know-Text
                  #       @html.em('Well-Know-Text format: ')
                  #       @html.section(:class => 'block') do
                  #          wkt = AdiwgGeoFormat.internal_to_wkt(hElement[:elementGeometry])
                  #          @html.div({'id' => 'wkt-' + geoPre, 'class' => 'wkt'}) do
                  #             @html.text!(wkt)
                  #          end
                  #       end
                  #
                  #    end
                  # end
                  #
                  # # geographic element - element vertical space
                  # aVertEle = hElement[:verticalElements]
                  # if !aVertEle.empty?
                  #    @html.details do
                  #       @html.summary('Vertical Elements ', {'class' => 'h6'})
                  #       eleNun = 0
                  #       aVertEle.each do |hVertEle|
                  #          @html.section(:class => 'block') do
                  #             @html.details do
                  #                @html.summary('Element ' + eleNun.to_s, {'class' => 'h6'})
                  #                eleNun += 1
                  #                @html.section(:class => 'block') do
                  #                   htmlVertEle.writeHtml(hVertEle)
                  #                end
                  #             end
                  #          end
                  #       end
                  #    end
                  # end
                  #
                  # # geographic element - element temporal space
                  # aTempEle = hElement[:temporalElements]
                  # if !aTempEle.empty?
                  #    @html.details do
                  #       @html.summary('Temporal Elements ', {'class' => 'h6'})
                  #       @html.section(:class => 'block') do
                  #          aTempEle.each do |hTempEle|
                  #             htmlTempEle.writeHtml(hTempEle)
                  #          end
                  #       end
                  #    end
                  # end
                  #
                  # # geographic element - element identifiers
                  # aIDs = hElement[:elementIdentifiers]
                  # if !aIDs.empty?
                  #    @html.details do
                  #       @html.summary('Elements Identifiers', {'class' => 'h6'})
                  #       aIDs.each do |hEleID|
                  #          s = hEleID[:identifier]
                  #          @html.section(:class => 'block') do
                  #             @html.details do
                  #                @html.summary(s, {'class' => 'h6'})
                  #                @html.section(:class => 'block') do
                  #                   htmlResID.writeHtml(hEleID)
                  #                end
                  #             end
                  #          end
                  #       end
                  #    end
                  # end

               end # writeHtml
            end # Html_GeographicExtent

         end
      end
   end
end
