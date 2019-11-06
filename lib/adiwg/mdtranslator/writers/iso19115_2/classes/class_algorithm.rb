# ISO <<Class>> LE_Algorithm
# 19115-2 writer output in XML

# History:
# 	Stan Smith 201-09-25 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class LE_Algorithm

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hAlgorithm, inContext = nil)

                  # classes used
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  outContext = 'algorithm'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  @xml.tag!('gmi:LE_Algorithm') do

                     # algorithm - citation {CI_Citation} (required)
                     hCitation = hAlgorithm[:citation]
                     unless hCitation.empty?
                        @xml.tag!('gmi:citation') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if hCitation.empty?
                        @NameSpace.issueWarning(390, 'gmi:citation', outContext)
                     end

                     # algorithm - description (required)
                     unless hAlgorithm[:description].nil?
                        @xml.tag!('gmi:description') do
                           @xml.tag!('gco:CharacterString', hAlgorithm[:description])
                        end
                     end
                     if hAlgorithm[:description].nil?
                        @NameSpace.issueWarning(391, 'gmi:description', outContext)
                     end

                  end # gmi:LE_Algorithm tag
               end # writeXML
            end # LE_Algorithm class

         end
      end
   end
end
