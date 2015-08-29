# ISO <<Class>> RS_Identifier
# writer
# output for ISO 19115-2 XML

# History:
# 	Stan Smith 2014-09-03 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-08-28 added codeSpace and version

require_relative 'class_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class RS_Identifier

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hResId)

                        # classes used in MD_Metadata
                        citationClass = CI_Citation.new(@xml, @responseObj)

                        @xml.tag!('gmd:RS_Identifier') do

                            # identifier - authority - CI_Citation
                            hCitation = hResId[:identifierCitation]
                            if !hCitation.empty?
                                @xml.tag!('gmd:authority') do
                                    citationClass.writeXML(hCitation)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:authority')
                            end

                            # identity - code - required
                            # special handling for identifiers types epsg number, wkt, doi
                            case hResId[:identifierType]
                                when 'epsg'
                                    code = 'urn:ocg:def:crs:EPSG::' + hResId[:identifier].to_s

                                when 'wkt'
                                    code = 'WKT::' + hResId[:identifier]

                                when 'doi'
                                    code = 'doi::' + hResId[:identifier]

                                else
                                    code = hResId[:identifier]

                            end

                            @xml.tag!('gmd:code') do
                                @xml.tag!('gco:CharacterString', code)
                            end

                            # identity - code space
                            s = hResId[:identifierNamespace]
                            if !s.nil?
                                @xml.tag!('gmd:codeSpace') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:codeSpace')
                            end

                            # identify - version
                            s = hResId[:identifierVersion]
                            if !s.nil?
                                @xml.tag!('gmd:version') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:version')
                            end

                        end

                    end

                end

            end
        end
    end
end
