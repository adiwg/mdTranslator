require_relative 'module_citation'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module AcqPlan
                    def self.unpack(hAcqPlan, responseObj, inContext = nil)
                        
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        # return nil object if input is empty
                        if hAcqPlan.empty?
                            @MessagePath.issueWarning(40, responseObj, inContext)
                            return nil
                        end

                        intAcqPlan = intMetadataClass.newPlan

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

                        if hAcqPlan.has_key('planId')
                            intAcqPlan[:planId] = hAcqPlan['planId']
                            
                        else
                            @MessagePath.issueError(42, responseObj, inContext)
                        end

                        if hAcqPlan.has_key('planType')
                            intAcqPlan[:planType] = hAcqPlan['planType']
                        end

                        if hAcqPlan.has_key('status') && statusArray.include?(hAcqPlan['status'])
                            intAcqPlan[:status] = hAcqPlan['status']
                        else
                            @MessagePath.issueError(43, responseObj, inContext)
                        end

                        if hAcqPlan.has_key('citation')
                            hReturn = Citation.unpack(hAcqPlan['citation'], responseObj, inContext)
                            unless hReturn.nil?
                                intAcqPlan[:citation] = hReturn
                            end
                        else
                            @MessagePath.issueError(44, responseObj, inContext)
                        end

                        if hAcqPlan.has_key?('planOperations')
                            intAcqPlan[:planOperations] = hAcqPlan['planOperations']
                            
                        end

                        if hAcqPlan.has_key?('satisfiedRequirements')
                            intAcqPlan[:satisfiedRequirements] = hAcqPlan['satisfiedRequirements']
                        end

                    end
                end

            end
        end
    end
end
