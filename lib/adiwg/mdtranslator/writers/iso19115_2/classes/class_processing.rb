# ISO <<Class>> LE_Processing
# 19115-2 writer output in XML

# History:
# 	Stan Smith 201-09-25 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_rsIdentifier'
require_relative 'class_citation'
require_relative 'class_algorithm'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class LE_Processing

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hProcessing, inContext = nil)

                  # classes used
                  identifierClass = RS_Identifier.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  algorithmClass = LE_Algorithm.new(@xml, @hResponseObj)

                  outContext = 'processing'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  @xml.tag!('gmi:LE_Processing') do

                     # processing - identifier {RS_Identifier} (required)
                     unless hProcessing[:identifier].empty?
                        hIdentifier = hProcessing[:identifier]
                        unless hIdentifier.empty?
                           @xml.tag!('gmi:identifier') do
                              identifierClass.writeXML(hIdentifier, outContext)
                           end
                        end
                     end
                     if hProcessing[:identifier].nil?
                        @NameSpace.issueWarning(420, 'gmi:identifier', outContext)
                     end

                     # processing - software reference {CI_Citation}
                     hCitation = hProcessing[:softwareReference]
                     unless hCitation.empty?
                        @xml.tag!('gmi:softwareReference') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:softwareReference')
                     end

                     # processing - procedure description
                     unless hProcessing[:procedureDescription].nil?
                        @xml.tag!('gmi:procedureDescription') do
                           @xml.tag!('gco:CharacterString', hProcessing[:procedureDescription])
                        end
                     end
                     if hProcessing[:procedureDescription].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:procedureDescription')
                     end

                     # processing - documentation [] {CI_Citation}
                     aCitations = hProcessing[:documentation]
                     aCitations.each do |hCitation|
                        @xml.tag!('gmi:documentation') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if aCitations.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:documentation')
                     end

                     # processing - runtime parameters
                     unless hProcessing[:runtimeParameters].nil?
                        @xml.tag!('gmi:runTimeParameters') do
                           @xml.tag!('gco:CharacterString', hProcessing[:runtimeParameters])
                        end
                     end
                     if hProcessing[:runtimeParameters].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:runTimeParameters')
                     end

                     # processing - algorithm [] {LE_Algorithm}
                     aAlgorithms = hProcessing[:algorithms]
                     aAlgorithms.each do |hAlgorithm|
                        @xml.tag!('gmi:algorithm') do
                           algorithmClass.writeXML(hAlgorithm, outContext)
                        end
                     end
                     if aAlgorithms.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:algorithm')
                     end

                  end # gmi:LE_ProcessStepReport
               end # writeXML
            end # LE_ProcessStepReport class

         end
      end
   end
end
