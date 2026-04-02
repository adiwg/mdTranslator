# unpack keyword
# Reader - DCAT-US to internal data structure

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Keyword

               def self.unpack(hDataset, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hDataset.has_key?('keyword')
                     keywords = hDataset['keyword']
                     unless keywords.nil? || keywords.empty?
                        hKeyword = intMetadataClass.newKeyword
                        keywords.each do |kw|
                           unless kw.nil? || kw == ''
                              hKeyObj = intMetadataClass.newKeywordObject
                              hKeyObj[:keyword] = kw
                              hKeyword[:keywords] << hKeyObj
                           end
                        end
                        hResourceInfo[:keywords] << hKeyword unless hKeyword[:keywords].empty?
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
