# ISO <<Class>> MD_Keyword
# writer output in XML

# History:
# 	Stan Smith 2013-09-18 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-08-21 removed keyword thesaurus link; use citation onlineResource
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'code_keywordType'
require 'class_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_Keywords

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hDKeyword)

                        # classes used
                        citationClass = $WriterNS::CI_Citation.new(@xml)
                        keywordCode = $WriterNS::MD_KeywordTypeCode.new(@xml)

                        @xml.tag!('gmd:MD_Keywords') do

                            # keywords - keyword - required
                            aKeywords = hDKeyword[:keyword]
                            if aKeywords.empty?
                                @xml.tag!('gmd:keyword', {'gco:nilReason' => 'missing'})
                            else
                                aKeywords.each do |keyword|
                                    @xml.tag!('gmd:keyword') do
                                        @xml.tag!('gco:CharacterString', keyword)
                                    end
                                end
                            end

                            # keywords - type - MD_KeywordTypeCode
                            s = hDKeyword[:keywordType]
                            if !s.nil?
                                @xml.tag!('gmd:type') do
                                    keywordCode.writeXML(s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:type')
                            end

                            hKeyCitation = hDKeyword[:keyTheCitation]
                            if !hKeyCitation.empty?
                                @xml.tag!('gmd:thesaurusName') do
                                    citationClass.writeXML(hKeyCitation)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:thesaurusName')
                            end

                        end

                    end

                end

            end
        end
    end
end
