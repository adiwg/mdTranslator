# ISO <<Class>> MD_Usage
# writer output in XML

# History:
# 	Stan Smith 2013-11-19 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_responsibleParty'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Usage

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hUsage)

                        # classes used in MD_Usage
                        rPartyClass = CI_ResponsibleParty.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_Usage') do

                            # usage - specific usage - required
                            s = hUsage[:specificUsage]
                            if s.nil?
                                @xml.tag!('gmd:specificUsage', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:specificUsage') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end

                            # usage - user determined limitations
                            s = hUsage[:userLimits]
                            if !s.nil?
                                @xml.tag!('gmd:userDeterminedLimitations') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:userDeterminedLimitations')
                            end

                            # usage - user contact info - responsible party
                            aContacts = hUsage[:userContacts]
                            if !aContacts.empty?
                                aContacts.each do |rParty|
                                    @xml.tag!('gmd:userContactInfo') do
                                        rPartyClass.writeXML(rParty)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:userContactInfo')
                            end

                        end

                    end

                end

            end
        end
    end
end
