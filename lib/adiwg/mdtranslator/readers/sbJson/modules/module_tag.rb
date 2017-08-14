# unpack tag
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-23 original script

require 'uri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Tag

               def self.unpack(hSbJson, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('tags')
                     aTags = hSbJson['tags']

                     # clean up
                     aTags.each do |hTag|

                        # scheme
                        if hTag.has_key?('scheme')
                           if hTag['scheme'].nil? || hTag['scheme'] == ''
                              hTag['scheme'] = 'none'
                           end
                        else
                           hTag['scheme'] = 'none'
                        end
                        if hTag['scheme'].downcase == 'none'
                           hTag['scheme'] = 'none'
                        end
                        if hTag['scheme'] == 'ISO 19115 Topic Categories'
                           hTag['scheme'] = 'none'
                           hTag['type'] = 'isoTopicCategory'
                        end

                        # type
                        if hTag.has_key?('type')
                           if hTag['type'].nil? || hTag['type'] == ''
                              hTag['type'] = 'none'
                           end
                        else
                           hTag['type'] = 'none'
                        end
                        if hTag['type'].downcase == 'none'
                           hTag['type'] = 'none'
                        end
                        if hTag['type'] == 'ISO 19115 Topic Categories'
                           hTag['scheme'] = 'none'
                           hTag['type'] = 'isoTopicCategory'
                        end

                     end

                     # group tags by scheme
                     aSchemes = aTags.group_by { |t| t['scheme'] }
                     aSchemes.each do |aScheme|

                        # group schemes by type
                        aThemes = aScheme[1].group_by { |t| t['type'] }
                        aThemes.each do |aTheme|

                           if aTheme[0] == 'Resource Type'
                              # tags that are 'resource types'
                              aTheme[1].each do |hType|
                                 hResType = intMetadataClass.newResourceType

                                 hResType[:type] = hType['name']
                                 hResourceInfo[:resourceTypes] << hResType
                              end
                           else
                              # tags that are 'keywords'
                              hKeyword = intMetadataClass.newKeyword

                              aTheme[1].each do |hKey|
                                 hKeyObj = intMetadataClass.newKeywordObject
                                 hKeyObj[:keyword] = hKey['name']
                                 hKeyword[:keywords] << hKeyObj
                              end

                              type = aTheme[1][0]['type']
                              unless type == 'none'
                                 hKeyword[:keywordType] = type
                              end

                              scheme = aTheme[1][0]['scheme']
                              unless scheme == 'none'
                                 hThesaurus = intMetadataClass.newCitation
                                 hThesaurus[:title] = 'Keyword Thesaurus'
                                 if scheme =~ URI::regexp
                                    hOlRes = intMetadataClass.newOnlineResource
                                    hOlRes[:olResURI] = scheme
                                    hThesaurus[:onlineResources] << hOlRes
                                 else
                                    hThesaurus[:alternateTitles] << scheme
                                 end
                                 hKeyword[:thesaurus] = hThesaurus
                              end

                              hResourceInfo[:keywords] << hKeyword
                           end
                        end
                     end

                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
