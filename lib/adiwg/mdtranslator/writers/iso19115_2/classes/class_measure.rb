# ISO <<Class>> Measure
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-19 add error and warning messaging
#  Stan Smith 2016-11-22 original script.

require_relative '../iso19115_2_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class Measure

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hMeasure, inContext = nil)

                  # measure
                  type = hMeasure[:type]
                  value = hMeasure[:value]
                  uom = hMeasure[:unitOfMeasure]

                  # ISO 19115-2 will not accept spaces in uom
                  uom.gsub!(/\s+/, '')

                  haveType = false
                  if type == 'distance'
                     @xml.tag!('gco:Distance', {'uom' => uom}, value)
                     haveType = true
                  end
                  if type == 'length'
                     @xml.tag!('gco:Length', {'uom' => uom}, value)
                     haveType = true
                  end
                  if type == 'angle'
                     @xml.tag!('gco:Angle', {'uom' => uom}, value)
                     haveType = true
                  end
                  if type == 'measure'
                     @xml.tag!('gco:Measure', {'uom' => uom}, value)
                     haveType = true
                  end
                  if type == 'scale'
                     @xml.tag!('gco:Scale', {'uom' => uom}, value)
                     haveType = true
                  end

                  unless haveType
                     @NameSpace.issueWarning(360, nil, inContext)
                  end

               end # write XML
            end # CI_Telephone class

         end
      end
   end
end
