# ISO <<Abstract>> Source
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2019-09-25 original script.

require_relative 'class_liSource'
require_relative 'class_leSource'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class Source

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hSource, inContext = nil)

                  # classes used
                  liSourceClass = LI_Source.new(@xml, @hResponseObj)
                  leSourceClass = LE_Source.new(@xml, @hResponseObj)

                  outContext = inContext

                  # use LE_Source if hSource has any ...
                  # processedLevel, resolution

                  useLE = false
                  useLE = true unless hSource[:processedLevel].empty?
                  useLE = true unless hSource[:resolution].empty?

                  if useLE
                     leSourceClass.writeXML(hSource, outContext)
                  else
                     liSourceClass.writeXML(hSource, outContext)
                  end

               end # writeXML
            end # Source class

         end
      end
   end
end
