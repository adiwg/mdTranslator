# FGDC <<Class>> Keyword
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-19 refactored error and warning messaging
#  Stan Smith 2017-11-26 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Keyword

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(aKeywords)

                  # array of keyword sets
                  aKeywords.each do |hKeySet|

                     # find the keyword set parts
                     type = hKeySet[:keywordType]
                     aKeywords = hKeySet[:keywords]
                     hThesaurus = hKeySet[:thesaurus]
                     thesaurusName = nil
                     unless hThesaurus.empty?
                        thesaurusName = hThesaurus[:title]
                     end

                     # keyword 1.6.1 (theme) - theme keywords
                     if type == 'theme' || type == 'isoTopicCategory'
                        @xml.tag!('theme') do
                           thesaurusName = 'ISO 19115 Topic Category' if type == 'isoTopicCategory'
                           unless thesaurusName.nil?
                              @xml.tag!('themekt', thesaurusName)
                           end
                           if thesaurusName.nil?
                              @NameSpace.issueWarning(190, 'themekt', 'thematic keywords')
                           end
                           aKeywords.each do |hKeyword|
                              keyword = hKeyword[:keyword]
                              unless keyword.nil?
                                 @xml.tag!('themekey', keyword)
                              end
                           end
                        end
                     end

                     # keyword 1.6.2 (place) - place keywords
                     if type == 'place'
                        @xml.tag!('place') do
                           unless thesaurusName.nil?
                              @xml.tag!('placekt', thesaurusName)
                           end
                           if thesaurusName.nil?
                              @NameSpace.issueWarning(190, 'placekt', 'place keywords')
                           end
                           aKeywords.each do |hKeyword|
                              keyword = hKeyword[:keyword]
                              unless keyword.nil?
                                 @xml.tag!('placekey', keyword)
                              end
                           end
                        end
                     end

                     # keyword 1.6.3 (stratum) - stratum keywords
                     if type == 'stratum'
                        @xml.tag!('stratum') do
                           unless thesaurusName.nil?
                              @xml.tag!('stratkt', thesaurusName)
                           end
                           if thesaurusName.nil?
                              @NameSpace.issueWarning(190, 'stratkt', 'stratigraphic keywords')
                           end
                           aKeywords.each do |hKeyword|
                              keyword = hKeyword[:keyword]
                              unless keyword.nil?
                                 @xml.tag!('stratkey', keyword)
                              end
                           end
                        end
                     end

                     # keyword 1.6.4 (temporal) - temporal keywords
                     if type == 'temporal'
                        @xml.tag!('temporal') do
                           unless thesaurusName.nil?
                              @xml.tag!('tempkt', thesaurusName)
                           end
                           if thesaurusName.nil?
                              @NameSpace.issueWarning(190, 'tempkt', 'temporal keywords')
                           end
                           aKeywords.each do |hKeyword|
                              keyword = hKeyword[:keyword]
                              unless keyword.nil?
                                 @xml.tag!('tempkey', keyword)
                              end
                           end
                        end
                     end

                     # other keywordType(s) not transferred to FGDC

                  end

               end # writeXML
            end # Status

         end
      end
   end
end
