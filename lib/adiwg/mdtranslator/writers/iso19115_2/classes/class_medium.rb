# ISO <<Class>> MD_Medium
# writer output in XML

# History:
# 	Stan Smith 2013-09-26 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-09-15 added density, densityUnits elements

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Medium

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(medium)

                        # classes used
                        codelistClass =  MD_Codelist.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_Medium') do

                            # medium - name - MD_MediumNameCode
                            s = medium[:mediumName]
                            if !s.nil?
                                @xml.tag!('gmd:name') do
                                    codelistClass.writeXML('iso_mediumName',s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:name')
                            end

                            # medium - density in MB / density units
                            s = medium[:mediumCapacity]
                            if !s.nil?
                                @xml.tag!('gmd:density') do
                                    @xml.tag!('gco:Real', s.to_s)
                                end
                                su = medium[:mediumCapacityUnits].upcase
                                if !su.nil?
                                    @xml.tag!('gmd:densityUnits') do
                                        @xml.tag!('gco:CharacterString', su)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:density')
                            end

                            # medium - medium format - MD_MediumFormatCode
                            s = medium[:mediumFormat]
                            if !s.nil?
                                @xml.tag!('gmd:mediumFormat') do
                                    codelistClass.writeXML('iso_mediumFormat', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:mediumFormat')
                            end

                            # medium - medium note
                            s = medium[:mediumNote]
                            if !s.nil?
                                @xml.tag!('gmd:mediumNote') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:mediumNote')
                            end

                        end

                    end

                end

            end
        end
    end
end
