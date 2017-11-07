# Reader - fgdc to internal data structure
# unpack fgdc time instant

# History:
#  Stan Smith 2017-11-07 add geologic age
#  Stan Smith 2017-08-21 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_dateTime'
require_relative 'module_geologicAge'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module TimeInstant

               def self.unpack(xDateTime, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hTimeInstant = intMetadataClass.newTimeInstant

                  date = xDateTime.xpath('./caldate').text
                  time = xDateTime.xpath('./time').text
                  xGeoAge = xDateTime.xpath('./geolage')

                  # time instant - date-time
                  unless date.empty?
                     hDateTime = DateTime.unpack(date, time, hResponseObj)
                     unless hDateTime.nil?
                        hTimeInstant[:timeInstant] = hDateTime
                        return hTimeInstant
                     end
                  end

                  # time instant - geological age
                  unless xGeoAge.empty?
                     hGeoAge = GeologicAge.unpack(xGeoAge, hResponseObj)
                     unless hGeoAge.nil?
                        hTimeInstant[:geologicAge] = hGeoAge
                        return hTimeInstant
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
