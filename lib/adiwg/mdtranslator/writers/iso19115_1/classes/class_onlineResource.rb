# ISO <<Class>> CI_OnlineResource
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-14 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class CI_OnlineResource

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hOlResource, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag! 'cit:CI_OnlineResource' do

                     # online resource - link - required
                     unless hOlResource[:olResURI].nil?
                        @xml.tag!('cit:linkage') do
                           @xml.tag!('gco:CharacterString', hOlResource[:olResURI])
                        end
                     end
                     if hOlResource[:olResURI].nil?
                        @NameSpace.issueWarning(250, 'cit:linkage', inContext)
                     end

                     # online resource - protocol
                     unless hOlResource[:olResProtocol].nil?
                        @xml.tag!('cit:protocol') do
                           @xml.tag!('gco:CharacterString', hOlResource[:olResProtocol])
                        end
                     end
                     if hOlResource[:olResProtocol].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:protocol')
                     end

                     # online resource - application profile - not implemented

                     # online resource - link name
                     unless hOlResource[:olResName].nil?
                        @xml.tag!('cit:name') do
                           @xml.tag!('gco:CharacterString', hOlResource[:olResName])
                        end
                     end
                     if hOlResource[:olResName].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:name')
                     end

                     # online resource - link description
                     unless hOlResource[:olResDesc].nil?
                        @xml.tag!('cit:description') do
                           @xml.tag!('gco:CharacterString', hOlResource[:olResDesc])
                        end
                     end
                     if hOlResource[:olResDesc].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:description')
                     end

                     # online resource - link function {CI_OnLineFunctionCode}
                     unless hOlResource[:olResFunction].nil?
                        @xml.tag!('cit:function') do
                           codelistClass.writeXML('cit', 'iso_onlineFunction', hOlResource[:olResFunction])
                        end
                     end
                     if hOlResource[:olResFunction].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:function')
                     end

                     # online resource - protocol request - not implemented

                  end # CI_OnlineResource tag
               end # write XML
            end # CI_OnlineResource class

         end
      end
   end
end
