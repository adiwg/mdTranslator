# ISO <<Class>> PT_Locale
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-03 refactored error and warning messaging
#  Stan Smith 2016-11-21 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-07-28 original script.

require_relative '../iso19110_writer'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class PT_Locale

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19110
               end

               def writeXML(hLocale)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:PT_Locale') do

                     # locale - language (required)
                     s = hLocale[:languageCode]
                     unless s.nil?
                        @xml.tag!('gmd:languageCode') do
                           codelistClass.writeXML('gmd', 'iso_language', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(80, 'gmd:languageCode')
                     end

                     # locale - country
                     s = hLocale[:countryCode]
                     unless s.nil?
                        @xml.tag!('gmd:country') do
                           codelistClass.writeXML('gmd', 'iso_countries', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:country')
                     end

                     # locale - character encoding (required)
                     s = hLocale[:characterEncoding]
                     unless s.nil?
                        @xml.tag!('gmd:characterEncoding') do
                           codelistClass.writeXML('gmd', 'iso_characterSet', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(81, 'gmd:characterEncoding')
                     end

                  end # gmd:PT_Locale
               end # writeXML
            end # gmd:PT_Locale class

         end
      end
   end
end
