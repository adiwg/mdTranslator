# ISO <<Class>> MD_Keyword
# writer output in XML

# History:
# 	Stan Smith 2013-09-18 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-08-21 removed keyword thesaurus link; use citation onlineResource
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method

require 'class_codelist'
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
                        codelistClass = $IsoNS::MD_Codelist.new(@xml)
                        citationClass = $IsoNS::CI_Citation.new(@xml)

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
                                    codelistClass.writeXML('iso_keywordType',s)
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
