# ISO <<Class>> geographicElement {abstract}
# 19115-3 writer output in XML

# History:
#  Stan Smith 2019-03-19 original script

require_relative 'class_boundingBox'
require_relative 'class_identifier'
require_relative 'class_geographicElement'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class GeographicExtent

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoExtent)

                  # classes used
                  bBoxClass = EX_GeographicBoundingBox.new(@xml, @hResponseObj)
                  idClass = MD_Identifier.new(@xml, @hResponseObj)
                  geoEleClass = GeographicElement.new(@xml, @hResponseObj)

                  extType = hGeoExtent[:containsData]

                  # geographic element - geographic bounding box
                  # test for user provided bounding box
                  # if empty, use computedBbox
                  hBbox = hGeoExtent[:boundingBox]
                  if hBbox.empty?
                     hBbox = hGeoExtent[:computedBbox]
                  end
                  unless hBbox.empty?
                     @xml.tag!('gex:geographicElement') do
                        @xml.tag!('gex:EX_GeographicBoundingBox') do

                           # geographic bounding box - extent type {Boolean}
                           @xml.tag!('gex:extentTypeCode') do
                              @xml.tag!('gco:Boolean', extType)
                           end

                           # geographic bounding box - bounding box
                           bBoxClass.writeXML(hBbox)
                        end
                     end
                  end

                  # geographic element - geographic description
                  unless hGeoExtent[:identifier].empty?
                     @xml.tag!('gex:geographicElement') do
                        @xml.tag!('gex:EX_GeographicDescription') do

                           # geographic description - extent type {Boolean}
                           @xml.tag!('gex:extentTypeCode') do
                              @xml.tag!('gco:Boolean', extType)
                           end

                           # geographic description - geographic identifier {MD_Identifier}
                           @xml.tag!('gex:geographicIdentifier') do
                              idClass.writeXML(hGeoExtent[:identifier], 'geographic extent')
                           end

                        end
                     end
                  end

                  # geographic element - geographic bounding polygon
                  unless hGeoExtent[:geographicElements].empty?
                     @xml.tag!('gex:geographicElement') do
                        @xml.tag!('gex:EX_BoundingPolygon') do

                           # bounding polygon - extent type {Boolean}
                           @xml.tag!('gex:extentTypeCode') do
                              @xml.tag!('gco:Boolean', extType)
                           end

                           # bounding polygon - geographic elements {GeoJSON}
                           geoEleClass.writeXML(hGeoExtent[:geographicElements])

                        end
                     end
                  end

               end # writeXML
            end # GeographicExtent class

         end
      end
   end
end
