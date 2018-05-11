# ISO <<Class>> MD_GridSpatialRepresentation
# writer output in XML

# History:
# 	Stan Smith 2015-07-30 original script.

require_relative 'class_grid'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_GridSpatialRepresentation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGrid)

                  # classes used
                  gridClass = Grid.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_GridSpatialRepresentation') do
                     gridClass.writeXML(hGrid, 'grid representation')
                  end

               end # writeXML
            end # MD_GridRepresentation class

         end
      end
   end
end
