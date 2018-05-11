# ISO <<Class>> CI_OnlineResource
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2016-11-18 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-08-14 added protocol to onlineResource
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-08-14 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class CI_OnlineResource

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hOlResource, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag! 'gmd:CI_OnlineResource' do

                     # online resource - link - required
                     s = hOlResource[:olResURI]
                     unless s.nil?
                        @xml.tag!('gmd:linkage') do
                           @xml.tag!('gmd:URL', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(250, 'gmd:linkage', inContext)
                     end

                     # online resource - protocol
                     s = hOlResource[:olResProtocol]
                     unless s.nil?
                        @xml.tag!('gmd:protocol') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:protocol')
                     end

                     # online resource - link name
                     s = hOlResource[:olResName]
                     unless s.nil?
                        @xml.tag!('gmd:name') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:name')
                     end

                     # online resource - link description
                     s = hOlResource[:olResDesc]
                     unless s.nil?
                        @xml.tag!('gmd:description') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:description')
                     end

                     # online resource - link function {CI_OnLineFunctionCode}
                     s = hOlResource[:olResFunction]
                     unless s.nil?
                        @xml.tag!('gmd:function') do
                           codelistClass.writeXML('gmd', 'iso_onlineFunction', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:function')
                     end

                  end # CI_OnlineResource tag
               end # write XML
            end # CI_OnlineResource class

         end
      end
   end
end
