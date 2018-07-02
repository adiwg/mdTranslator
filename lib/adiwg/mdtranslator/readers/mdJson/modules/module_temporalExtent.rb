# unpack temporal extent
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-26 refactored error and warning messaging
# 	Stan Smith 2016-10-24 original script

require_relative 'module_timeInstant'
require_relative 'module_timePeriod'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module TemporalExtent

               def self.unpack(hTemporal, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hTemporal.empty?
                     @MessagePath.issueWarning(840, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intTemporal = intMetadataClass.newTemporalExtent

                  outContext = 'temporal extent'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveOne = false

                  # temporal extent - time instant (required if not others)
                  if hTemporal.has_key?('timeInstant')
                     hTime = hTemporal['timeInstant']
                     unless hTime.empty?
                        hObject = TimeInstant.unpack(hTime, responseObj, outContext)
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
                        hObject = TimePeriod.unpack(hTime, responseObj, outContext)
                        unless hObject.nil?
                           intTemporal[:timePeriod] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # error messages
                  unless haveOne
                     @MessagePath.issueError(841, responseObj, inContext)
                  end

                  return intTemporal

               end

            end

         end
      end
   end
end
