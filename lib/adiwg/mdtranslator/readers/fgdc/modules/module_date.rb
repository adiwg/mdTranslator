# Reader - fgdc to internal data structure
# unpack fgdc metadata date

# History:
#  Stan Smith 2017-08-15 original script

require 'date'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require_relative 'module_fgdc'
require_relative 'module_dateTime'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Date

               def self.unpack(date, time, type, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hDate = intMetadataClass.newDate

                  if date.nil? || date == ''
                     hResponseObj[:readerExecutionMessages] << 'date string is missing from date conversion'
                     hResponseObj[:readerExecutionPass] = false
                     return nil
                  end

                  if type.nil? || type == ''
                     hResponseObj[:readerExecutionMessages] << 'date type is missing from date conversion'
                     hResponseObj[:readerExecutionPass] = false
                     return nil
                  end

                  hDateTime = DateTime.unpack(date, time, hResponseObj)

                  # build internal date object
                  unless hDateTime.nil?
                     hDate[:date] = hDateTime[:dateTime]
                     hDate[:dateResolution] = hDateTime[:dateResolution]
                     hDate[:dateType] = type
                     return hDate
                  end

                  return nil

               end

            end

         end
      end
   end
end
