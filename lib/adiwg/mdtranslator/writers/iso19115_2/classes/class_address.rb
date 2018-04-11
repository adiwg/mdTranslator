# ISO <<Class>> CI_Address
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-11-18 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-23 refactored to drop physical address elements if no
#  ... deliveryPoints are provided
#  Stan Smith 2014-12-22 added return if passed nil address objects
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-08-09 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class CI_Address

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hAddress, aEmail)

                  @xml.tag!('gmd:CI_Address') do


                     unless hAddress.nil?

                        # address - address type (not used by ISO 19115-2)

                        # address - description (not used by ISO 19115-2)

                        # address - delivery points []
                        aDeliveryPoints = hAddress[:deliveryPoints]
                        aDeliveryPoints.each do |myPoint|
                           @xml.tag!('gmd:deliveryPoint') do
                              @xml.tag!('gco:CharacterString', myPoint)
                           end
                        end
                        if aDeliveryPoints.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:deliveryPoint')
                        end

                        # address - city
                        s = hAddress[:city]
                        unless s.nil?
                           @xml.tag!('gmd:city') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:city')
                        end

                        # address - administrative area
                        s = hAddress[:adminArea]
                        unless s.nil?
                           @xml.tag!('gmd:administrativeArea') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:administrativeArea')
                        end

                        # address - postal code
                        s = hAddress[:postalCode]
                        unless s.nil?
                           @xml.tag!('gmd:postalCode') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:postalCode')
                        end

                        # address - country
                        s = hAddress[:country]
                        unless s.nil?
                           @xml.tag!('gmd:country') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:country')
                        end

                     end

                     # address - email addresses []
                     aEmail.each do |myEmail|
                        @xml.tag!('gmd:electronicMailAddress') do
                           @xml.tag!('gco:CharacterString', myEmail)
                        end
                     end
                     if aEmail.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:electronicMailAddress')
                     end

                  end # CI_Address tag
               end # writeXML
            end # CI_Address class

         end
      end
   end
end
