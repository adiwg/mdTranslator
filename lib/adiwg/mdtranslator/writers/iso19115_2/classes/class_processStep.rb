# ISO <<Abstract>> ProcessStep
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2019-09-25 original script.

require_relative 'class_liProcessStep'
require_relative 'class_leProcessStep'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class ProcessStep

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hProcess, inContext = nil)

                  # classes used
                  liProcessClass = LI_ProcessStep.new(@xml, @hResponseObj)
                  leProcessClass = LE_ProcessStep.new(@xml, @hResponseObj)

                  outContext = inContext

                  # use LE_ProcessStep if hProcess has any ...
                  # processingInformation, reports
                  # stepProducts (output)

                  useLE = false
                  useLE = true unless hProcess[:processingInformation].empty?
                  useLE = true unless hProcess[:reports].empty?
                  useLE = true unless hProcess[:stepProducts].empty?

                  if useLE
                     leProcessClass.writeXML(hProcess, outContext)
                  else
                     liProcessClass.writeXML(hProcess, outContext)
                  end

               end # writeXML
            end # processStep class

         end
      end
   end
end
