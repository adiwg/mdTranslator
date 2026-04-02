# unpack title
# Reader - DCAT-US to internal data structure

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Title

               def self.unpack(hDataset, hCitation, hResponseObj)

                  if hDataset.has_key?('title')
                     title = hDataset['title']
                     unless title.nil? || title == ''
                        hCitation[:title] = title
                     end
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
