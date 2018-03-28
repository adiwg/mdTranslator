# FGDC <<Class>> Address
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2017-11-27 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Address

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hAddress, inContext = nil)

                  # contact 10.4 (cntaddr) - address information

                  # contact 10.4.1 (addrtype) - address type (required)
                  # <- hAddress[:addressTypes][0]
                  unless hAddress[:addressTypes].empty?
                     @xml.tag!('addrtype', hAddress[:addressTypes][0])
                  end
                  if hAddress[:addressTypes].empty?
                     @NameSpace.issueWarning(1, 'addrtype', inContext)
                  end

                  # contact 10.4.2 (address) - address lines
                  # <- hAddress[:deliveryPoints]
                  hAddress[:deliveryPoints].each do |addLine|
                     @xml.tag!('address', addLine)
                  end
                  if hAddress[:deliveryPoints].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('address')
                  end

                  # contact 10.4.3 (city) - city (required)
                  # <- hAddress[:city]
                  unless hAddress[:city].nil?
                     @xml.tag!('city', hAddress[:city])
                  end
                  if hAddress[:city].nil?
                     @NameSpace.issueWarning(2, 'city', inContext)
                  end

                  # contact 10.4.4 (state) - state (required)
                  # <- hAddress[:adminArea]
                  unless hAddress[:adminArea].nil?
                     @xml.tag!('state', hAddress[:adminArea])
                  end
                  if hAddress[:adminArea].nil?
                     @NameSpace.issueWarning(3, 'state', inContext)
                  end

                  # contact 10.4.5 (postal) - postal code (required)
                  # <- hAddress[:postalCode]
                  unless hAddress[:postalCode].nil?
                     @xml.tag!('postal', hAddress[:postalCode])
                  end
                  if hAddress[:postalCode].nil?
                     @NameSpace.issueWarning(4, 'postal', inContext)
                  end

                  # contact 10.4.6 (country) - country
                  # <- hAddress[:country]
                  unless hAddress[:country].nil?
                     @xml.tag!('country', hAddress[:country])
                  end
                  if hAddress[:country].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('country')
                  end

               end # writeXML
            end # Address

         end
      end
   end
end
