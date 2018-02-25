# unpack temporal extent
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2016-10-24 original script

require_relative 'module_timeInstant'
require_relative 'module_timePeriod'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module TemporalExtent

               def self.unpack(hTemporal, responseObj)

                  # return nil object if input is empty
                  if hTemporal.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson temporal extent object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intTemporal = intMetadataClass.newTemporalExtent
                  haveOne = false

                  # temporal extent - time instant (required if not others)
                  if hTemporal.has_key?('timeInstant')
                     hTime = hTemporal['timeInstant']
                     unless hTime.empty?
                        hObject = TimeInstant.unpack(hTime, responseObj)
                        unless hObject.nil?
                           intTemporal[:timeInstant] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # temporal extent - time period (required if not others)
                  if hTemporal.has_key?('timePeriod')
                     hTime = hTemporal['timePeriod']
                     unless hTime.empty?
                        hObject = TimePeriod.unpack(hTime, responseObj)
                        unless hObject.nil?
                           intTemporal[:timePeriod] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # error messages
                  unless haveOne
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson temporal extent must have a time period or time instant'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intTemporal

               end

            end

         end
      end
   end
end
