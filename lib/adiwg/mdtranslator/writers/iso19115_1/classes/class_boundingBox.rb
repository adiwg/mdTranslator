# ISO <<Class>> EX_GeographicBoundingBox
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-19 original script

require_relative '../iso19115_1_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class EX_GeographicBoundingBox

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hBBox)

                  # bounding box - west longitude (required)
                  s = hBBox[:westLongitude]
                  unless s.nil?
                     @xml.tag!('gmd:westBoundLongitude') do
                        @xml.tag!('gco:Decimal', s)
                     end
                  end
                  if s.nil?
                     @NameSpace.issueError(10)
                  end

                  # bounding box - east longitude (required)
                  s = hBBox[:eastLongitude]
                  unless s.nil?
                     @xml.tag!('gmd:eastBoundLongitude') do
                        @xml.tag!('gco:Decimal', s)
                     end
                  end
                  if s.nil?
                     @NameSpace.issueError(11)
                  end

                  # bounding box - south latitude (required)
                  s = hBBox[:southLatitude]
                  unless s.nil?
                     @xml.tag!('gmd:southBoundLatitude') do
                        @xml.tag!('gco:Decimal', s)
                     end
                  end
                  if s.nil?
                     @NameSpace.issueError(12)
                  end

                  # bounding box - north latitude (required)
                  s = hBBox[:northLatitude]
                  unless s.nil?
                     @xml.tag!('gmd:northBoundLatitude') do
                        @xml.tag!('gco:Decimal', s)
                     end
                  end
                  if s.nil?
                     @NameSpace.issueError(13)
                  end

               end # writeXML
            end # EX_GeographicBoundingBox class

         end
      end
   end
end
