# HTML writer
# locale

# History:
#  Stan Smith 2017-03-24 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Locale

               def initialize(html)
                  @html = html
               end

               def writeHtml(hLocale)

                  # locale - language code
                  unless hLocale[:languageCode].nil?
                     @html.em('Language Code: ')
                     @html.text!(hLocale[:languageCode])
                     @html.br
                  end

                  # locale - country code
                  unless hLocale[:countryCode].nil?
                     @html.em('Country Code: ')
                     @html.text!(hLocale[:countryCode])
                     @html.br
                  end

                  # locale - characterEncoding
                  unless hLocale[:characterEncoding].nil?
                     @html.em('Character Encoding: ')
                     @html.text!(hLocale[:characterEncoding])
                     @html.br
                  end

               end # writeHtml
            end # Html_Locale

         end
      end
   end
end
