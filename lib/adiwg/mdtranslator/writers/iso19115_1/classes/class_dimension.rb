# ISO <<Class>> MD_Dimension
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-16 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_codelist'
require_relative 'class_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Dimension

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hDim, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  measureClass = Measure.new(@xml, @hResponseObj)

                  outContext = 'dimension'
                  outContext = inContext + ' dimension' unless inContext.nil?

                  @xml.tag!('msr:MD_Dimension') do

                     # dimension information - dimension type code (required)
                     unless hDim[:dimensionType].nil?
                        @xml.tag!('msr:dimensionName') do
                           codelistClass.writeXML('msr', 'iso_dimensionNameType', hDim[:dimensionType])
                        end
                     end
                     if hDim[:dimensionType].nil?
                        @NameSpace.issueWarning(80, 'msr:dimensionName', inContext)
                     end

                     # dimension information - dimension size (required)
                     unless hDim[:dimensionSize].nil?
                        @xml.tag!('msr:dimensionSize') do
                           @xml.tag!('gco:Integer', hDim[:dimensionSize])
                        end
                     end
                     if hDim[:dimensionSize].nil?
                        @NameSpace.issueWarning(81, 'msr:dimensionSize', inContext)
                     end

                     # dimension information - dimension resolution
                     unless hDim[:resolution].empty?
                        @xml.tag!('msr:resolution') do
                           measureClass.writeXML(hDim[:resolution], outContext)
                        end
                     end
                     if hDim[:resolution].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:resolution')
                     end

                  end # MD_Dimension tag
               end # writeXML
            end # Md_Dimension class

         end
      end
   end
end
