# ISO <<Class>> EX_GeographicBoundingBox
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-12-02 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-05-30 hBBox attributes changed for version 0.5.0
# 	Stan Smith 2013-11-01 original script

require_relative '../iso19115_2_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
