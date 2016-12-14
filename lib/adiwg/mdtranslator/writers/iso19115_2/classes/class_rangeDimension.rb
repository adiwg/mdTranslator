# ISO <<Class>> MD_RangeDimension attributes
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-08-27 original script.

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_RangeDimension

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hAttribute)

                        # range dimension - sequence identifier {MemberName}
                        if !hAttribute[:sequenceIdentifier].nil? ||
                            !hAttribute[:sequenceIdentifierType].nil?
                            @xml.tag!('gmd:sequenceIdentifier') do
                                @xml.tag!('gco:MemberName') do

                                    s = hAttribute[:sequenceIdentifier]
                                    unless s.nil?
                                        @xml.tag!('gco:aName') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    end
                                    if s.nil? && @hResponseObj[:writerShowTags]
                                        @xml.tag!('gco:aName')
                                    end

                                    s = hAttribute[:sequenceIdentifierType]
                                    unless s.nil?
                                        @xml.tag!('gco:attributeType') do
                                            @xml.tag!('gco:TypeName') do
                                                @xml.tag!('gco:aName') do
                                                    @xml.tag!('gco:CharacterString', s)
                                                end
                                            end
                                        end
                                    end
                                    if s.nil? && @hResponseObj[:writerShowTags]
                                        @xml.tag!('gco:attributeType')
                                    end

                                end
                            end
                        end

                        # range dimension - descriptor
                        s = hAttribute[:attributeDescription]
                        unless s.nil?
                            @xml.tag!('gmd:descriptor') do
                                @xml.tag!('gco:CharacterString', s)
                            end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                            @xml.tag!('gmd:descriptor')
                        end

                    end # writeXML
                end # MD_RangeDescription attributes

            end
        end
    end
end
