require_relative 'module_citation'
require_relative 'module_identifier'
require_relative 'module_requestedDate'
require_relative 'module_plan'
require_relative 'module_responsibleParty'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Requirement
                    def self.unpack(hRequirement, responseObj, inContext = nil)

                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        outContext = 'requirement'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        # return nil object if input is empty
                        if hRequirement.empty?
                            @MessagePath.issueWarning(41, responseObj, outContext)
                            return nil
                        end

                        intMetadataClass = InternalMetadata.new
                        intRequirement = intMetadataClass.newRequirement

                        if hRequirement.has_key?('requirementId')
                            intRequirement[:requirementId] = hRequirement['requirementId']
                        end

                        if hRequirement.has_key?('citation')
                            hReturn = Citation.unpack(hRequirement['citation'], responseObj, outContext)
                            unless hReturn.nil?
                                intRequirement[:citation] = hReturn
                            end
                        end

                        if hRequirement.has_key?('identifier')
                            hReturn = Identifier.unpack(hRequirement['identifier'], responseObj, outContext)
                            unless hReturn.nil?
                                intRequirement[:identifier] = hReturn
                            end
                        end

                        if hRequirement.has_key?('requestor')
                            hRequirement['requestor'].each do |requestor|
                                hReturn = ResponsibleParty.unpack(requestor, responseObj, outContext)
                                unless hReturn.nil?
                                    intRequirement[:requestors] << hReturn
                                end
                            end
                        end

                        if hRequirement.has_key?('recipient')
                            hRequirement['recipient'].each do |recipient|
                                hReturn = ResponsibleParty.unpack(recipient, responseObj, outContext)
                                unless hReturn.nil?
                                    intRequirement[:recipients] << hReturn
                                end
                            end
                        end

                        if hRequirement.has_key?('priority')
                            intRequirement[:priority] = hRequirement['priority']
                        end

                        if hRequirement.has_key?('requestedDate')
                            hReturn = RequestedDate.unpack(hRequirement['requestedDate'], responseObj, outContext)
                            unless hReturn.nil?
                                intRequirement[:requestedDate] = hReturn
                            end
                        end

                        if hRequirement.has_key?('expiryDate')
                            intRequirement[:expiryDate] = hRequirement['expiryDate']
                        end

                        if hRequirement.has_key?('satisfiedPlan')
                            aItems = hRequirement['satisfiedPlan']
                            aItems.each do |item|
                                hReturn = Plan.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intRequirement[:satisfiedPlans] << hReturn
                                end
                            end
                        end

                        intRequirement

                    end
                end

            end
        end
    end
end