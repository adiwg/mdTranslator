# GML Point
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-20 original script

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class Point

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoObject, hProperties, objId)

                  # classes used
                  geoPropClass = FeatureProperties.new(@xml, @hResponseObj)

                  # Point attributes
                  attributes = {}

                  # Point attributes - gml:id (required)
                  if objId.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     objId = 'point' + @hResponseObj[:writerMissingIdCount]
                  else
                     objId.gsub!(/[^0-9a-zA-Z]/,'')
                  end
                  attributes['gml:id'] = objId

                  # Point attributes - srsDimension
                  nDimension = AdiwgCoordinates.getDimension(hGeoObject[:coordinates])
                  unless nDimension.nil?
                     attributes[:srsDimension] = nDimension
                  end

                  # Point attributes - srsName (GeoJSON is WGS84)
                  attributes[:srsName] = 'WGS84'

                  @xml.tag!('gml:Point', attributes) do

                     # point - properties for Feature
                     unless hProperties.empty?
                        geoPropClass.writeXML(hProperties)
                     end
                     if hProperties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                        @xml.tag!('gml:name')
                     end

                     # point - pos (required)
                     s = ''
                     unless hGeoObject[:coordinates].empty?
                        hGeoObject[:coordinates].each do |coord|
                           s += coord.to_s + ' '
                        end
                        s = s.strip
                     end
                     @xml.tag!('gml:pos', s)

                  end # gml:Point tag
               end # writeXML
            end # Point class

         end
      end
   end
end
