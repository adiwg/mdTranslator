# unpack theme
# Reader - DCAT-US to internal data structure
# Maps 'theme' array to resourceInfo.keywords with thesaurus title "ISO Topic Categories"

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Theme

               def self.unpack(hDataset, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hResourceInfo unless hDataset.has_key?('theme')

                  themes = hDataset['theme']
                  return hResourceInfo if themes.nil? || themes.empty?

                  hKeyword = intMetadataClass.newKeyword

                  themes.each do |theme|
                     next if theme.nil? || theme == ''
                     hKeyObj = intMetadataClass.newKeywordObject
                     hKeyObj[:keyword] = theme
                     hKeyword[:keywords] << hKeyObj
                  end

                  unless hKeyword[:keywords].empty?
                     hThesaurus = intMetadataClass.newCitation
                     hThesaurus[:title] = 'ISO Topic Categories'
                     hKeyword[:thesaurus] = hThesaurus
                     hResourceInfo[:keywords] << hKeyword
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
