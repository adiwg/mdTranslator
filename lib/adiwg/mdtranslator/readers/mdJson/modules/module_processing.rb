# unpack processing
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2019-09-23 original script

require_relative 'module_identifier'
require_relative 'module_citation'
require_relative 'module_algorithm'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Processing

               def self.unpack(hProcessing, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hProcessing.empty?
                     @MessagePath.issueWarning(990, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intProcessing = intMetadataClass.newProcessing

                  outContext = 'process step report'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # processing - identifier {identifier} (required)
                  if hProcessing.has_key?('identifier')
                     unless hProcessing['identifier'].empty?
                        hReturn = Identifier.unpack(hProcessing['identifier'], responseObj, outContext)
                        unless hReturn.nil?
                           intProcessing[:identifier] = hReturn
                        end
                     end
                  end
                  if intProcessing[:identifier].empty?
                     @MessagePath.issueWarning(991, responseObj, inContext)
                  end

                  # processing - software reference
                  if hProcessing.has_key?('softwareReference')
                     unless hProcessing['softwareReference'].empty?
                        hReturn = Citation.unpack(hProcessing['softwareReference'], responseObj, outContext)
                        unless hReturn.nil?
                           intProcessing[:softwareReference] = hReturn
                        end
                     end
                  end

                  # processing - procedure description
                  if hProcessing.has_key?('procedureDescription')
                     unless hProcessing['procedureDescription'] == ''
                        intProcessing[:procedureDescription] = hProcessing['procedureDescription']
                     end
                  end

                  # processing - documentation
                  if hProcessing.has_key?('documentation')
                     aCitation = hProcessing['documentation']
                     aCitation.each do |item|
                        hCitation = Citation.unpack(item, responseObj, outContext)
                        unless hCitation.nil?
                           intProcessing[:documentation] << hCitation
                        end
                     end
                  end

                  # processing - runtime parameters
                  if hProcessing.has_key?('runtimeParameters')
                     unless hProcessing['runtimeParameters'] == ''
                        intProcessing[:runtimeParameters] = hProcessing['runtimeParameters']
                     end
                  end

                  # processing - algorithm
                  if hProcessing.has_key?('algorithm')
                     aAlgorithm = hProcessing['algorithm']
                     aAlgorithm.each do |item|
                        hAlgorithm = Algorithm.unpack(item, responseObj, outContext)
                        unless hAlgorithm.nil?
                           intProcessing[:algorithms] << hAlgorithm
                        end
                     end
                  end

                  return intProcessing

               end

            end

         end
      end
   end
end
