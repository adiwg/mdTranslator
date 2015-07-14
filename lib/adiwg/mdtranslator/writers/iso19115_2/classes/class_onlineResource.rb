# ISO <<Class>> CI_OnlineResource
# writer output in XML

# History:
# 	Stan Smith 2013-08-14 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-08-14 added protocol to onlineResource
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class CI_OnlineResource

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hOlResource)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)

                        @xml.tag! 'gmd:CI_OnlineResource' do

                            # online resource - link - required
                            s = hOlResource[:olResURI]
                            if s.nil?
                                @xml.tag!('gmd:linkage', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:linkage') do
                                    @xml.tag!('gmd:URL', s)
                                end
                            end

                            # online resource - protocol
                            s = hOlResource[:olResProtocol]
                            if !s.nil?
                                @xml.tag!('gmd:protocol') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:protocol')
                            end

                            # online resource - link name
                            s = hOlResource[:olResName]
                            if !s.nil?
                                @xml.tag!('gmd:name') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:name')
                            end

                            # online resource - link description
                            s = hOlResource[:olResDesc]
                            if !s.nil?
                                @xml.tag!('gmd:description') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:description')
                            end

                            # online resource - link function - CI_OnLineFunctionCode
                            s = hOlResource[:olResFunction]
                            if !s.nil?
                                @xml.tag!('gmd:function') do
                                    codelistClass.writeXML('iso_onlineFunction',s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:function')
                            end

                        end

                    end

                end

            end
        end
    end
end
