# ISO <<Class>> LI_Lineage
# 19115-3 writer output in XML

# History:
#  Stan Smith 2019-09-25 add support for LE_Source and LE_ProcessStep
# 	Stan Smith 2019-04-10 original script.

require_relative 'class_scope'
require_relative 'class_citation'
require_relative 'class_processStep'
require_relative 'class_source'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class LI_Lineage

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hLineage, inContext = nil)

                  # classes used
                  scopeClass = MD_Scope.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  sourceClass = Source.new(@xml, @hResponseObj)
                  processClass = ProcessStep.new(@xml, @hResponseObj)

                  outContext = 'resource lineage'
                  outContext = inContext + ' resource lineage' unless inContext.nil?

                  @xml.tag!('mrl:LI_Lineage') do

                     # lineage - statement
                     unless hLineage[:statement].nil?
                        @xml.tag!('mrl:statement') do
                           @xml.tag!('gco:CharacterString', hLineage[:statement])
                        end
                     end
                     if hLineage[:statement].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:statement')
                     end

                     # lineage - scope {MD_Scope}
                     unless hLineage[:resourceScope].empty?
                        @xml.tag!('mrl:scope') do
                           scopeClass.writeXML(hLineage[:resourceScope], outContext)
                        end
                     end
                     if hLineage[:resourceScope].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:scope')
                     end

                     # lineage - additional documentation [] {CI_Citation}
                     aDocuments = hLineage[:lineageCitation]
                     aDocuments.each do |hDocument|
                        @xml.tag!('mrl:additionalDocumentation') do
                           citationClass.writeXML(hDocument)
                        end
                     end
                     if aDocuments.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:additionalDocumentation')
                     end

                     # lineage - source [] {Source}
                     aSources = hLineage[:dataSources]
                     aSources.each do |hSource|
                        @xml.tag!('mrl:source') do
                           sourceClass.writeXML(hSource, outContext)
                        end
                     end
                     if aSources.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:source')
                     end

                     # lineage - process step [] {ProcessStep}
                     aSteps = hLineage[:processSteps]
                     aSteps.each do |pStep|
                        @xml.tag!('mrl:processStep') do
                           processClass.writeXML(pStep, outContext)
                        end
                     end
                     if aSteps.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:processStep')
                     end

                  end # mrl:LI_Lineage tag
               end # writeXML
            end # LI_Lineage class

         end
      end
   end
end
