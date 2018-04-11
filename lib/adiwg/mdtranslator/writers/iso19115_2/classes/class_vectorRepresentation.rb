# ISO <<Class>> MD_VectorSpatialRepresentation
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2016-12-08 original script.

require_relative 'class_codelist'
require_relative 'class_geometricObjects'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_VectorSpatialRepresentation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hVector)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  geoObjClass = MD_GeometricObjects.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_VectorSpatialRepresentation') do

                     # vector representation - topology level
                     s = hVector[:topologyLevel]
                     unless s.nil?
                        @xml.tag!('gmd:topologyLevel') do
                           codelistClass.writeXML('gmd', 'iso_topologyLevel', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:topologyLevel')
                     end

                     # vector representation - geometric objects [{MD_GeometricObjects}]
                     aGeoObjs = hVector[:vectorObject]
                     aGeoObjs.each do |hGeoObj|
                        @xml.tag!('gmd:geometricObjects') do
                           geoObjClass.writeXML(hGeoObj)
                        end
                     end
                     if aGeoObjs.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:geometricObjects')
                     end

                  end # gmd:MD_VectorSpatialRepresentation tag
               end # writeXML
            end # MD_VectorSpatialRepresentation class

         end
      end
   end
end
