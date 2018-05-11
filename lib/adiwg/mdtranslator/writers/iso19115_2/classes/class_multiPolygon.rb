# GML MultiPolygon
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-06 original script

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'class_polygon'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MultiPolygon

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoObject, hProperties, objId)

                  # classes used
                  geoPropClass = FeatureProperties.new(@xml, @hResponseObj)

                  # classes used
                  polyClass = Polygon.new(@xml, @hResponseObj)

                  # multiPolygon attributes
                  attributes = {}

                  # multiPolygon attributes - gml:id (required)
                  if objId.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     objId = 'multiPolygon' + @hResponseObj[:writerMissingIdCount]
                  else
                     objId.gsub!(/[^0-9a-zA-Z]/, '')
                  end
                  attributes['gml:id'] = objId

                  # multiPolygon attributes - srsDimension
                  s = AdiwgCoordinates.getDimension(hGeoObject[:coordinates])
                  if !s.nil?
                     attributes[:srsDimension] = s
                  end

                  # multiPolygon attributes - srsName (GeoJSON is WGS84)
                  attributes[:srsName] = 'WGS84'

                  @xml.tag!('gml:MultiGeometry', attributes) do

                     # multiPolygon - properties for Feature
                     unless hProperties.empty?
                        geoPropClass.writeXML(hProperties)
                     end
                     if hProperties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                        @xml.tag!('gml:name')
                     end

                     # multiPolygon - polygon members (required)
                     @xml.tag!('gml:geometryMembers') do
                        unless hGeoObject[:coordinates].empty?
                           aPolys = hGeoObject[:coordinates]
                           aPolys.each do |aPoly|
                              newPoly = {}
                              newPoly[:type] = 'Polygon'
                              newPoly[:coordinates] = aPoly
                              polyClass.writeXML(newPoly, {}, nil)
                           end
                        end
                     end

                  end # gml:MultiGeometry tag
               end # writeXML
            end # MultiPolygon class

         end
      end
   end
end
