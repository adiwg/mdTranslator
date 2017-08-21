# Reader - fgdc to internal data structure
# unpack fgdc time instant

# History:
#  Stan Smith 2017-08-21 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_dateTime'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module TimeInstant

               def self.unpack(date, time, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hTimeInstant = intMetadataClass.newTimeInstant

                  # time instant
                  hDateTime = DateTime.unpack(date, time, hResponseObj)
                  unless hDateTime.nil?
                     hTimeInstant[:timeInstant] = hDateTime
                     return hTimeInstant
                  end

                  return nil

               end

            end

         end
      end
   end
end
