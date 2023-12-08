# ISO <<abstract class>> coverage description
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-04-05 original script.

require_relative 'class_identifier'
require_relative 'class_attributeGroup'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_CoverageDescription

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end
               
               def writeXML(hCoverage)

                  # classes used
                  identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                  groupClass = MD_AttributeGroup.new(@xml, @hResponseObj)

                  outContext = 'content coverage description'

                  unless hCoverage.empty?
                     @xml.tag!('mrc:MD_CoverageDescription') do

                        # coverage description - attribute description (required)
                        # combine coverageName and coverageDescription
                        attDesc = ''
                        unless hCoverage[:coverageName].nil?
                           attDesc += hCoverage[:coverageName] + '; '
                        end
                        unless hCoverage[:coverageDescription].nil?
                           attDesc += hCoverage[:coverageDescription]
                        end
                        unless attDesc == ''
                           @xml.tag!('mrc:attributeDescription') do
                              @xml.tag!('gco:RecordType', attDesc)
                           end
                        end
                        if attDesc == ''
                           @NameSpace.issueWarning(40, 'gmd:attributeDescription', outContext)
                        end

                        # coverage description - processing level code {MD_Identifier}
                        unless hCoverage[:processingLevelCode].empty?
                           @xml.tag!('mrc:processingLevelCode') do
                              identifierClass.writeXML(hCoverage[:processingLevelCode], outContext+' processing level')
                           end
                           if hCoverage[:processingLevelCode].empty? && @hResponseObj[:writerShowTags]
                              @xml.tag!('mrc:processingLevelCode')
                           end
                        end

                        # coverage description - attribute group [] {MD_AttributeGroup}
                        aGroups = hCoverage[:attributeGroups]
                        aGroups.each do |hGroup|
                           unless hGroup.empty?
                              @xml.tag!('mrc:attributeGroup') do
                                 groupClass.writeXML(hGroup, outContext)
                              end
                           end
                        end
                        if aGroups.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mrc:attributeGroup')
                        end

                     end

                  end # MI_CoverageDescription tag
               end # writeXML
            end # ContentInformation class

         end
      end
   end
end
