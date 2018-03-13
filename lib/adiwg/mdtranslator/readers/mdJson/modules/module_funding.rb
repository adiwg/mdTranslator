# unpack funding
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
#  Stan Smith 2017-08-30 refactored for mdJson schema 2.3
#  Stan Smith 2016-10-30 original script

require_relative 'module_allocation'
require_relative 'module_timePeriod'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Funding

               def self.unpack(hFunding, responseObj)

                  # return nil object if input is empty
                  if hFunding.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: funding object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intFunding = intMetadataClass.newFunding

                  # funding - description
                  if hFunding.has_key?('description')
                     unless hFunding['description'] == ''
                        intFunding[:description] = hFunding['description']
                     end
                  end

                  # funding - timePeriod (required if)
                  if hFunding.has_key?('timePeriod')
                     hObject = hFunding['timePeriod']
                     unless hObject.empty?
                        hReturn = TimePeriod.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intFunding[:timePeriod] = hReturn
                        end
                     end
                  end

                  # funding - allocation [] (required if)
                  if hFunding.has_key?('allocation')
                     aItems = hFunding['allocation']
                     aItems.each do |item|
                        hReturn = Allocation.unpack(item, responseObj)
                        unless hReturn.nil?
                           intFunding[:allocations] << hReturn
                        end
                     end
                  end

                  # error messages
                  if intFunding[:allocations].empty? && intFunding[:timePeriod].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: funding must have either allocation or timePeriod'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intFunding

               end

            end

         end
      end
   end
end
