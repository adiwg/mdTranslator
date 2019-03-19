# ISO <<Class>> EX_Extent
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-15 original script

require_relative 'class_geographicExtent'
require_relative 'class_temporalExtent'
require_relative 'class_verticalExtent'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class EX_Extent

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hExtent, inContext = nil)

                  # classes used
                  tempExtClass = EX_TemporalExtent.new(@xml, @hResponseObj)
                  vertExtClass = EX_VerticalExtent.new(@xml, @hResponseObj)
                  geoExtClass = GeographicExtent.new(@xml, @hResponseObj)

                  outContext = 'extent'
                  outContext = inContext + ' extent' unless inContext.nil?

                  @xml.tag!('gex:EX_Extent') do

                     # extent - description
                     unless hExtent[:description].nil?
                        @xml.tag!('gex:description') do
                           @xml.tag!('gco:CharacterString', hExtent[:description])
                        end
                     end
                     if hExtent[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gex:description')
                     end

                     # extent - geographic extent []
                     # {EX_GeographicDescription | EX_GeographicBoundingBox | EX_BoundingPolygon}
                     aGeoExtents = hExtent[:geographicExtents]
                     aGeoExtents.each do |hGeoExtent|
                        geoExtClass.writeXML(hGeoExtent)
                     end
                     if aGeoExtents.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gex:geographicElement')
                     end

                     # extent - temporal extent [] {EX_TemporalExtent}
                     # EX_SpatialTemporalExtent not implemented
                     aTempElements = hExtent[:temporalExtents]
                     aTempElements.each do |hTempElement|
                        @xml.tag!('gex:temporalElement') do
                           tempExtClass.writeXML(hTempElement)
                        end
                     end
                     if aTempElements.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gex:temporalElement')
                     end

                     # extent - vertical extent [] {EX_VerticalExtent}
                     aVertElements = hExtent[:verticalExtents]
                     aVertElements.each do |hVertElement|
                        @xml.tag!('gex:verticalElement') do
                           vertExtClass.writeXML(hVertElement)
                        end
                     end
                     if aVertElements.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gex:verticalElement')
                     end

                  end # gmd:EX_Extent tag
               end # writeXML
            end # EX_Extent class

         end
      end
   end
end
