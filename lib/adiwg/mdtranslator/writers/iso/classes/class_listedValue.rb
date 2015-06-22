# ISO <<Class>> FC_ListedValue
# writer output in XML
# to define the domain of an attribute

# History:
# 	Stan Smith 2014-12-02 original script.
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class FC_ListedValue

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hItem)

                        @xml.tag!('gfc:FC_ListedValue') do

                            # listed value - label - required
                            # use domain  item name
                            s = hItem[:itemName]
                            if !s.nil?
                                @xml.tag!('gfc:label') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            else
                                @xml.tag!('gfc:label', {'gco:nilReason' => 'missing'})
                            end

                            # listed value - code
                            # use domain item value
                            s = hItem[:itemValue]
                            if !s.nil?
                                @xml.tag!('gfc:code') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gfc:code')
                            end

                            # listed value - code
                            # use domain item value
                            s = hItem[:itemDefinition]
                            if !s.nil?
                                @xml.tag!('gfc:definition') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gfc:definition')
                            end

                        end

                    end

                    def getDomain(domainID)

                        # find domain in domain array and return the hash
                        $domainList.each do |hDomain|
                            if hDomain[:domainId] == domainID
                                return hDomain
                            end
                        end

                        return {}

                    end

                end

            end
        end
    end
end
