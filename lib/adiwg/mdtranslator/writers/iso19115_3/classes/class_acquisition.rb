require_relative 'class_scope'
require_relative 'class_plan'
require_relative 'class_requirement'
require_relative 'class_environment'
require_relative 'class_instrument'
require_relative 'class_objective'
require_relative 'class_operation'
require_relative 'class_platform'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_AcquisitionInformation
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hAcquisition)

                        scopeClass = MD_Scope.new(@xml, @hResponseObj)
                        planClass = MI_Plan.new(@xml, @hResponseObj)
                        requirementClass = MI_Requirement.new(@xml, @hResponseObj)
                        environmentClass = MI_EnvironmentalRecord.new(@xml, @hResponseObj)
                        instrumentClass = MI_Instrument.new(@xml, @hResponseObj)
                        objectiveClass = MI_Objective.new(@xml, @hResponseObj)
                        operationClass = MI_Operation.new(@xml, @hResponseObj)
                        platformClass = MI_Platform.new(@xml, @hResponseObj)

                        unless hAcquisition.empty?
                            @xml.tag!('mac:MI_AcquisitionInformation') do
                                unless hAcquisition[:scope].empty?
                                    @xml.tag!('mac:scope') do
                                        scopeClass.writeXML(hAcquisition[:scope])
                                    end
                                end

                                unless hAcquisition[:plans].empty?
                                    hAcquisition[:plans].each do |hPlan|
                                        @xml.tag!('mac:acquisitionPlan') do
                                            planClass.writeXML(hPlan)
                                        end
                                    end
                                end

                                unless hAcquisition[:requirements].empty?
                                    hAcquisition[:requirements].each do |hRequirement|
                                        @xml.tag!('mac:acquisitionRequirement') do
                                            requirementClass.writeXML(hRequirement)
                                        end
                                    end
                                end

                                unless hAcquisition[:environment].empty?
                                    @xml.tag!('mac:environmentalConditions') do
                                        environmentClass.writeXML(hAcquisition[:environment])
                                    end
                                end

                                unless hAcquisition[:instruments].empty?
                                    hAcquisition[:instruments].each do |hInstrument|
                                        @xml.tag!('mac:instrument') do
                                            instrumentClass.writeXML(hInstrument)
                                        end
                                    end
                                end

                                unless hAcquisition[:objectives].empty?
                                    hAcquisition[:objectives].each do |hObjective|
                                        @xml.tag!('mac:objective') do
                                            objectiveClass.writeXML(hObjective)
                                        end
                                    end
                                end

                                unless hAcquisition[:operations].empty?
                                    hAcquisition[:operations].each do |hOperation|
                                        @xml.tag!('mac:operation') do
                                            operationClass.writeXML(hOperation)
                                        end
                                    end
                                end

                                unless hAcquisition[:platforms].empty?
                                    hAcquisition[:platforms].each do |hPlatform|
                                        @xml.tag!('mac:platform') do
                                            platformClass.writeXML(hPlatform)
                                        end
                                    end
                                end
                                
                            end
                        end

                    end

                end
            end
        end
    end
end
