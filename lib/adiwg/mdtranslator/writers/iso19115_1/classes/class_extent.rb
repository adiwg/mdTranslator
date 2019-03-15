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

                  @xml.tag!('gmd:EX_Extent') do

                     # extent - description
                     s = hExtent[:description]
                     unless s.nil?
                        @xml.tag!('gmd:description') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:description')
                     end

                     # extent - geographic extent []
                     aGeoExtents = hExtent[:geographicExtents]
                     aGeoExtents.each do |hGeoExtent|
                        geoExtClass.writeXML(hGeoExtent)
                     end
                     if aGeoExtents.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:geographicElement')
                     end

                     # extent - temporal extent []
                     aTempElements = hExtent[:temporalExtents]
                     aTempElements.each do |hTempElement|
                        @xml.tag!('gmd:temporalElement') do
                           tempExtClass.writeXML(hTempElement)
                        end
                     end
                     if aTempElements.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:temporalElement')
                     end

                     # extent - vertical extent []
                     aVertElements = hExtent[:verticalExtents]
                     aVertElements.each do |hVertElement|
                        @xml.tag!('gmd:verticalElement') do
                           vertExtClass.writeXML(hVertElement)
                        end
                     end
                     if aVertElements.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:verticalElement')
                     end

                  end # gmd:EX_Extent tag
               end # writeXML
            end # EX_Extent class

         end
      end
   end
end
