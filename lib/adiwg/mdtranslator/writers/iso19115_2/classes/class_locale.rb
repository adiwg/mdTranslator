# ISO <<Class>> PT_Locale
# writer output in XML

# History:
# 	Stan Smith 2015-07-28 original script.

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class PT_Locale

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hLocale)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)

                        @xml.tag!('gmd:PT_Locale') do

                            # locale - language
                            s = hLocale[:languageCode]
                            if !s.nil?
                                @xml.tag!('gmd:languageCode') do
                                    codelistClass.writeXML('iso_language',s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:languageCode')
                            end

                            # locale - country
                            s = hLocale[:countryCode]
                            if !s.nil?
                                @xml.tag!('gmd:country') do
                                    codelistClass.writeXML('iso_country',s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:country')
                            end

                            # locale - character encoding
                            s = hLocale[:characterEncoding]
                            if !s.nil?
                                @xml.tag!('gmd:characterEncoding') do
                                    codelistClass.writeXML('iso_characterSet',s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:characterEncoding')
                            end

                        end

                    end

                end

            end
        end
    end
end
