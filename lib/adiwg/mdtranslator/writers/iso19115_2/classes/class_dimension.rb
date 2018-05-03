# ISO <<Class>> MD_Dimension
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-11-23 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-07-30 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Dimension

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hDim, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  measureClass = Measure.new(@xml, @hResponseObj)

                  outContext = 'dimension'
                  outContext = inContext + ' dimension' unless inContext.nil?

                  @xml.tag!('gmd:MD_Dimension') do

                     # dimension information - dimension type code (required)
                     s = hDim[:dimensionType]
                     unless s.nil?
                        @xml.tag!('gmd:dimensionName') do
                           codelistClass.writeXML('gmd', 'iso_dimensionNameType', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(80, 'gmd:dimensionName', inContext)
                     end

                     # dimension information - dimension size (required)
                     s = hDim[:dimensionSize]
                     unless s.nil?
                        @xml.tag!('gmd:dimensionSize') do
                           @xml.tag!('gco:Integer', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(81, 'gmd:dimensionSize', inContext)
                     end

                     # dimension information - dimension resolution
                     hMeasure = hDim[:resolution]
                     unless hMeasure.empty?
                        @xml.tag!('gmd:resolution') do
                           measureClass.writeXML(hMeasure, outContext)
                        end
                     end
                     if hMeasure.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:resolution')
                     end

                  end # MD_Dimension tag
               end # writeXML
            end # Md_Dimension class

         end
      end
   end
end
