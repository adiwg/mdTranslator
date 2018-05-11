# ISO <<Class>> LI_Lineage
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-20 original script.

require_relative 'class_processStep'
require_relative 'class_source'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class LI_Lineage

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hLineage)

                  # classes used
                  sourceClass = LI_Source.new(@xml, @hResponseObj)
                  pStepClass = LI_ProcessStep.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:LI_Lineage') do

                     # lineage - statement
                     s = hLineage[:statement]
                     unless s.nil?
                        @xml.tag!('gmd:statement') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:statement')
                     end

                     # lineage - process step [{LI_ProcessStep}]
                     aProcSteps = hLineage[:processSteps]
                     aProcSteps.each do |pStep|
                        @xml.tag!('gmd:processStep') do
                           pStepClass.writeXML(pStep)
                        end
                     end
                     if aProcSteps.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:processStep')
                     end

                     # lineage - source [{LI_Source}]
                     aSources = hLineage[:dataSources]
                     aSources.each do |hSource|
                        @xml.tag!('gmd:source') do
                           sourceClass.writeXML(hSource)
                        end
                     end
                     if aSources.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:source')
                     end

                  end # gmd:LI_Lineage tag
               end # writeXML
            end # LI_Lineage class

         end
      end
   end
end
