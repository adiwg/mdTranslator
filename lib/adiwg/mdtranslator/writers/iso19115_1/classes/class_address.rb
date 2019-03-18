# ISO <<Class>> CI_Address
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-18 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class CI_Address

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hAddress)
                  
                  @xml.tag!('cit:CI_Address') do


                     unless hAddress.nil?

                        # address - address type (not used by ISO 19115-1)

                        # address - description (not used by ISO 19115-1)

                        # address - delivery points []
                        aDeliveryPoints = hAddress[:deliveryPoints]
                        aDeliveryPoints.each do |myPoint|
                           @xml.tag!('cit:deliveryPoint') do
                              @xml.tag!('gco:CharacterString', myPoint)
                           end
                        end
                        if aDeliveryPoints.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:deliveryPoint')
                        end

                        # address - city
                        s = hAddress[:city]
                        unless s.nil?
                           @xml.tag!('cit:city') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:city')
                        end

                        # address - administrative area
                        s = hAddress[:adminArea]
                        unless s.nil?
                           @xml.tag!('cit:administrativeArea') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:administrativeArea')
                        end

                        # address - postal code
                        s = hAddress[:postalCode]
                        unless s.nil?
                           @xml.tag!('cit:postalCode') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:postalCode')
                        end

                        # address - country
                        s = hAddress[:country]
                        unless s.nil?
                           @xml.tag!('cit:country') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:country')
                        end

                     end

                  end # CI_Address tag
               end # writeXML
            end # CI_Address class

         end
      end
   end
end
