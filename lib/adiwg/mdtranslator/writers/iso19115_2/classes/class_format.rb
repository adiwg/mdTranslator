# ISO <<Class>> MD_Format
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-07 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-09-15 added compression method element
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-08-26 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Format

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hFormat)

                        @xml.tag!('gmd:MD_Format') do

                            # get required 19115-2 elements from citation
                            citation = hFormat[:formatSpecification]
                            if citation.empty?
                                name = nil
                                version = nil
                            else
                                name = citation[:title]
                                version = citation[:edition]
                            end

                            # format - name (required)
                            unless name.nil?
                                @xml.tag!('gmd:name') do
                                    @xml.tag!('gco:CharacterString', name)
                                end
                            end
                            if name.nil?
                                @xml.tag!('gmd:name', {'gco:nilReason' => 'missing'})
                            end

                            # format - version (required)
                            unless version.nil?
                                @xml.tag!('gmd:version') do
                                    @xml.tag!('gco:CharacterString', version)
                                end
                            end
                            if version.nil?
                                @xml.tag!('gmd:version', {'gco:nilReason' => 'missing'})
                            end

                            # format - amendment number
                            s = hFormat[:amendmentNumber]
                            unless s.nil?
                                @xml.tag!('gmd:amendmentNumber') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:amendmentNumber')
                            end

                            # format - compression method
                            s = hFormat[:compressionMethod]
                            unless s.nil?
                                @xml.tag!('gmd:fileDecompressionTechnique') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:fileDecompressionTechnique')
                            end

                        end # MD_Format tag
                    end # writeXML
                end # MD_Format class

            end
        end
    end
end
