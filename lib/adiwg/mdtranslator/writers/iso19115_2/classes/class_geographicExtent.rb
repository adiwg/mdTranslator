# ISO <<Class>> geographicElement {abstract}
# writer output in XML

# History:
#  Stan Smith 2016-12-02 original script

require_relative 'class_boundingBox'
require_relative 'class_mdIdentifier'
require_relative 'class_geographicElement'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
                  # if empty, take computedBbox
                  hBbox = hGeoExtent[:boundingBox]
                  if hBbox.empty?
                     hBbox = hGeoExtent[:computedBbox]
                  end
                  unless hBbox.empty?
                     @xml.tag!('gmd:geographicElement') do
                        @xml.tag!('gmd:EX_GeographicBoundingBox') do
                           @xml.tag!('gmd:extentTypeCode') do
                              @xml.tag!('gco:Boolean', extType)
                           end
                           bBoxClass.writeXML(hBbox)
                        end
                     end
                  end

                  # geographic element - geographic description
                  unless hGeoExtent[:identifier].empty?
                     @xml.tag!('gmd:geographicElement') do
                        @xml.tag!('gmd:EX_GeographicDescription') do
                           @xml.tag!('gmd:extentTypeCode') do
                              @xml.tag!('gco:Boolean', extType)
                           end
                           @xml.tag!('gmd:geographicIdentifier') do
                              idClass.writeXML(hGeoExtent[:identifier], 'geographic extent')
                           end
                        end
                     end
                  end

                  # geographic element - geographic bounding polygon
                  unless hGeoExtent[:geographicElements].empty?
                     @xml.tag!('gmd:geographicElement') do
                        @xml.tag!('gmd:EX_BoundingPolygon') do
                           @xml.tag!('gmd:extentTypeCode') do
                              @xml.tag!('gco:Boolean', extType)
                           end
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
