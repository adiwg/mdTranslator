# ISO <<Class>> PT_Locale
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-11-21 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-07-28 original script.

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19110

                class PT_Locale

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
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
                                @xml.tag!('gmd:languageCode', {'gco:nilReason' => 'missing'})
                            end

                            # locale - country
                            s = hLocale[:countryCode]
                            unless s.nil?
                                @xml.tag!('gmd:country') do
                                    codelistClass.writeXML('gmd', 'iso_country', s)
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
                                @xml.tag!('gmd:characterEncoding', {'gco:nilReason' => 'missing'})
                            end

                        end # gmd:PT_Locale
                    end # writeXML
                end # gmd:PT_Locale class

            end
        end
    end
end
