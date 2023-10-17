# ISO <<Class>> MD_Keyword
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-25 original script

require_relative '../iso19115_3_writer'
require_relative 'class_codelist'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_Keywords

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hKeyword)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  @xml.tag!('mri:MD_Keywords') do

                     # keyword - keyword (required)
                     aKeyObjects = hKeyword[:keywords]
                     unless aKeyObjects.empty?
                        aKeyObjects.each do |hKeyObj|
                           keyword = hKeyObj[:keyword]
                           unless keyword.nil?
                              @xml.tag!('mri:keyword') do
                                 @xml.tag!('gco:CharacterString', keyword)
                              end
                           end
                        end
                     end
                     if aKeyObjects.empty?
                        @NameSpace.issueWarning(200, 'mri:keyword')
                     end

                     # keyword - type {MD_KeywordTypeCode}
                     unless hKeyword[:keywordType].nil?
                        @xml.tag!('mri:type') do
                           codelistClass.writeXML('mri', 'iso_keywordType', hKeyword[:keywordType])
                        end
                     end
                     if hKeyword[:keywordType].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:type')
                     end

                     # keyword - thesaurus {MD_KeywordTypeCode}
                     hCitation = hKeyword[:thesaurus]
                     unless hCitation.empty?
                        @xml.tag!('mri:thesaurusName') do
                           citationClass.writeXML(hCitation, 'keyword thesaurus')
                        end
                     end
                     if hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:thesaurusName')
                     end

                     # keyword - keyword class {MD_KeywordClass} - not implemented in mdJson 2.0

                  end # mri:MD_Keywords tag
               end # writeXML
            end # MD_Keywords class

         end
      end
   end
end
