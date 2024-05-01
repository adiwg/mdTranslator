require_relative 'module_scope'
require_relative 'module_requirement'
require_relative 'module_acq-objective'
require_relative 'module_acq-platform'
require_relative 'module_instrument'
require_relative 'module_acq-operation'
require_relative 'module_event'
require_relative 'module_acq-pass'
require_relative 'module_environment'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson
 
            module Acquisition
 
               def self.unpack(hAcquisition, responseObj, inContext = nil)
 
                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  outContext = 'acquisition'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intAcquisition = intMetadataClass.newAcquisition
 
                  if hAcquisition.has_key?('scope')
                     unless hAcquisition['scope'].empty?
                        hReturn = Scope.unpack(hAcquisition['scope'], responseObj, outContext)
                        unless hReturn.nil?
                           intAcquisition[:scope] = hReturn
                        end
                     end
                  end

                  # if hAcquisition.has_key?('plan')
                  #    aItems = hAcquisition['plan']
                  #    aItems.each do |item|
                  #       hReturn = AcqPlan.unpack(item, responseObj, outContext)
                  #       unless hReturn.nil?
                  #          intAcquisition[:plans] << hReturn
                  #       end
                  #    end
                  # end

                  if hAcquisition.has_key?('requirement')
                     aItems = hAcquisition['requirement']
                     aItems.each do |item|
                        hReturn = Requirement.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAcquisition[:requirements] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('objective')
                     aItems = hAcquisition['objective']
                     aItems.each do |item|
                        hReturn = AcqObjective.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAcquisition[:objectives] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('platform')
                     aItems = hAcquisition['platform']
                     aItems.each do |item|
                        hReturn = AcqPlatform.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAcquisition[:platforms] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('instrument')
                     aItems = hAcquisition['instrument']
                     aItems.each do |item|
                        hReturn = Instrument.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAcquisition[:instruments] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('operation')
                     aItems = hAcquisition['operation']
                     aItems.each do |item|
                        hReturn = AcqOperation.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAcquisition[:operations] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('event')
                     aItems = hAcquisition['event']
                     aItems.each do |item|
                        hReturn = Event.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAcquisition[:events] << hReturn
                        end
                     end
                  end

                  if hAcquisition.has_key?('pass')
                     aItems = hAcquisition['pass']
                     aItems.each do |item|
                        hReturn = AcqPass.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intAcquisition[:passs] << hReturn
                        end
                     end
                  end
                  
                  if hAcquisition.has_key?('environment')
                     intAcquisition[:environments] = hAcquisition['environment']
                  end
                  puts intAcquisition
                  return intAcquisition

               end

            end
 
         end
      end
   end
end
 