# GML Point
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
# 	Stan Smith 2013-11-01 original script

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
                  s = AdiwgCoordinates.getDimension(hGeoObject[:coordinates])
                  if !s.nil?
                     attributes[:srsDimension] = s
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
