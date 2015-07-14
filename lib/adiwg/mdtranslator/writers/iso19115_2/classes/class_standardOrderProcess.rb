# ISO <<Class>> MD_StandardOrderProcess
# writer output in XML

# History:
# 	Stan Smith 2013-09-25 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'module_dateTimeFun'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_StandardOrderProcess

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(orderProcess)

                        # classes used

                        @xml.tag!('gmd:MD_StandardOrderProcess') do

                            # order process - fees
                            s = orderProcess[:fees]
                            if !s.nil?
                                @xml.tag!('gmd:fees') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:fees')
                            end

                            # order process - plannedAvailableDateTime
                            hDateTime = orderProcess[:plannedDateTime]
                            if !hDateTime.empty?
                                paDateTime = hDateTime[:dateTime]
                                paDateRes = hDateTime[:dateResolution]
                                if paDateTime.nil?
                                    @xml.tag!('gmd:plannedAvailableDateTime')
                                else
                                    @xml.tag!('gmd:plannedAvailableDateTime') do
                                        dateTimeStr =
                                            AdiwgDateTimeFun.stringDateTimeFromDateTime(paDateTime, paDateRes)
                                        @xml.tag!('gco:DateTime', dateTimeStr)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:plannedAvailableDateTime')
                            end

                            # order process - orderingInstructions
                            s = orderProcess[:orderInstructions]
                            if !s.nil?
                                @xml.tag!('gmd:orderingInstructions') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:orderingInstructions')
                            end

                            # order process - turnaround
                            s = orderProcess[:turnaround]
                            if !s.nil?
                                @xml.tag!('gmd:turnaround') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:turnaround')
                            end

                        end

                    end

                end

            end
        end
    end

end
