# FGDC <<Class>> Keyword
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Keyword

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aKeywords)

                  # array of keyword sets
                  aKeywords.each do |hKeySet|

                     # find the keyword set parts
                     type = hKeySet[:keywordType]
                     aKeywords = hKeySet[:keywords]
                     thesaurus = hKeySet[:thesaurus]
                     thesaurusName = nil
                     unless thesaurus.empty?
                        thesaurusName = thesaurus[:title]
                     end
                     if thesaurus.empty?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Keyword Set is missing thesaurus'
                     end

                     # keyword 1.6.1 (theme) - theme keywords
                     if type == 'theme' || type == 'isoTopicCategory'
                        @xml.tag!('theme') do
                           @xml.tag!('themekt', thesaurusName)
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
                           @xml.tag!('placekt', thesaurusName)
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
                           @xml.tag!('stratkt', thesaurusName)
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
                           @xml.tag!('tempkt', thesaurusName)
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
