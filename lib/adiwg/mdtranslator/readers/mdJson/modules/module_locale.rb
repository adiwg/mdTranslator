# unpack locale
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-05 refactored for mdJson 2.0
# 	Stan Smith 2015-07-28 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Locale

                    def self.unpack(hLocale, responseObj)

                        # return nil object if input is empty
                        if hLocale.empty?
                            responseObj[:readerExecutionMessages] << 'Locale object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intLocale = intMetadataClass.newLocale

                        # locale - language (required)
                        # return nil if no language code is provided
                        if hLocale.has_key?('language')
                            intLocale[:languageCode] = hLocale['language']
                        end
                        if intLocale[:languageCode].nil? || intLocale[:languageCode] == ''
                            responseObj[:readerExecutionMessages] << 'Locale object did not provide a language code'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # locale - country
                        if hLocale.has_key?('country')
                            if hLocale['country'] != ''
                                intLocale[:countryCode] = hLocale['country']
                            end
                        end

                        # locale - character set (required)
                        # return nil if no character set code is provided
                        if hLocale.has_key?('characterSet')
                            intLocale[:characterEncoding] = hLocale['characterSet']
                        end
                        if intLocale[:characterEncoding].nil? || intLocale[:characterEncoding] == ''
                            responseObj[:readerExecutionMessages] << 'Locale object did not provide a character set code'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intLocale

                    end

                end

            end
        end
    end
end
