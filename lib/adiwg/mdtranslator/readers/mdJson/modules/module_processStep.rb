# unpack process step
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2019-09-23 add LE_Source elements
#  Stan Smith 2018-06-22 refactored error and warning messaging
#  Stan Smith 2017-08-30 added support for process step sources
#  Stan Smith 2016-10-15 refactored for mdJson 2.0
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
# 	Stan Smith 2013-11-26 original script

require_relative 'module_timePeriod'
require_relative 'module_responsibleParty'
require_relative 'module_citation'
require_relative 'module_scope'
require_relative 'module_source'
require_relative 'module_processing'
require_relative 'module_processReport'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ProcessStep

               def self.unpack(hProcStep, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hProcStep.empty?
                     @MessagePath.issueWarning(640, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intProcStep = intMetadataClass.newProcessStep

                  outContext = 'process step'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # process step - step ID
                  if hProcStep.has_key?('stepId')
                     unless hProcStep['stepId'] == ''
                        intProcStep[:stepId] = hProcStep['stepId']
                     end
                  end

                  # process step - description - (required)
                  if hProcStep.has_key?('description')
                     unless hProcStep['description'] == ''
                        intProcStep[:description] = hProcStep['description']
                     end
                  end
                  if intProcStep[:description].nil?
                     @MessagePath.issueError(641, responseObj, inContext)
                  end

                  # process step - rationale
                  if hProcStep.has_key?('rationale')
                     unless hProcStep['rationale'] == ''
                        intProcStep[:rationale] = hProcStep['rationale']
                     end
                  end

                  # process step - time period
                  if hProcStep.has_key?('timePeriod')
                     unless hProcStep['timePeriod'].empty?
                        hReturn = TimePeriod.unpack(hProcStep['timePeriod'], responseObj, outContext)
                        unless hReturn.nil?
                           intProcStep[:timePeriod] = hReturn
                        end
                     end
                  end

                  # process step - step processors [] {responsibility}
                  if hProcStep.has_key?('processor')
                     aProc = hProcStep['processor']
                     aProc.each do |item|
                        hParty = ResponsibleParty.unpack(item, responseObj, outContext)
                        unless hParty.nil?
                           intProcStep[:processors] << hParty
                        end
                     end
                  end

                  # process step - reference [] {citation}
                  if hProcStep.has_key?('reference')
                     aReference = hProcStep['reference']
                     aReference.each do |item|
                        hReference = Citation.unpack(item, responseObj, outContext)
                        unless hReference.nil?
                           intProcStep[:references] << hReference
                        end
                     end
                  end

                  # process step - step sources [] {source}
                  if hProcStep.has_key?('stepSource')
                     aSources = hProcStep['stepSource']
                     aSources.each do |item|
                        hSource = Source.unpack(item, responseObj, outContext)
                        unless hSource.nil?
                           intProcStep[:stepSources] << hSource
                        end
                     end
                  end

                  # process step LE 'output' - step products [] {source}
                  if hProcStep.has_key?('stepProduct')
                     aSources = hProcStep['stepProduct']
                     aSources.each do |item|
                        hSource = Source.unpack(item, responseObj, outContext)
                        unless hSource.nil?
                           intProcStep[:stepProducts] << hSource
                        end
                     end
                  end

                  # process step - scope {scope}
                  if hProcStep.has_key?('scope')
                     hObject = hProcStep['scope']
                     unless hObject.empty?
                        hReturn = Scope.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intProcStep[:scope] = hReturn
                        end
                     end
                  end

                  # process step LE - processing information {processing}
                  if hProcStep.has_key?('processingInformation')
                     unless hProcStep['processingInformation'].empty?
                        hReturn = Processing.unpack(hProcStep['processingInformation'], responseObj, outContext)
                        unless hReturn.nil?
                           intProcStep[:processingInformation] = hReturn
                        end
                     end
                  end

                  # process step LE - report [] {processReport}
                  if hProcStep.has_key?('report')
                     aReports = hProcStep['report']
                     aReports.each do |item|
                        hReport = ProcessStepReport.unpack(item, responseObj, outContext)
                        unless hReport.nil?
                           intProcStep[:reports] << hReport
                        end
                     end
                  end

                  return intProcStep

               end

            end

         end
      end
   end
end
