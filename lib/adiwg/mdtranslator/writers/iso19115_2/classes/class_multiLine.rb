# GML MultiLineSting
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-06 original script

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'class_lineString'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MultiLineString

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoObject, hProperties, objId)

                  # classes used
                  geoPropClass = FeatureProperties.new(@xml, @hResponseObj)

                  # classes used
                  lineClass = LineString.new(@xml, @hResponseObj)

                  # multiLineString attributes
                  attributes = {}

                  # multiLineString attributes - gml:id (required)
                  if objId.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     objId = 'multiLine' + @hResponseObj[:writerMissingIdCount]
                  else
                     objId.gsub!(/[^0-9a-zA-Z]/, '')
                  end
                  attributes['gml:id'] = objId

                  # multiLineString attributes - srsDimension
                  s = AdiwgCoordinates.getDimension(hGeoObject[:coordinates])
                  if !s.nil?
                     attributes[:srsDimension] = s
                  end

                  # multiLineString attributes - srsName (GeoJSON is WGS84)
                  attributes[:srsName] = 'WGS84'

                  @xml.tag!('gml:MultiGeometry', attributes) do

                     # multiLineString - properties for Feature
                     unless hProperties.empty?
                        geoPropClass.writeXML(hProperties)
                     end
                     if hProperties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                        @xml.tag!('gml:name')
                     end

                     # multiLineString - lineString members (required)
                     @xml.tag!('gml:geometryMembers') do
                        unless hGeoObject[:coordinates].empty?
                           aLines = hGeoObject[:coordinates]
                           aLines.each do |aLine|
                              newLine = {}
                              newLine[:type] = 'LineString'
                              newLine[:coordinates] = aLine
                              lineClass.writeXML(newLine, {}, nil)
                           end
                        end
                     end

                  end # gml:MultiGeometry tag
               end # writeXML
            end # MultiLineString class

         end
      end
   end
end
