# ISO <<Class>> Measure
# 19115-3 writer output in XML

# History:
#  Stan Smith 2019-03-21 original script.

require_relative '../iso19115_3_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class Measure

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hMeasure, inContext = nil)

                  outContext = 'measure'
                  outContext = inContext + ' measure' unless inContext.nil?

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
                  if type == 'vertical'
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
                     @NameSpace.issueWarning(360, nil, outContext)
                  end

               end # write XML
            end # CI_Telephone class

         end
      end
   end
end
