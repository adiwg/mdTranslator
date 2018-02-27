# unpack time interval
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2016-10-14 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module TimeInterval

               def self.unpack(hTimeInt, responseObj)

                  # return nil object if input is empty
                  if hTimeInt.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: time interval object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intTime = intMetadataClass.newTimeInterval

                  # time interval - interval (required)
                  if hTimeInt.has_key?('interval')
                     interval = hTimeInt['interval']
                     unless interval == ''
                        if interval.is_a?(Integer) || interval.is_a?(Float)
                           intTime[:interval] = hTimeInt['interval']
                        else
                           responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: time interval must be a number'
                           responseObj[:readerExecutionPass] = false
                           return nil
                        end
                     end
                  end
                  if intTime[:interval].nil? || intTime[:interval] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: time interval is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
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
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: time interval units are missing or invalid'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intTime
               end

            end

         end
      end
   end
end
