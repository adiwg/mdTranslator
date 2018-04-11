# GML Polygon
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-05 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-16 moved module_coordinates from mdJson reader to internal
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-30 modified for version 0.5.0
# 	Stan Smith 2013-11-18 original script.

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
