# ISO <<Class>> LE_NominalResolution
# 19115-3 writer output in XML

# History:
# 	Stan Smith 201-09-27 original script.

require_relative '../iso19115_3_writer'
require_relative 'class_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class LE_NominalResolution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hResolution, inContext = nil)

                  # classes used
                  measureClass = Measure.new(@xml, @hResponseObj)

                  outContext = 'resolution'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  @xml.tag!('mrl:LE_NominalResolution') do

                     haveResolution = false

                     # resolution - scanning resolution {Measure} (required if)
                     unless hResolution[:scanningResolution].empty?
                        @xml.tag!('mrl:scanningResolution') do
                           measureClass.writeXML(hResolution[:scanningResolution], outContext)
                           haveResolution = true
                        end
                     end

                     unless hResolution[:groundResolution].empty?
                        @xml.tag!('mrl:groundResolution') do
                           measureClass.writeXML(hResolution[:groundResolution], outContext)
                           haveResolution = true
                        end
                     end

                     unless haveResolution
                        @NameSpace.issueWarning(450, 'mrl:scanningResolution', outContext)
                     end

                  end # mrl:LE_NominalResolution
               end # writeXML
            end # LE_NominalResolution class

         end
      end
   end
end
