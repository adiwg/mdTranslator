# ISO <<Class>> CI_ResponsibleParty
# writer output in XML

# History:
# 	Stan Smith 2013-08-13 original script.
#   Stan Smith 2014-05-14 modified for JSON schema 0.4.0
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_codelist'
require_relative 'class_contact'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class CI_ResponsibleParty

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(rParty)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)
                        ciContactClass = CI_Contact.new(@xml, @responseObj)

                        # search array of responsible party for matches in contact object
                        rpID = rParty[:contactId]
                        unless rpID.nil?
                            hContact = ADIWG::Mdtranslator::Writers::Iso19115_2.getContact(rpID)
                            unless hContact.empty?
                                @xml.tag!('gmd:CI_ResponsibleParty') do

                                    # responsible party - individual name
                                    s = hContact[:indName]
                                    if !s.nil?
                                        @xml.tag!('gmd:individualName') do
                                            @xml.tag!('gco:CharacterString', hContact[:indName])
                                        end
                                    elsif @responseObj[:writerShowTags]
                                        @xml.tag!('gmd:individualName')
                                    end

                                    # responsible party - organization name
                                    s = hContact[:orgName]
                                    if !s.nil?
                                        @xml.tag!('gmd:organisationName') do
                                            @xml.tag!('gco:CharacterString', hContact[:orgName])
                                        end
                                    elsif @responseObj[:writerShowTags]
                                        @xml.tag!('gmd:organisationName')
                                    end

                                    # responsible party - position name
                                    s = hContact[:position]
                                    if !s.nil?
                                        @xml.tag!('gmd:positionName') do
                                            @xml.tag!('gco:CharacterString', hContact[:position])
                                        end
                                    elsif @responseObj[:writerShowTags]
                                        @xml.tag!('gmd:positionName')
                                    end

                                    # responsible party - contact info
                                    # the following elements belong to CI_Contact
                                    if !(hContact[:phones].empty? &&
                                        hContact[:address].empty? &&
                                        hContact[:onlineRes].empty? &&
                                        hContact[:contactInstructions].nil?)
                                        @xml.tag!('gmd:contactInfo') do
                                            ciContactClass.writeXML(hContact)
                                        end
                                    elsif @responseObj[:writerShowTags]
                                        @xml.tag!('gmd:contactInfo')
                                    end

                                    # responsible party - role - required
                                    s = rParty[:roleName]
                                    if s.nil?
                                        xml.tag!('gmd:role', {'gco:nilReason' => 'missing'})
                                    else
                                        @xml.tag! 'gmd:role' do
                                            codelistClass.writeXML('iso_role',s)
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
