# unpack distribution
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
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
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: distribution object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDistribution = intMetadataClass.newDistribution

                  haveDist = false

                  # distribution - description
                  if hDistribution.has_key?('description')
                     unless hDistribution['description'] == ''
                        intDistribution[:description] = hDistribution['description']
                        haveDist = true
                     end
                  end

                  # distribution - liability statement
                  if hDistribution.has_key?('liabilityStatement')
                     unless hDistribution['liabilityStatement'] == ''
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
                           haveDist = true
                        end
                     end
                  end

                  # error messages
                  unless haveDist
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson distribution must have description or distributor'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intDistribution

               end

            end

         end
      end
   end
end
