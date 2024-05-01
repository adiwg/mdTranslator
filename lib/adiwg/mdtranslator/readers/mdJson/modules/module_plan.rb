require 'adiwg/mdtranslator/internal/module_codelistFun'
require_relative 'module_citation'
require_relative 'module_operation'
require_relative 'module_requirement'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Plan
                    def self.unpack(hPlan, responseObj, inContext = nil)
                        
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        # return nil object if input is empty
                        if hPlan.empty?
                            @MessagePath.issueWarning(40, responseObj, inContext)
                            return nil
                        end

                        intMetadataClass = InternalMetadata.new
                        intPlan = intMetadataClass.newPlan

                        outContext = 'plan'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hPlan.has_key?('planId')
                            intPlan[:planId] = hPlan['planId']
                            
                        else
                            @MessagePath.issueError(42, responseObj, outContext)
                        end

                        if hPlan.has_key?('planType') && CodelistFun.validateItem('iso_geometryTypeCode', hPlan['planType'])
                            intPlan[:planType] = hPlan['planType']
                        end

                        if hPlan.has_key?('status') && CodelistFun.validateItem('iso_progress', hPlan['status'])
                            intPlan[:status] = hPlan['status']
                        else
                            @MessagePath.issueError(43, responseObj, outContext)
                        end

                        if hPlan.has_key?('citation')
                            hReturn = Citation.unpack(hPlan['citation'], responseObj, outContext)
                            unless hReturn.nil?
                                intPlan[:citation] = hReturn
                            end
                        else
                            @MessagePath.issueError(44, responseObj, outContext)
                        end

                        if hPlan.has_key?('planOperations')
                            hPlan['planOperations'].each do |item|
                                hReturn = Operation.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intPlan[:planOperations] << hReturn
                                end
                            end                            
                        end

                        if hPlan.has_key?('satisfiedRequirements')
                            hPlan['satisfiedRequirements'].each do |item|
                                hReturn = Requirement.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intPlan[:satisfiedRequirements] << hReturn
                                end
                            end
                        end

                        puts intPlan
                        intPlan

                    end
                end

            end
        end
    end
end
