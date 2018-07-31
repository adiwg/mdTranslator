# unpack time interval
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-27 refactored error and warning messaging
# 	Stan Smith 2016-10-14 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module TimeInterval

               def self.unpack(hTimeInt, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hTimeInt.empty?
                     @MessagePath.issueWarning(860, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intTime = intMetadataClass.newTimeInterval

                  # time interval - interval (required)
                  if hTimeInt.has_key?('interval')
                     interval = hTimeInt['interval']
                     unless interval == ''
                        if interval.is_a?(Numeric)
                           intTime[:interval] = hTimeInt['interval']
                        else
                           @MessagePath.issueError(861, responseObj, inContext)
                        end
                     end
                  end
                  if intTime[:interval].nil? || intTime[:interval] == ''
                     @MessagePath.issueError(862, responseObj, inContext)
                  end

                  # time interval - units (required) {enum}
                  if hTimeInt.has_key?('units')
                     units = hTimeInt['units']
                     unless units.nil?
                        if %w{year month day hour minute second}.one? {|word| word == units}
                           intTime[:units] = hTimeInt['units']
                        end
                     end
                  end
                  if intTime[:units].nil? || intTime[:units] == ''
                     @MessagePath.issueError(863, responseObj, inContext)
                  end

                  return intTime
               end

            end

         end
      end
   end
end
