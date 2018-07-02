# unpack resource lineage
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
#  Stan Smith 2016-10-17 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
# 	Stan Smith 2013-11-26 original script

require_relative 'module_scope'
require_relative 'module_citation'
require_relative 'module_processStep'
require_relative 'module_source'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ResourceLineage

               def self.unpack(hLineage, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hLineage.empty?
                     @MessagePath.issueWarning(500, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intLineage = intMetadataClass.newLineage

                  outContext = 'resource lineage'
                  haveLineage = false

                  # lineage - statement
                  if hLineage.has_key?('statement')
                     unless hLineage['statement'] == ''
                        intLineage[:statement] = hLineage['statement']
                        haveLineage = true
                     end
                  end

                  # lineage - resource scope
                  if hLineage.has_key?('scope')
                     hObject = hLineage['scope']
                     unless hObject.empty?
                        hReturn = Scope.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intLineage[:resourceScope] = hReturn
                        end
                     end
                  end

                  # lineage - citation []
                  if hLineage.has_key?('citation')
                     aCitation = hLineage['citation']
                     aCitation.each do |item|
                        hCitation = Citation.unpack(item, responseObj, outContext)
                        unless hCitation.nil?
                           intLineage[:lineageCitation] << hCitation
                        end
                     end
                  end

                  # lineage - sources []
                  if hLineage.has_key?('source')
                     aSource = hLineage['source']
                     aSource.each do |item|
                        hSource = Source.unpack(item, responseObj, outContext)
                        unless hSource.nil?
                           intLineage[:dataSources] << hSource
                           haveLineage = true
                        end
                     end
                  end

                  # lineage - process steps []
                  if hLineage.has_key?('processStep')
                     aSteps = hLineage['processStep']
                     aSteps.each do |item|
                        hSteps = ProcessStep.unpack(item, responseObj, outContext)
                        unless hSteps.nil?
                           intLineage[:processSteps] << hSteps
                           haveLineage = true
                        end
                     end
                  end

                  unless haveLineage
                     @MessagePath.issueError(501, responseObj)
                  end

                  return intLineage
               end

            end

         end
      end
   end
end
