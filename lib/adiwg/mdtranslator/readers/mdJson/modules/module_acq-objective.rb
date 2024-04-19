module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module AcqObjective
                    def self.unpack(hAcqObjective, responseObj, inContext = nil)
                        
                        intAcqObjective = intMetadataClass.newObjective

                        outContext = 'acquisition objective'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        objectiveTypeArray = [
                            "instantaneousCollection",
                            "persistentView",
                            "survey"
                        ]

                        if hAcqObjective.has_key('ObjectiveId')
                            intAcqObjective[:ObjectiveId] = hAcqPlan['requirementId']
                        end

                        if hAcqObjective.has_key?('identifier')
                            aItems = hAcqObjective['identifier']
                            aItems.each do |item|
                                hReturn = Identifier.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intAcqObjective[:identifiers] << hReturn
                                end
                            end
                        end

                        if hAcqObjective.has_key?('priority')
                            intAcqObjective[:priority] = hAcqObjective['priority']
                        end

                        if hAcqObjective.has_key?('objectiveType') && objectiveTypeArray.include?(hAcqObjective['objectiveType'])
                            aItems = hAcqObjective['objectiveType']
                            aItems.each do |item|
                                intAcqObjective[:objectiveTypes] << item
                            end
                        end

                        if hAcqObjective.has_key?('function')
                            intAcqObjective[:function] = hAcqObjective['function']
                        end

                    end
                end

            end
        end
    end
end