# GML LineString
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-20 original script.

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class LineString

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoObject, hProperties, lineId)

                  # classes used
                  geoPropClass = FeatureProperties.new(@xml, @hResponseObj)

                  # LineString attributes
                  attributes = {}

                  # LineString attributes - gml:id (required)
                  if lineId.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     lineId = 'line' + @hResponseObj[:writerMissingIdCount]
                  else
                     lineId.gsub!(/[^0-9a-zA-Z]/, '')
                  end
                  attributes['gml:id'] = lineId

                  # LineString attributes - srsDimension
                  s = AdiwgCoordinates.getDimension(hGeoObject[:coordinates])
                  if !s.nil?
                     attributes[:srsDimension] = s
                  end

                  # LineString attributes - srsName (GeoJSON is WGS84)
                  attributes[:srsName] = 'WGS84'

                  @xml.tag!('gml:LineString', attributes) do

                     # lineString - properties for Feature
                     unless hProperties.empty?
                        geoPropClass.writeXML(hProperties)
                     end
                     if hProperties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                        @xml.tag!('gml:name')
                     end

                     # lineString - pos (required)
                     unless hGeoObject[:coordinates].empty?
                        aCoords = hGeoObject[:coordinates]
                        aCoords.each do |aCoord|
                           s = aCoord[0].to_s + ' ' + aCoord[1].to_s
                           @xml.tag!('gml:pos', s)
                        end
                     end

                  end # gml:LineString
               end # writeXML
            end # LineString class

         end
      end
   end
end
