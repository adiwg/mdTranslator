# unpack citation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
#  Stan Smith 2016-12-09 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module TaxonomicSystem

               def self.unpack(hSystem, responseObj)

                  # return nil object if input is empty
                  if hSystem.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson taxonomic system object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intSystem = intMetadataClass.newTaxonSystem

                  # taxonomy system - citation (required) {CI_Citation}
                  if hSystem.has_key?('citation')
                     hCitation = hSystem['citation']
                     unless hCitation.empty?
                        hReturn = Citation.unpack(hCitation, responseObj)
                        unless hReturn.nil?
                           intSystem[:citation] = hReturn
                        end
                     end
                  end
                  if intSystem[:citation].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson taxonomic system citation is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # taxonomy system - modifications
                  if hSystem.has_key?('modifications')
                     unless hSystem['modifications'] == ''
                        intSystem[:modifications] = hSystem['modifications']
                     end
                  end

                  return intSystem

               end

            end

         end
      end
   end
end
