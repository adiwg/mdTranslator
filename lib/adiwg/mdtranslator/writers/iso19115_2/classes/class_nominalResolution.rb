# ISO <<Class>> LE_NominalResolution
# 19115-2 writer output in XML

# History:
# 	Stan Smith 201-09-25 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class LE_NominalResolution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hResolution, inContext = nil)

                  # classes used
                  measureClass = Measure.new(@xml, @hResponseObj)

                  outContext = 'resolution'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  @xml.tag!('gmi:LE_NominalResolution') do

                     haveResolution = false

                     # resolution - scanning resolution {Measure} (required if)
                     unless hResolution[:scanningResolution].empty?
                        @xml.tag!('gmi:scanningResolution') do
                           measureClass.writeXML(hResolution[:scanningResolution], outContext)
                           haveResolution = true
                        end
                     end

                     unless hResolution[:groundResolution].empty?
                        @xml.tag!('gmi:groundResolution') do
                           measureClass.writeXML(hResolution[:groundResolution], outContext)
                           haveResolution = true
                        end
                     end

                     unless haveResolution
                        @NameSpace.issueWarning(400, 'gmi:scanningResolution', outContext)
                     end

                  end # gmi:LE_NominalResolution
               end # writeXML
            end # LE_NominalResolution class

         end
      end
   end
end
