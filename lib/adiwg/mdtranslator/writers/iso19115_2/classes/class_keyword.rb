# ISO <<Class>> MD_Keyword
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-12-12 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-08-21 removed keyword thesaurus link; use citation onlineResource
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-09-18 original script

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Keywords

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hKeyword)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_Keywords') do

                     # keyword - keyword (required)
                     aKeyObjects = hKeyword[:keywords]
                     unless aKeyObjects.empty?
                        aKeyObjects.each do |hKeyObj|
                           keyword = hKeyObj[:keyword]
                           unless keyword.nil?
                              @xml.tag!('gmd:keyword') do
                                 @xml.tag!('gco:CharacterString', keyword)
                              end
                           end
                        end
                     end
                     if aKeyObjects.empty?
                        @NameSpace.issueWarning(200, 'gmd:keyword')
                     end

                     # keyword - type {MD_KeywordTypeCode}
                     s = hKeyword[:keywordType]
                     unless s.nil?
                        @xml.tag!('gmd:type') do
                           codelistClass.writeXML('gmd', 'iso_keywordType', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:type')
                     end

                     # keyword - thesaurus {MD_KeywordTypeCode}
                     hCitation = hKeyword[:thesaurus]
                     unless hCitation.empty?
                        @xml.tag!('gmd:thesaurusName') do
                           citationClass.writeXML(hCitation, 'keyword thesaurus')
                        end
                     end
                     if hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:thesaurusName')
                     end

                  end # gmd:MD_Keywords tag
               end # writeXML
            end # MD_Keywords class

         end
      end
   end
end
