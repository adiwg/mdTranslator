# ISO <<Class>> EX_VerticalExtent
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-19 original script

require_relative '../iso19115_1_writer'
require_relative 'class_referenceSystem'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class EX_VerticalExtent

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hVertEle)

                  # classes used
                  referenceClass = MD_ReferenceSystem.new(@xml, @hResponseObj)

                  @xml.tag!('gex:EX_VerticalExtent') do

                     # vertical extent - minimum value (required)
                     unless hVertEle[:minValue].nil?
                        @xml.tag!('gex:minimumValue') do
                           @xml.tag!('gco:Real', hVertEle[:minValue])
                        end
                     end
                     if hVertEle[:minValue].nil?
                        @NameSpace.issueWarning(330, 'gex:minimumValue')
                     end

                     # vertical extent - maximum value (required)
                     unless hVertEle[:maxValue].nil?
                        @xml.tag!('gex:maximumValue') do
                           @xml.tag!('gco:Real', hVertEle[:maxValue])
                        end
                     end
                     if hVertEle[:maxValue].nil?
                        @NameSpace.issueWarning(331, 'gex:maximumValue')
                     end

                     # vertical extent - vertical crs ID {MD_ReferenceSystem}
                     unless hVertEle[:crsId].empty?
                        @xml.tag!('gex:verticalCRS') do
                           referenceClass.writeXML(hVertEle[:crsId])
                        end
                     end
                     if hVertEle[:crsId].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gex:verticalCRS')
                     end

                     # vertical extent - vertical crs {many possible classes}
                     # not implemented

                  end # EX_VerticalExtent tag
               end # writeXML
            end # EX_VerticalExtent class

         end
      end
   end
end
