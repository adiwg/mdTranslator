# ISO <<Class>> EX_Extent
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-01 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-29 ... added new class for geographicElement
#  Stan Smith 2014-05-29 changes for json schema version 0.5.0
# 	Stan Smith 2013-11-15 add vertical elements
# 	Stan Smith 2013-11-15 add temporal elements
# 	Stan Smith 2013-11-01 original script

require_relative 'class_geographicExtent'
require_relative 'class_temporalExtent'
require_relative 'class_verticalExtent'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
