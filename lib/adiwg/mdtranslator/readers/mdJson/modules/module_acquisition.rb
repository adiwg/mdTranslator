require_relative 'module_scope'
require_relative 'module_acq-requirement'
require_relative 'module_acq-objective'
require_relative 'module_acq-platform'
require_relative 'module_acq-instrument'
require_relative 'module_acq-operation'
require_relative 'module_acq-event'
require_relative 'module_acq-pass'
require_relative 'module_acq-environment'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson
 
            module Acquisition
 
               def self.unpack(hAcquisition, responseObj, inContext = nil)
 
                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson


                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intAcquisition = intMetadataClass.newAcquisition
 
                  if hAcquisition.has_key?('scope')
                     unless hAcquisition['scope'].empty?
                        hReturn = Scope.unpack(hAcquisition['scope'], responseObj, outContext)
                        unless hReturn.nil?
                           intAlgorithm[:scope] = hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('plan')
                     aItems = hAcquisition['plan']
                     aItems.each do |item|
                        hReturn = AcqPlan.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:plans] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('requirement')
                     aItems = hAcquisition['requirement']
                     aItems.each do |item|
                        hReturn = AcqRequirement.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:requirements] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('objective')
                     aItems = hAcquisition['objective']
                     aItems.each do |item|
                        hReturn = AcqObjective.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:objectives] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('platform')
                     aItems = hAcquisition['platform']
                     aItems.each do |item|
                        hReturn = AcqPlatform.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:platforms] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('instrument')
                     aItems = hAcquisition['instrument']
                     aItems.each do |item|
                        hReturn = AcqInstrument.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:instruments] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('operation')
                     aItems = hAcquisition['operation']
                     aItems.each do |item|
                        hReturn = AcqOperation.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:operations] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('event')
                     aItems = hAcquisition['event']
                     aItems.each do |item|
                        hReturn = AcqEvent.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:events] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('pass')
                     aItems = hAcquisition['pass']
                     aItems.each do |item|
                        hReturn = AcqPass.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAttGroup[:passs] << hReturn
                        end
                     end
                  end
                  
                  return intAcquisition

               end

               if hAcquisition.has_key?('environment')
                  aItems = hAcquisition['environment']
                  aItems.each do |item|
                     hReturn = AcqEnvironment.unpack(item, responseObj, outContext)
                     unless hReturn.nil?
                        intAttGroup[:environments] << hReturn
                     end
                  end
               end

            end
 
         end
      end
   end
end
 