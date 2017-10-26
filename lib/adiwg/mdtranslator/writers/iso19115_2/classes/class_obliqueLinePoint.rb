# ISO <<Class>> MD_ObliqueLinePoint
# writer
# 19115-2 output for ISO 19115-2 XML

# History:
# 	Stan Smith 2017-10-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_ObliqueLinePoint

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hLinePoint)

                  @xml.tag!('gmd:MD_ObliqueLinePoint') do

                     # oblique line point - azimuth line latitude {integer}
                     r = hLinePoint[:azimuthLineLatitude]
                     unless r.nil?
                        @xml.tag!('gmd:azimuthLineLatitude') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:azimuthLineLatitude')
                     end

                     # oblique line point - azimuth line longitude {real}
                     r = hLinePoint[:azimuthLineLongitude]
                     unless r.nil?
                        @xml.tag!('gmd:azimuthLineLongitude') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:azimuthLineLongitude')
                     end

                  end # gmd:MD_ObliqueLinePoint
               end # writeXML
            end # MD_ProjectionParameters class

         end
      end
   end
end
