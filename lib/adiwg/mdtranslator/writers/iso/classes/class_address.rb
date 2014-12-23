# ISO <<Class>> CI_Address
# writer output in XML

# History:
# 	Stan Smith 2013-08-09 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-22 added return if passed nil address objects
#   Stan Smith 2014-12-23 refactored to drop physical address elements if no
#                     ... deliveryPoints are provided

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class CI_Address

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hAddress)

                        return if hAddress.nil?

                        deliveryPoints = hAddress[:deliveryPoints].length
                        eMails = hAddress[:eMailList].length

                        if deliveryPoints + eMails > 0
                            @xml.tag!('gmd:CI_Address') do

                                # physical address
                                # ... if no delivery points are provided ignore rest
                                # ... of physical address items
                                if deliveryPoints > 0

                                    # address - delivery points (address lines)
                                    aDeliveryPoints = hAddress[:deliveryPoints]
                                    aDeliveryPoints.each do |myPoint|
                                        @xml.tag!('gmd:deliveryPoint') do
                                            @xml.tag!('gco:CharacterString', myPoint)
                                        end
                                    end

                                    # address - city
                                    s = hAddress[:city]
                                    if !s.nil?
                                        @xml.tag!('gmd:city') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    elsif $showAllTags
                                        @xml.tag!('gmd:city')
                                    end

                                    # address - admin area (state)
                                    s = hAddress[:adminArea]
                                    if !s.nil?
                                        @xml.tag!('gmd:administrativeArea') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    elsif $showAllTags
                                        @xml.tag!('gmd:administrativeArea')
                                    end

                                    # address - postal code
                                    s = hAddress[:postalCode]
                                    if !s.nil?
                                        @xml.tag!('gmd:postalCode') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    elsif $showAllTags
                                        @xml.tag!('gmd:postalCode')
                                    end

                                    # address - country
                                    s = hAddress[:country]
                                    if !s.nil?
                                        @xml.tag!('gmd:country') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    elsif $showAllTags
                                        @xml.tag!('gmd:country')
                                    end

                                elsif $showAllTags
                                    @xml.tag!('gmd:deliveryPoint')
                                    @xml.tag!('gmd:city')
                                    @xml.tag!('gmd:administrativeArea')
                                    @xml.tag!('gmd:postalCode')
                                    @xml.tag!('gmd:country')
                                end

                                # address - email addresses
                                if eMails > 0
                                    hAddress[:eMailList].each do |myEmail|
                                        @xml.tag!('gmd:electronicMailAddress') do
                                            @xml.tag!('gco:CharacterString', myEmail)
                                        end
                                    end
                                elsif $showAllTags
                                    @xml.tag!('gmd:electronicMailAddress')
                                end

                            end
                        end
                    end # writeXML
                end # CI_Address

            end
        end
    end
end
