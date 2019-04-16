# ISO <<Class>> MD_GridSpatialRepresentation
# writer output in XML

# History:
# 	Stan Smith 2019-04-16 original script.

require_relative 'class_grid'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_GridSpatialRepresentation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGrid, inContext = nil)

                  # classes used
                  gridClass = Grid.new(@xml, @hResponseObj)

                  @xml.tag!('msr:MD_GridSpatialRepresentation') do
                     gridClass.writeXML(hGrid, 'grid representation')
                  end

               end # writeXML
            end # MD_GridRepresentation class

         end
      end
   end
end
