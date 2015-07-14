# ISO <<Class>> MD_Format
# writer output in XML

# History:
# 	Stan Smith 2013-08-26 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_Format

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(rFormat)

                        @xml.tag!('gmd:MD_Format') do

                            # format - name - required
                            s = rFormat[:formatName]
                            if s.nil?
                                @xml.tag!('gmd:name', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:name') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end

                            # format - version - required
                            s = rFormat[:formatVersion]
                            if s.nil?
                                @xml.tag!('gmd:version', {'gco:nilReason' => 'unknown'})
                            else
                                @xml.tag!('gmd:version') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                        end

                    end

                end

            end
        end
    end
end
