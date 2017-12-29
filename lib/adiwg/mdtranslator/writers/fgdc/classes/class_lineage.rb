# FGDC <<Class>> Lineage
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-12-15 original script

require_relative 'class_method'
require_relative 'class_source'
require_relative 'class_process'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Lineage

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aLineage)

                  # take only the first lineage description
                  hLineage = aLineage[0]
                  aSourceCollection = []
                  haveStep = false

                  # classes used
                  methodClass = Method.new(@xml, @hResponseObj)
                  sourceClass = Source.new(@xml, @hResponseObj)
                  processClass = Process.new(@xml, @hResponseObj)

                  # lineage bio (method) - methodology
                  methodClass.writeXML(hLineage)

                  # lineage 2.5.1 (srcinfo) - source information []
                  # <- lineage.source
                  hLineage[:dataSources].each do |hSource|
                     sourceClass.writeXML(hSource, aSourceCollection)
                  end

                  # lineage 2.5.1 (srcinfo) - source information from source process steps []
                  # <- lineage.processSteps.stepSources/stepProducts
                  hLineage[:processSteps].each do |hProcess|
                     hProcess[:stepSources].each do |hStepSource|
                        sourceClass.writeXML(hStepSource, aSourceCollection)
                     end
                     hProcess[:stepProducts].each do |hStepProduct|
                        sourceClass.writeXML(hStepProduct, aSourceCollection)
                     end
                  end

                  # the search for sources is circular, I'm stopping here.

                  if  aSourceCollection.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('srcinfo')
                  end

                  # lineage 2.5.2 (procstep) - process step (required)
                  hLineage[:processSteps].each do |hStep|
                     @xml.tag!('procstep') do
                        processClass.writeXML(hStep)
                        haveStep = true
                     end
                  end

                  # lineage 2.5.2 (procstep) - process steps from source (required)
                  hLineage[:dataSources].each do |hSource|
                     hSource[:sourceSteps].each do |hStep|
                        @xml.tag!('procstep') do
                           processClass.writeXML(hStep)
                           haveStep = true
                        end
                     end
                  end
                  unless haveStep
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Lineage Source is missing process steps'
                  end

                  # the search for process steps is circular, I'm stopping here.

               end # writeXML
            end # lineage

         end
      end
   end
end
