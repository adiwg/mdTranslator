# Reader - fgdc to internal data structure
# unpack fgdc keyword

# History:
#  Stan Smith 2017-12-19 add lineage method keywords
#  Stan Smith 2017-08-24 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Keyword

               def self.unpack(xKeywords, hResourceInfo, hResponseObj)

                  aKeywords = hResourceInfo[:keywords]

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # keywords 1.6.1 (theme) - thematic keywords {keyword}
                  axTheme = xKeywords.xpath('./theme')
                  unless axTheme.empty?
                     axTheme.each do |xTheme|
                        hKeyword = intMetadataClass.newKeyword
                        hKeyword[:keywordType] = 'theme'

                        # theme keyword 1.6.1.1 (themekt) - theme keyword thesaurus {citation}
                        thesaurus = xTheme.xpath('./themekt').text
                        unless thesaurus.empty?
                           hCitation = intMetadataClass.newCitation
                           hCitation[:title] = thesaurus
                           hKeyword[:thesaurus] = hCitation
                           if thesaurus == 'ISO 19115 Topic Category'
                              hKeyword[:keywordType] = 'isoTopicCategory'
                           end
                        end

                        # theme keyword 1.6.1.2 (themekey) - theme keyword keyword {keywordObject}
                        axKeywords = xTheme.xpath('./themekey')
                        unless axKeywords.empty?
                           axKeywords.each do |xKeyword|
                              keyword = xKeyword.text
                              unless keyword.empty?
                                 hKeywordObj = intMetadataClass.newKeywordObject
                                 hKeywordObj[:keyword] = keyword
                                 hKeyword[:keywords] << hKeywordObj
                              end
                           end
                        end

                        aKeywords << hKeyword

                     end
                  end

                  # keywords 1.6.2 (place) - place keywords {keyword}
                  axPlace = xKeywords.xpath('./place')
                  unless axPlace.empty?
                     axPlace.each do |xPlace|
                        hKeyword = intMetadataClass.newKeyword
                        hKeyword[:keywordType] = 'place'

                        # theme keyword 1.6.2.1 (placekt) - place keyword thesaurus {citation}
                        thesaurus = xPlace.xpath('./placekt').text
                        unless thesaurus.empty?
                           hCitation = intMetadataClass.newCitation
                           hCitation[:title] = thesaurus
                           hKeyword[:thesaurus] = hCitation
                        end

                        # theme keyword 1.6.2.2 (placekey) - place keyword keyword {keywordObject}
                        axKeywords = xPlace.xpath('./placekey')
                        unless axKeywords.empty?
                           axKeywords.each do |xKeyword|
                              keyword = xKeyword.text
                              unless keyword.empty?
                                 hKeywordObj = intMetadataClass.newKeywordObject
                                 hKeywordObj[:keyword] = keyword
                                 hKeyword[:keywords] << hKeywordObj
                              end
                           end
                        end

                        aKeywords << hKeyword

                     end
                  end

                  # keywords 1.6.3 (stratum) - stratum keywords {keyword}
                  axStratum = xKeywords.xpath('./stratum')
                  unless axStratum.empty?
                     axStratum.each do |xStratum|
                        hKeyword = intMetadataClass.newKeyword
                        hKeyword[:keywordType] = 'stratum'

                        # theme keyword 1.6.3.1 (stratkt) - stratum keyword thesaurus {citation}
                        thesaurus = xStratum.xpath('./stratkt').text
                        unless thesaurus.empty?
                           hCitation = intMetadataClass.newCitation
                           hCitation[:title] = thesaurus
                           hKeyword[:thesaurus] = hCitation
                        end

                        # theme keyword 1.6.3.2 (stratkey) - stratum keyword keyword {keywordObject}
                        axKeywords = xStratum.xpath('./stratkey')
                        unless axKeywords.empty?
                           axKeywords.each do |xKeyword|
                              keyword = xKeyword.text
                              unless keyword.empty?
                                 hKeywordObj = intMetadataClass.newKeywordObject
                                 hKeywordObj[:keyword] = keyword
                                 hKeyword[:keywords] << hKeywordObj
                              end
                           end
                        end

                        aKeywords << hKeyword

                     end
                  end

                  # keywords 1.6.4 (temporal) - temporal keywords {keyword}
                  axTemporal = xKeywords.xpath('./temporal')
                  unless axTemporal.empty?
                     axTemporal.each do |xTemporal|
                        hKeyword = intMetadataClass.newKeyword
                        hKeyword[:keywordType] = 'temporal'

                        # theme keyword 1.6.4.1 (tempkt) - temporal keyword thesaurus {citation}
                        thesaurus = xTemporal.xpath('./tempkt').text
                        unless thesaurus.empty?
                           hCitation = intMetadataClass.newCitation
                           hCitation[:title] = thesaurus
                           hKeyword[:thesaurus] = hCitation
                        end

                        # theme keyword 1.6.4.2 (tempkey) - temporal keyword keyword {keywordObject}
                        axKeywords = xTemporal.xpath('./tempkey')
                        unless axKeywords.empty?
                           axKeywords.each do |xKeyword|
                              keyword = xKeyword.text
                              unless keyword.empty?
                                 hKeywordObj = intMetadataClass.newKeywordObject
                                 hKeywordObj[:keyword] = keyword
                                 hKeyword[:keywords] << hKeywordObj
                              end
                           end
                        end

                        aKeywords << hKeyword

                     end
                  end

                  # keywords bio (keywtax) - taxonomy keywords {keyword}
                  nodeName = xKeywords.xpath('.').first.name
                  if nodeName == 'keywtax'
                     hKeyword = intMetadataClass.newKeyword
                     hKeyword[:keywordType] = 'taxon'

                     # theme bio.1.1 (taxonkt) - taxonomy keyword thesaurus {citation}
                     thesaurus = xKeywords.xpath('./taxonkt').text
                     unless thesaurus.empty?
                        hCitation = intMetadataClass.newCitation
                        hCitation[:title] = thesaurus
                        hKeyword[:thesaurus] = hCitation
                     end

                     # theme keyword bio.1.2 (taxonkey) - taxonomy keyword keywords {keywordObject}
                     axKeywords = xKeywords.xpath('./taxonkey')
                     unless axKeywords.empty?
                        axKeywords.each do |xKeyword|
                           keyword = xKeyword.text
                           unless keyword.empty?
                              hKeywordObj = intMetadataClass.newKeywordObject
                              hKeywordObj[:keyword] = keyword
                              hKeyword[:keywords] << hKeywordObj
                           end
                        end
                     end

                     aKeywords << hKeyword

                  end

                  # keywords bio (methodid) - lineage method keywords {keyword}
                  nodeName = xKeywords.xpath('.').first.name
                  if nodeName == 'methodid'
                     hKeyword = intMetadataClass.newKeyword
                     hKeyword[:keywordType] = 'method'

                     # theme bio.1.1 (methkt) - lineage method keyword thesaurus {citation}
                     thesaurus = xKeywords.xpath('./methkt').text
                     unless thesaurus.empty?
                        hCitation = intMetadataClass.newCitation
                        hCitation[:title] = thesaurus
                        hKeyword[:thesaurus] = hCitation
                     end

                     # theme keyword bio.1.2 (methkey) - lineage method keywords {keywordObject}
                     axKeywords = xKeywords.xpath('./methkey')
                     unless axKeywords.empty?
                        axKeywords.each do |xKeyword|
                           keyword = xKeyword.text
                           unless keyword.empty?
                              hKeywordObj = intMetadataClass.newKeywordObject
                              hKeywordObj[:keyword] = keyword
                              hKeyword[:keywords] << hKeywordObj
                           end
                        end
                     end

                     aKeywords << hKeyword

                  end

                  return aKeywords

               end
            end

         end
      end
   end
end
