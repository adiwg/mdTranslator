# ISO <<Class>> MD_Scope
# 19115-1 writer output in XML

# History:
#  Stan Smith 2019-03-18 original script

require_relative '../iso19115_1_writer'
require_relative 'class_codelist'
require_relative 'class_extent'
require_relative 'class_scopeDescription'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Scope

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hScope, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  extentClass = EX_Extent.new(@xml, @hResponseObj)
                  descriptionClass = MD_ScopeDescription.new(@xml, @hResponseObj)

                  outContext = 'scope'
                  outContext = inContext + ' scope' unless inContext.nil?

                  @xml.tag!('mcc:DQ_Scope') do

                     # scope - level (required)
                     unless hScope[:scopeCode].nil?
                        @xml.tag!('mcc:level') do
                           codelistClass.writeXML('mcc', 'iso_scope', hScope[:scopeCode])
                        end
                     end
                     if hScope[:scopeCode].nil?
                        @NameSpace.issueWarning(280, 'mcc:level', inContext)
                     end

                     # scope - extent [] {EX_Extent}
                     aExtents = hScope[:extents]
                     aExtents.each do |hExtent|
                        @xml.tag!('mcc:extent') do
                           extentClass.writeXML(hExtent, outContext)
                        end
                     end
                     if aExtents.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:extent')
                     end

                     # scope - level description [{MD_ScopeDescription}]
                     # ... write mcc:levelDescription tag from class_scopeDescription
                     aDescription = hScope[:scopeDescriptions]
                     aDescription.each do |hDescription|
                        descriptionClass.writeXML(hDescription)
                     end
                     if aDescription.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:levelDescription')
                     end

                  end # mcc:MD_Scope tag
               end # writeXML
            end # DQ_Scope class

         end
      end
   end
end
