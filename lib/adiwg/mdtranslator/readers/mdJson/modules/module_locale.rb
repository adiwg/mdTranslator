# unpack locale
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
# 	Stan Smith 2016-10-05 refactored for mdJson 2.0
# 	Stan Smith 2015-07-28 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Locale

               def self.unpack(hLocale, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hLocale.empty?
                     @MessagePath.issueWarning(510, responseObj, inContext)
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
                     @MessagePath.issueError(511, responseObj, inContext)
                  end

                  # locale - country
                  if hLocale.has_key?('country')
                     unless hLocale['country'] == ''
                        intLocale[:countryCode] = hLocale['country']
                     end
                  end

                  # locale - character set (required)
                  # return nil if no character set code is provided
                  if hLocale.has_key?('characterSet')
                     intLocale[:characterEncoding] = hLocale['characterSet']
                  end
                  if intLocale[:characterEncoding].nil? || intLocale[:characterEncoding] == ''
                     @MessagePath.issueError(512, responseObj, inContext)
                  end

                  return intLocale

               end

            end

         end
      end
   end
end
