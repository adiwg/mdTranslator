# unpack dates
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-25 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_codelists'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Date

               def self.unpack(hSbJson, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('dates')
                     hSbJson['dates'].each do |hSbDate|
                        hDate = intMetadataClass.newDate
                        aReturn = AdiwgDateTimeFun.dateTimeFromString(hSbDate['dateString'])
                        unless aReturn.nil?
                           hDate[:date] = aReturn[0]
                           hDate[:dateResolution] = aReturn[1]
                           hDate[:description] = hSbDate['label']
                           sbType = hSbDate['type']
                           adiwgType = Codelists.codelist_sb2adiwg('date_sb2adiwg', sbType)
                           type = adiwgType.nil? ? sbType : adiwgType
                           hDate[:dateType] = type
                           hCitation[:dates] << hDate
                        end
                     end
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
