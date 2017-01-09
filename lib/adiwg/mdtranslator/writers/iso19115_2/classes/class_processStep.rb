# ISO <<Class>> LI_ProcessStep
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-20 original script.

require_relative 'class_responsibleParty'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class LI_ProcessStep

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hStep)

                        # classes used
                        partyClass =  CI_ResponsibleParty.new(@xml, @hResponseObj)

                        # process step - id
                        attributes = {}
                        s = hStep[:stepId]
                        unless s.nil?
                            attributes['id' => s]
                        end

                        @xml.tag!('gmd:LI_ProcessStep', attributes) do

                            # process step - description (required)
                            s = hStep[:description]
                            unless s.nil?
                                @xml.tag!('gmd:description') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil?
                                @xml.tag!('gmd:description', {'gco:nilReason' => 'missing'})
                            end

                            # process step - rationale
                            s = hStep[:rationale]
                            unless s.nil?
                                @xml.tag!('gmd:rationale') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:rationale')
                            end

                            # process step - datetime
                            hPeriod = hStep[:timePeriod]
                            unless hPeriod.empty?
                                hDate = hPeriod[:startDateTime]
                                if hDate.empty?
                                    hDate = hPeriod[:endDateTime]
                                end
                                date = hDate[:dateTime]
                                dateResolution = hDate[:dateResolution]
                                s = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateResolution)
                                if s != 'ERROR'
                                    @xml.tag!('gmd:dateTime') do
                                        @xml.tag!('gco:DateTime', s)
                                    end
                                end
                            end
                            if hPeriod.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:dateTime')
                            end

                            # process step - processor [{CI_ResponsibleParty}]
                            aParties = hStep[:processors]
                            aParties.each do |hRParty|
                                role = hRParty[:roleName]
                                aParties = hRParty[:party]
                                aParties.each do |hParty|
                                    @xml.tag!('gmd:processor') do
                                        partyClass.writeXML(role, hParty)
                                    end
                                end
                            end
                            if aParties.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:processor')
                            end

                            # process step - source (not implemented)

                        end # gmd:LI_ProcessStep tag
                    end # writeXML
                end # LI_ProcessStep class

            end
        end
    end
end
