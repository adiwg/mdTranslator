# GeoJson FeatureCollection
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-06 original script

require_relative 'class_feature'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class FeatureCollection

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoObject)

                  # classes used
                  featureClass = Feature.new(@xml, @hResponseObj)

                  # feature collection attributes
                  attributes = {}

                  # feature collection attributes - gml:id (required)
                  @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                  objId = 'featureCollection' + @hResponseObj[:writerMissingIdCount]
                  attributes['gml:id'] = objId

                  # feature collection attributes - srsName (GeoJSON is WGS84)
                  attributes[:srsName] = 'WGS84'

                  @xml.tag!('gml:MultiGeometry', attributes) do

                     # geometry collection - geometry objects (required)
                     @xml.tag!('gml:geometryMembers') do
                        unless hGeoObject[:features].empty?
                           aFeatures = hGeoObject[:features]
                           aFeatures.each do |hFeature|
                              featureClass.writeXML(hFeature)
                           end
                        end
                     end

                  end # gml:MultiGeometry tag
               end # writeXML
            end # FeatureCollection class

         end
      end
   end
end
