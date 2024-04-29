require_relative 'module_citation'

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

                        intPlan = intMetadataClass.newPlan

                        statusArray = [
                            "accepted",
                            "cancelled",
                            "completed",
                            "deprecated",
                            "final",
                            "funded",
                            "historicalArchive",
                            "notAccepted",
                            "obsolete",
                            "onGoing",
                            "pending",
                            "planned",
                            "proposed",
                            "required",
                            "retired",
                            "superseded",
                            "suspended",
                            "tentative",
                            "underDevelopment",
                            "valid",
                            "withdrawn"
                        ]

                        if hPlan.has_key('planId')
                            intPlan[:planId] = hPlan['planId']
                            
                        else
                            @MessagePath.issueError(42, responseObj, inContext)
                        end

                        if hPlan.has_key('planType')
                            intPlan[:planType] = hPlan['planType']
                        end

                        if hPlan.has_key('status') && statusArray.include?(hPlan['status'])
                            intPlan[:status] = hPlan['status']
                        else
                            @MessagePath.issueError(43, responseObj, inContext)
                        end

                        if hPlan.has_key('citation')
                            hReturn = Citation.unpack(hPlan['citation'], responseObj, inContext)
                            unless hReturn.nil?
                                intPlan[:citation] = hReturn
                            end
                        else
                            @MessagePath.issueError(44, responseObj, inContext)
                        end

                        if hPlan.has_key?('planOperations')
                            intPlan[:planOperations] = hPlan['planOperations']
                            
                        end

                        if hPlan.has_key?('satisfiedRequirements')
                            intPlan[:satisfiedRequirements] = hPlan['satisfiedRequirements']
                        end

                    end
                end

            end
        end
    end
end
