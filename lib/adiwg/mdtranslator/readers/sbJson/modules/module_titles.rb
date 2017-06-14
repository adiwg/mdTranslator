# unpack titles
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-13 original script

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Title

               def self.unpack(hSbJson, hCitation, hResponseObj)

                  # title
                  if hSbJson.has_key?('title')
                     title = hSbJson['title']
                     unless title.nil? || title == ''
                        hCitation[:title] = title
                     end
                  end

                  # alternate titles []
                  if hSbJson.has_key?('alternateTitles')
                     hSbJson['alternateTitles'].each do |item|
                        unless item.nil? || item == ''
                           hCitation[:alternateTitles] << item
                        end
                     end
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
