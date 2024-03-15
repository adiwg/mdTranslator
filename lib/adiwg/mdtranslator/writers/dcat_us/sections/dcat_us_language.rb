module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Language
 
               def self.build(intObj)
                  metadataInfo = intObj.dig(:metadata, :metadataInfo)
                  defaultLanguage = metadataInfo&.dig(:defaultMetadataLocale, :languageCode)
                  additionalLanguage = metadataInfo&.dig(:otherMetadataLocales)
                  languages = []
                  languages << defaultLanguage if defaultLanguage
                  additionalLanguage.each { |lang| languages << lang[:languageCode] } if additionalLanguage

                  return languages
                end                
                
            end
         end
      end
   end
end
 