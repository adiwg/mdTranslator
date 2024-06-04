require_relative 'class_scope'
require_relative 'class_plan'
require_relative 'class_instrument'

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
                        instrumentClass = MI_Instrument.new(@xml, @hResponseObj)

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

                                unless hAcquisition[:instruments].empty?
                                    hAcquisition[:instruments].each do |hInstrument|
                                        @xml.tag!('mac:instrument') do
                                            instrumentClass.writeXML(hInstrument)
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
