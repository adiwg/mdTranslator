# ISO <<Class>> CI_Contact
# writer output in XML

# History:
# 	Stan Smith 2013-08-12 original script
#   Stan Smith 2014-05-14 modified for JSON schema version 0.4.0
#   Stan Smith 2014-05-16 added method to return contact from array
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'class_telephone'
require 'class_address'
require 'class_onlineResource'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class CI_Contact

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hContact)

                        # classes used
                        pBookClass = $IsoNS::CI_Telephone.new(@xml, @responseObj)
                        addClass = $IsoNS::CI_Address.new(@xml, @responseObj)
                        resourceClass = $IsoNS::CI_OnlineResource.new(@xml, @responseObj)

                        @xml.tag!('gmd:CI_Contact') do

                            # contact - phone list - all services
                            aPhones = hContact[:phones]
                            if !aPhones.empty?
                                @xml.tag!('gmd:phone') do
                                    pBookClass.writeXML(aPhones)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:phone')
                            end

                            # contact - address
                            hAddress = hContact[:address]
                            if !hAddress.empty?
                                @xml.tag!('gmd:address') do
                                    addClass.writeXML(hAddress)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:address')
                            end

                            # contact - online resource
                            aResource = hContact[:onlineRes]
                            if !aResource.empty?
                                @xml.tag!('gmd:onlineResource') do
                                    resourceClass.writeXML(aResource[0])
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:onlineResource')
                            end

                            # contact - contact instructions
                            s = hContact[:contactInstructions]
                            if !s.nil?
                                @xml.tag!('gmd:contactInstructions') do
                                    @xml.tag!('gco:CharacterString', hContact[:contactInstructions])
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:contactInstructions')
                            end

                        end
                    end

                    def getContact(contactID)

                        # find contact in contact array and return the hash
                        $intContactList.each do |hContact|
                            if hContact[:contactId] == contactID
                                return hContact
                            end
                        end

                        return {}

                    end

                end

            end
        end
    end
end
