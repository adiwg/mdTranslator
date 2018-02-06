# unpack distribution
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-01-29 add liabilityStatement
#  Stan Smith 2016-10-21 original script

require_relative 'module_distributor'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Distribution

               def self.unpack(hDistribution, responseObj)

                  # return nil object if input is empty
                  if hDistribution.empty?
                     responseObj[:readerExecutionMessages] << 'Distribution object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDistribution = intMetadataClass.newDistribution

                  # distribution - description
                  if hDistribution.has_key?('description')
                     if hDistribution['description'] != ''
                        intDistribution[:description] = hDistribution['description']
                     end
                  end

                  # distribution - liability statement
                  if hDistribution.has_key?('liabilityStatement')
                     if hDistribution['liabilityStatement'] != ''
                        intDistribution[:liabilityStatement] = hDistribution['liabilityStatement']
                     end
                  end

                  # distribution - distributor [distributor]
                  if hDistribution.has_key?('distributor')
                     aItems = hDistribution['distributor']
                     aItems.each do |item|
                        hReturn = Distributor.unpack(item, responseObj)
                        unless hReturn.nil?
                           intDistribution[:distributor] << hReturn
                        end
                     end
                  end

                  return intDistribution

               end

            end

         end
      end
   end
end
