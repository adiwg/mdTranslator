# ISO <<Class>> PT_Locale
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-15 original script.

require_relative '../iso19115_3_writer'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class PT_Locale

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hLocale, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag!('lan:PT_Locale') do

                     # locale - language (required)
                     unless hLocale[:languageCode].nil?
                        @xml.tag!('lan:language') do
                           codelistClass.writeXML('lan', 'iso_language', hLocale[:languageCode])
                        end
                     end
                     if hLocale[:languageCode].nil?
                        @NameSpace.issueWarning(210, 'lan:languageCode', inContext)
                     end

                     # locale - country
                     unless hLocale[:countryCode].nil?
                        @xml.tag!('lan:country') do
                           codelistClass.writeXML('lan', 'iso_countries', hLocale[:countryCode])
                        end
                     end
                     if hLocale[:countryCode].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('lan:country')
                     end

                     # locale - character encoding (required)
                     unless hLocale[:characterEncoding].nil?
                        @xml.tag!('lan:characterEncoding') do
                           codelistClass.writeXML('lan', 'iso_characterSet', hLocale[:characterEncoding])
                        end
                     end
                     if hLocale[:characterEncoding].nil?
                        @NameSpace.issueWarning(211, 'lan:characterEncoding', inContext)
                     end

                  end # PT_Locale tag
               end # writeXML
            end # PT_Locale class

         end
      end
   end
end
