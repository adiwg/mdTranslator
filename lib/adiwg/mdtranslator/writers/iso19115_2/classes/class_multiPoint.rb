# GML MultiPoint
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-05 original script

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'class_point'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MultiPoint

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoObject, hProperties, objId)

                  # classes used
                  geoPropClass = FeatureProperties.new(@xml, @hResponseObj)

                  # classes used
                  pointClass = Point.new(@xml, @hResponseObj)

                  # multiPoint attributes
                  attributes = {}

                  # multiPoint attributes - gml:id (required)
                  if objId.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     objId = 'multiPoint' + @hResponseObj[:writerMissingIdCount]
                  else
                     objId.gsub!(/[^0-9a-zA-Z]/, '')
                  end
                  attributes['gml:id'] = objId

                  # multiPoint attributes - srsDimension
                  s = AdiwgCoordinates.getDimension(hGeoObject[:coordinates])
                  if !s.nil?
                     attributes[:srsDimension] = s
                  end

                  # multiPoint attributes - srsName (GeoJSON is WGS84)
                  attributes[:srsName] = 'WGS84'

                  @xml.tag!('gml:MultiPoint', attributes) do

                     # multipoint - properties for Feature
                     unless hProperties.empty?
                        geoPropClass.writeXML(hProperties)
                     end
                     if hProperties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                        @xml.tag!('gml:name')
                     end

                     # multipoint - point members (required)
                     @xml.tag!('gml:pointMembers') do
                        unless hGeoObject[:coordinates].empty?
                           aPoints = hGeoObject[:coordinates]
                           aPoints.each do |aPoint|
                              newPoint = {}
                              newPoint[:type] = 'Point'
                              newPoint[:coordinates] = aPoint
                              pointClass.writeXML(newPoint, {}, nil)
                           end
                        end
                     end

                  end # gml:Point tag
               end # writeXML
            end # multiPoint class

         end
      end
   end
end
