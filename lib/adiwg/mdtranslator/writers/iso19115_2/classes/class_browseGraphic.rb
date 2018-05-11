# ISO <<Class>> MD_BrowseGraphic
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-10-17 original script

require_relative '../iso19115_2_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_BrowseGraphic

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hGraphic, inContext = nil)

                  @xml.tag!('gmd:MD_BrowseGraphic') do

                     # browse graphic - file name (required)
                     s = hGraphic[:graphicName]
                     unless s.nil?
                        @xml.tag!('gmd:fileName') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(20, 'gmd:fileName', inContext)
                     end

                     # browse graphic - file description
                     s = hGraphic[:graphicDescription]
                     unless s.nil?
                        @xml.tag!('gmd:fileDescription') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:fileDescription')
                     end

                     # browse graphic - file type
                     s = hGraphic[:graphicType]
                     unless s.nil?
                        @xml.tag!('gmd:fileType') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:fileType')
                     end

                  end # MD_BrowseGraphic tag
               end # writeXML
            end # MD_BrowseGraphic class

         end
      end
   end
end
