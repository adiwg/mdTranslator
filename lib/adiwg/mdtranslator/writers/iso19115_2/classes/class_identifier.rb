# ISO <<Class>> MD_Identifier
# writer
# output for ISO 19115-2 XML

# History:
# 	Stan Smith 2014-05-16 original script
#   Stan Smith 2014-05-28 revised for json schema 0.5.0
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'class_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_Identifier

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hResID)

                        # the authority for the identifier is a citation block

                        # classes used in MD_Metadata
                        citationClass = $IsoNS::CI_Citation.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_Identifier') do

                            # identifier - authority
                            hCitation = hResID[:identifierCitation]
                            if !hCitation.empty?
                                @xml.tag!('gmd:authority') do
                                    citationClass.writeXML(hCitation)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:authority')
                            end

                            # identity - code - required
                            s = hResID[:identifier]
                            if !s.nil?
                                @xml.tag!('gmd:code') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:code')
                            end

                        end

                    end

                end

            end
        end
    end
end
