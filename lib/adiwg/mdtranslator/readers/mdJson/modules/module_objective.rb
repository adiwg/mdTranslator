require_relative 'module_identifier'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Objective
                    def self.unpack(hObjective, responseObj, inContext = nil)

                        intMetadataClass = InternalMetadata.new
                        intObjective = intMetadataClass.newObjective

                        outContext = 'objective'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        objectiveTypeArray = [
                            "instantaneousCollection",
                            "persistentView",
                            "survey"
                        ]

                        if hObjective.has_key?('ObjectiveId')
                            intObjective[:ObjectiveId] = hAcqPlan['requirementId']
                        end

                        if hObjective.has_key?('identifier')
                            aItems = hObjective['identifier']
                            aItems.each do |item|
                                hReturn = Identifier.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intObjective[:identifiers] << hReturn
                                end
                            end
                        end

                        if hObjective.has_key?('priority')
                            intObjective[:priority] = hObjective['priority']
                        end

                        if hObjective.has_key?('objectiveType')
                            aItems = hObjective['objectiveType']
                            aItems.each do |item|
                                if objectiveTypeArray.include?(item)
                                    intObjective[:objectiveTypes] << item
                                end
                            end
                        end

                        if hObjective.has_key?('function')
                            intObjective[:function] = hObjective['function']
                        end

                        intObjective
                    end
                end

            end
        end
    end
end