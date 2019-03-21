# GML Polygon
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-20 original script.

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class Polygon

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoObject, hProperties, objId)

                  # classes used
                  geoPropClass = FeatureProperties.new(@xml, @hResponseObj)

                  # polygon attributes
                  attributes = {}

                  # polygon attributes - gml:id (required)
                  if objId.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     objId = 'polygon' + @hResponseObj[:writerMissingIdCount]
                  else
                     objId.gsub!(/[^0-9a-zA-Z]/, '')
                  end
                  attributes['gml:id'] = objId

                  # polygon attributes - srsDimension
                  s = AdiwgCoordinates.getDimension(hGeoObject[:coordinates])
                  if !s.nil?
                     attributes[:srsDimension] = s
                  end

                  # polygon attributes - srsName (GeoJSON is WGS84)
                  attributes[:srsName] = 'WGS84'

                  @xml.tag!('gml:Polygon', attributes) do

                     # polygon - properties for Feature
                     unless hProperties.empty?
                        geoPropClass.writeXML(hProperties)
                     end
                     if hProperties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                        @xml.tag!('gml:name')
                     end

                     aPolygons = hGeoObject[:coordinates]
                     aExterior = aPolygons[0]
                     aInterior = aPolygons.drop(1)

                     # polygon - exterior ring (required)
                     unless aExterior.nil?
                        @xml.tag!('gml:exterior') do
                           @xml.tag!('gml:LinearRing') do
                              aExterior.each do |aCoord|
                                 s = aCoord[0].to_s + ' ' + aCoord[1].to_s
                                 @xml.tag!('gml:pos', s)
                              end
                           end
                        end
                     end

                     # polygon - interior rings
                     aInterior.each do |aRing|
                        @xml.tag!('gml:interior') do
                           @xml.tag!('gml:LinearRing') do
                              aRing.each do |aCoord|
                                 s = aCoord[0].to_s + ' ' + aCoord[1].to_s
                                 @xml.tag!('gml:pos', s)
                              end
                           end
                        end
                     end

                  end # gml:Polygon tag
               end # writeXML
            end # Polygon class

         end
      end
   end
end
