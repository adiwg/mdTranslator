# ISO <<Class>> EX_GeographicBoundingBox
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-19 original script

require_relative '../iso19115_3_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class EX_GeographicBoundingBox

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hBBox)

                  # bounding box - west longitude (required)
                  unless hBBox[:westLongitude].nil?
                     @xml.tag!('gex:westBoundLongitude') do
                        @xml.tag!('gco:Decimal', hBBox[:westLongitude])
                     end
                  end
                  if hBBox[:westLongitude].nil?
                     @NameSpace.issueError(10)
                  end

                  # bounding box - east longitude (required)
                  unless hBBox[:eastLongitude].nil?
                     @xml.tag!('gex:eastBoundLongitude') do
                        @xml.tag!('gco:Decimal', hBBox[:eastLongitude])
                     end
                  end
                  if hBBox[:eastLongitude].nil?
                     @NameSpace.issueError(11)
                  end

                  # bounding box - south latitude (required)
                  unless hBBox[:southLatitude].nil?
                     @xml.tag!('gex:southBoundLatitude') do
                        @xml.tag!('gco:Decimal', hBBox[:southLatitude])
                     end
                  end
                  if hBBox[:southLatitude].nil?
                     @NameSpace.issueError(12)
                  end

                  # bounding box - north latitude (required)
                  unless hBBox[:northLatitude].nil?
                     @xml.tag!('gex:northBoundLatitude') do
                        @xml.tag!('gco:Decimal', hBBox[:northLatitude])
                     end
                  end
                  if hBBox[:northLatitude].nil?
                     @NameSpace.issueError(13)
                  end

               end # writeXML
            end # EX_GeographicBoundingBox class

         end
      end
   end
end
