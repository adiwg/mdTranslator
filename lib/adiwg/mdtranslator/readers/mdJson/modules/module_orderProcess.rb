# unpack order process
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
#  Stan Smith 2016-10-21 original script

require_relative 'module_dateTime'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module OrderProcess

               def self.unpack(hOrder, responseObj)

                  # return nil object if input is empty
                  if hOrder.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: distribution order process object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intOrder = intMetadataClass.newOrderProcess

                  # order process - fees
                  if hOrder.has_key?('fees')
                     unless hOrder['fees'] == ''
                        intOrder[:fees] = hOrder['fees']
                     end
                  end

                  # order process - planned availability
                  if hOrder.has_key?('plannedAvailability')
                     unless hOrder['plannedAvailability'].empty?
                        hDate = DateTime.unpack(hOrder['plannedAvailability'], responseObj)
                        unless hDate.nil?
                           intOrder[:plannedAvailability] = hDate
                        end
                     end
                  end

                  # order process - ordering instructions
                  if hOrder.has_key?('orderingInstructions')
                     unless hOrder['orderingInstructions'] == ''
                        intOrder[:orderingInstructions] = hOrder['orderingInstructions']
                     end
                  end

                  # order process - turnaround
                  if hOrder.has_key?('turnaround')
                     unless hOrder['turnaround'] == ''
                        intOrder[:turnaround] = hOrder['turnaround']
                     end
                  end

                  return intOrder
               end

            end

         end
      end
   end
end
