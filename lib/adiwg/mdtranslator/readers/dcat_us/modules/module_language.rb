# unpack language
# Reader - DCAT-US to internal data structure
# Maps 'language' array (RFC 5646 tags) to metadataInfo.defaultMetadataLocale
# and metadataInfo.otherMetadataLocales

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Language

               def self.unpack(hDataset, hMetadataInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hMetadataInfo unless hDataset.has_key?('language')

                  languages = hDataset['language']
                  return hMetadataInfo if languages.nil? || languages.empty?

                  # First language becomes the default metadata locale
                  first_lang = languages[0]
                  unless first_lang.nil? || first_lang == ''
                     hLocale = intMetadataClass.newLocale
                     hLocale[:languageCode] = first_lang
                     hMetadataInfo[:defaultMetadataLocale] = hLocale
                  end

                  # Additional languages become other metadata locales
                  languages[1..].each do |lang|
                     next if lang.nil? || lang == ''
                     hLocale = intMetadataClass.newLocale
                     hLocale[:languageCode] = lang
                     hMetadataInfo[:otherMetadataLocales] << hLocale
                  end

                  return hMetadataInfo

               end

            end

         end
      end
   end
end
