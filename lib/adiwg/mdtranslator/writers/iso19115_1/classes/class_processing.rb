# ISO <<Class>> LE_Processing
# 19115-1 writer output in XML

# History:
# 	Stan Smith 201-09-27 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_identifier'
require_relative 'class_citation'
require_relative 'class_algorithm'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class LE_Processing

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hProcessing, inContext = nil)

                  # classes used
                  identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  algorithmClass = LE_Algorithm.new(@xml, @hResponseObj)

                  outContext = 'processing'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  @xml.tag!('mrl:LE_Processing') do

                     # processing - algorithm [] {LE_Algorithm}
                     aAlgorithms = hProcessing[:algorithms]
                     aAlgorithms.each do |hAlgorithm|
                        @xml.tag!('mrl:algorithm') do
                           algorithmClass.writeXML(hAlgorithm, outContext)
                        end
                     end
                     if aAlgorithms.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:algorithm')
                     end

                     # processing - identifier {MD_Identifier} (required)
                     unless hProcessing[:identifier].empty?
                        hIdentifier = hProcessing[:identifier]
                        unless hIdentifier.empty?
                           @xml.tag!('mrl:identifier') do
                              identifierClass.writeXML(hIdentifier, outContext)
                           end
                        end
                     end
                     if hProcessing[:identifier].nil?
                        @NameSpace.issueWarning(430, 'mrl:identifier', outContext)
                     end

                     # processing - software reference {CI_Citation}
                     hCitation = hProcessing[:softwareReference]
                     unless hCitation.empty?
                        @xml.tag!('mrl:softwareReference') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:softwareReference')
                     end

                     # processing - procedure description
                     unless hProcessing[:procedureDescription].nil?
                        @xml.tag!('mrl:procedureDescription') do
                           @xml.tag!('gco:CharacterString', hProcessing[:procedureDescription])
                        end
                     end
                     if hProcessing[:procedureDescription].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:procedureDescription')
                     end

                     # processing - documentation [] {CI_Citation}
                     aCitations = hProcessing[:documentation]
                     aCitations.each do |hCitation|
                        @xml.tag!('mrl:documentation') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if aCitations.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:documentation')
                     end

                     # processing - runtime parameters
                     unless hProcessing[:runtimeParameters].nil?
                        @xml.tag!('mrl:runTimeParameters') do
                           @xml.tag!('gco:CharacterString', hProcessing[:runtimeParameters])
                        end
                     end
                     if hProcessing[:runtimeParameters].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:runTimeParameters')
                     end

                  end # mrl:LE_ProcessStepReport
               end # writeXML
            end # LE_ProcessStepReport class

         end
      end
   end
end
