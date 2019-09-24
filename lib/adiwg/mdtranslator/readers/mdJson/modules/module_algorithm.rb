# unpack algorithm
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2019-09-23 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Algorithm

               def self.unpack(hAlgorithm, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hAlgorithm.empty?
                     @MessagePath.issueWarning(970, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intAlgorithm = intMetadataClass.newAlgorithm

                  outContext = 'algorithm'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # algorithm - citation (required)
                  if hAlgorithm.has_key?('citation')
                     unless hAlgorithm['citation'].empty?
                        hReturn = Citation.unpack(hAlgorithm['citation'], responseObj, outContext)
                        unless hReturn.nil?
                           intAlgorithm[:citation] = hReturn
                        end
                     end
                  end
                  if intAlgorithm[:citation].empty?
                     @MessagePath.issueWarning(971, responseObj, inContext)
                  end

                  # algorithm - description (required)
                  if hAlgorithm.has_key?('description')
                     unless hAlgorithm['description'] == ''
                        intAlgorithm[:description] = hAlgorithm['description']
                     end
                  end
                  if intAlgorithm[:description].nil?
                     @MessagePath.issueWarning(972, responseObj, inContext)
                  end

                  return intAlgorithm

               end

            end

         end
      end
   end
end
