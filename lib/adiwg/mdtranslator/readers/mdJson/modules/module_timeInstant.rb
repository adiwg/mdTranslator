# unpack time instant
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2017-11-07 add geologic age
# 	Stan Smith 2016-10-24 original script

require_relative 'module_identifier'
require_relative 'module_dateTime'
require_relative 'module_geologicAge'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module TimeInstant

               def self.unpack(hInstant, responseObj)

                  # return nil object if input is empty
                  if hInstant.empty?
                     responseObj[:readerExecutionMessages] << 'Time Instant object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intInstant = intMetadataClass.newTimeInstant

                  # time instant - id
                  if hInstant.has_key?('id')
                     if hInstant['id'] != ''
                        intInstant[:timeId] = hInstant['id']
                     end
                  end

                  # time instant - description
                  if hInstant.has_key?('description')
                     if hInstant['description'] != ''
                        intInstant[:description] = hInstant['description']
                     end
                  end

                  # time instant - identifier {Identifier}
                  if hInstant.has_key?('identifier')
                     unless hInstant['identifier'].empty?
                        hReturn = Identifier.unpack(hInstant['identifier'], responseObj)
                        unless hReturn.nil?
                           intInstant[:identifier] = hReturn
                        end
                     end
                  end

                  # time instant - instant names []
                  if hInstant.has_key?('instantName')
                     hInstant['instantName'].each do |item|
                        if item != ''
                           intInstant[:instantNames] << item
                        end
                     end
                  end

                  # time instant - datetime
                  if hInstant.has_key?('dateTime')
                     if hInstant['dateTime'] != ''
                        hDate = DateTime.unpack(hInstant['dateTime'], responseObj)
                        unless hDate.nil?
                           intInstant[:timeInstant] = hDate
                        end
                     end
                  end
                  # time instant - geologic age
                  if hInstant.has_key?('geologicAge')
                     unless hInstant['geologicAge'].empty?
                        hGeoAge = GeologicAge.unpack(hInstant['geologicAge'], responseObj)
                        unless hGeoAge.nil?
                           intInstant[:geologicAge] = hGeoAge
                        end
                     end
                  end

                  # time instant must have either a time instant or geologic age
                  if intInstant[:timeInstant].empty? && intInstant[:geologicAge].empty?
                     responseObj[:readerExecutionMessages] << 'Time Instant is missing dateTime or geologic age'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intInstant

               end
            end

         end
      end
   end
end
