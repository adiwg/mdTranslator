# unpack locale
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-07-28 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Locale

                    def self.unpack(hLocale, responseObj)

                        # return nil object if input is empty
                        intLocale = nil
                        return if hLocale.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intLocale = intMetadataClass.newLocale

                        # locale - language
                        if hLocale.has_key?('language')
                            s = hLocale['language']
                            if s != ''
                                intLocale[:languageCode] = s
                            end
                        end

                        # locale - country
                        if hLocale.has_key?('country')
                            s = hLocale['country']
                            if s != ''
                                intLocale[:countryCode] = s
                            end
                        end

                        # locale - character set
                        if hLocale.has_key?('characterSet')
                            s = hLocale['characterSet']
                            if s != ''
                                intLocale[:characterEncoding] = s
                            end
                        end

                        return intLocale

                    end

                end

            end
        end
    end
end
