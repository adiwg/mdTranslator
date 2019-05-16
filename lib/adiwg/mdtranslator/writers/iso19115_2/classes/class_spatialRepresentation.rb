# ISO <<Class>> MD_GridSpatialRepresentation
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-14 original script

require_relative 'class_gridRepresentation'
require_relative 'class_vectorRepresentation'
require_relative 'class_georectified'
require_relative 'class_georeferenceable'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class SpatialRepresentation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hRepresentation)

                  # classes used
                  gridClass = MD_GridSpatialRepresentation.new(@xml, @hResponseObj)
                  vectorClass = MD_VectorSpatialRepresentation.new(@xml, @hResponseObj)
                  rectifiedClass = MD_Georectified.new(@xml, @hResponseObj)
                  referenceClass = MD_Georeferenceable.new(@xml, @hResponseObj)

                  # spatial representation - grid
                  unless hRepresentation[:gridRepresentation].empty?
                     gridClass.writeXML(hRepresentation[:gridRepresentation])
                  end

                  # spatial representation - vector
                  unless hRepresentation[:vectorRepresentation].empty?
                     vectorClass.writeXML(hRepresentation[:vectorRepresentation])
                  end

                  # spatial representation - georectified
                  unless hRepresentation[:georectifiedRepresentation].empty?
                     rectifiedClass.writeXML(hRepresentation[:georectifiedRepresentation])
                  end

                  # spatial representation - georeferenceable
                  unless hRepresentation[:georeferenceableRepresentation].empty?
                     referenceClass.writeXML(hRepresentation[:georeferenceableRepresentation])
                  end

               end # writeXML
            end # SpatialRepresentation class

         end
      end
   end
end
