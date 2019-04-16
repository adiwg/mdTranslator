# ISO <<Class>> MD_VectorSpatialRepresentation
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-16 original script.

require_relative 'class_codelist'
require_relative 'class_geometricObjects'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_VectorSpatialRepresentation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hVector, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  geoObjClass = MD_GeometricObjects.new(@xml, @hResponseObj)

                  outContext = 'vector representation'
                  outContext = inContext + ' vector representation' unless inContext.nil?

                  @xml.tag!('msr:MD_VectorSpatialRepresentation') do

                     # vector representation - topology level
                     unless hVector[:topologyLevel].nil?
                        @xml.tag!('msr:topologyLevel') do
                           codelistClass.writeXML('msr', 'iso_topologyLevel', hVector[:topologyLevel])
                        end
                     end
                     if hVector[:topologyLevel].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:topologyLevel')
                     end

                     # vector representation - geometric objects [{MD_GeometricObjects}]
                     aGeoObjs = hVector[:vectorObject]
                     aGeoObjs.each do |hGeoObj|
                        @xml.tag!('msr:geometricObjects') do
                           geoObjClass.writeXML(hGeoObj, outContext)
                        end
                     end
                     if aGeoObjs.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:geometricObjects')
                     end

                  end # msr:MD_VectorSpatialRepresentation tag
               end # writeXML
            end # MD_VectorSpatialRepresentation class

         end
      end
   end
end
