require_relative 'class_identifier'
require_relative 'class_codelist'
require_relative 'class_gcoDateTime'
require_relative 'class_objective'
require_relative 'class_pass'
require_relative 'class_instrument'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Event
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hEvent)

                        identifierClass = Identifier.new(@xml, @hResponseObj)
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        gcoDateTimeClass = GcoDateTime.new(@xml, @hResponseObj)
                        objectiveClass = MI_Objective.new(@xml, @hResponseObj)
                        passClass = MI_Pass.new(@xml, @hResponseObj)
                        instrumentClass = MI_Instrument.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_Event') do

                            unless hEvent[:identifier].empty?
                                @xml.tag!('mac:identifier') do
                                    identifierClass.writeXML(hEvent[:identifier])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:identifier')
                                end
                            end

                            unless hEvent[:trigger].nil?
                                @xml.tag!('mac:trigger') do
                                    codelistClass.writeXML('mac', 'iso_triggerCode', hEvent[:trigger])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:trigger')
                                end
                            end

                            unless hEvent[:context].nil?
                                @xml.tag!('mac:context') do
                                    codeListClass.writeXML('mac', 'iso_contextCode', hEvent[:context])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:context')
                                end
                            end

                            unless hEvent[:sequence].nil?
                                @xml.tag!('mac:sequence') do
                                    codelistClass.writeXML('mac', 'iso_sequenceCode', hEvent[:sequence])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:sequence')
                                end
                            end

                            unless hEvent[:time].nil?
                                @xml.tag!('mac:time') do
                                    gcoDateTimeClass.writeXML(hEvent[:time])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:time')
                                end
                            end

                            unless hEvent[:expectedObjectives].empty?
                                hEvent[:expectedObjectives].each do |hObjective|
                                    @xml.tag!('mac:expectedObjective') do
                                        objectiveClass.writeXML(hObjective)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:expectedObjective')
                                end
                            end

                            unless hEvent[:relatedPass].empty?
                                hEvent[:relatedPass].each do |hPass|
                                    @xml.tag!('mac:relatedPass') do
                                        passClass.writeXML(hPass)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:relatedPass')
                                end
                            end

                            unless hEvent[:relatedSensors].empty?
                                hEvent[:relatedSensors].each do |hSensor|
                                    @xml.tag!('mac:relatedInstrument') do
                                        instrumentClass.writeXML(hSensor)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:relatedInstrument')
                                end
                            end

                        end
                    end
                end

            end
        end
    end
end
