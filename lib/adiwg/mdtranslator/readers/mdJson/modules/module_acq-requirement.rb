require_relative 'module_citation'
require_relative 'module_identifier'
require_relative 'module_date'
require_relative 'module_acq-plan'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module AcqRequirement
                    def self.unpack(hAcqRequirement, responseObj, inContext = nil)

                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        # return nil object if input is empty
                        if hAcqPlan.empty?
                            @MessagePath.issueWarning(40, responseObj, inContext)
                            return nil
                        end

                        intAcqRequirement = intMetadataClass.newRequirement

                        if intAcqRequirement.has_key('requirementId')
                            intAcqRequirement[:requirementId] = hAcqPlan['requirementId']
                        end

                        if hAcqRequirement.has_key?('citation')
                            hReturn = Citation.unpack(hAcqRequirement['citation'], responseObj, inContext)
                            unless hReturn.nil?
                                intAcqRequirement[:citation] = hReturn
                            end
                        end

                        if hAcqRequirement.has_key?('identifier')
                            aItems = hAcqRequirement['identifier']
                            aItems.each do |item|
                                hReturn = Identifier.unpack(item, responseObj, inContext)
                                unless hReturn.nil?
                                    intAcqRequirement[:identifiers] << hReturn
                                end
                            end
                        end

                        if hAcqRequirement.has_key?('requestors')
                            hAcqRequirement['requestors'].each do |requestor|
                                intAcqRequirement[:requestors] << requestor
                            end
                        end

                        if hAcqRequirement.has_key?('recipients')
                            hAcqRequirement['recipients'].each do |recipient|
                                intAcqRequirement[:recipients] << recipient
                            end
                        end

                        if hAcqRequirement.has_key?('priority')
                            intAcqRequirement[:priority] = hAcqRequirement['priority']
                        end

                        if hAcqRequirement.has_key?('requestedDate')
                            hReturn = Date.unpack(hAcqRequirement['requestedDate'], responseObj, inContext)
                            unless hReturn.nil?
                                intAcqRequirement[:requestedDate] = hReturn
                            end
                        end

                        if hAcqRequirement.has_key?('expiryDate')
                            intAcqRequirement[:expiryDate] = hAcqRequirement['expiryDate']
                        end

                        if hAcqRequirement.has_key?('satisfiedPlans')
                            aItems = hAcqRequirement['satisfiedPlans']
                            aItems.each do |item|
                                hReturn = AcqPlan.unpack(item, responseObj, inContext)
                                unless hReturn.nil?
                                    intAcqRequirement[:satisfiedPlans] << hReturn
                                end
                            end
                        end

                    end
                end

            end
        end
    end
end