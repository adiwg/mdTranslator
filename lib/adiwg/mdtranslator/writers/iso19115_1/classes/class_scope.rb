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

                  @xml.tag!('gmd:DQ_Scope') do

                     # scope - level (required)
                     s = hScope[:scopeCode]
                     unless s.nil?
                        @xml.tag!('gmd:level') do
                           codelistClass.writeXML('gmd', 'iso_scope', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(280, 'gmd:level', inContext)
                     end

                     # scope - extent [0] {EX_Extent}
                     # ... only one extent allowed in ISO 19115-2
                     aExtents = hScope[:extents]
                     unless aExtents.empty?
                        @xml.tag!('gex:extent') do
                           extentClass.writeXML(aExtents[0])
                        end
                     end
                     if aExtents.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gex:extent')
                     end

                     # scope - level description [{MD_ScopeDescription}]
                     # ... write gmd:levelDescription tag from class_scopeDescription
                     aDescription = hScope[:scopeDescriptions]
                     aDescription.each do |hDescription|
                        descriptionClass.writeXML(hDescription)
                     end
                     if aDescription.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:levelDescription')
                     end

                  end # gmd:MD_Scope tag
               end # writeXML
            end # DQ_Scope class

         end
      end
   end
end
