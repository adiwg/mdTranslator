# ISO <<Class>> CI_Series
# 19115-1 writer output in XML

# History:
#  Stan Smith 2019-04-16 original script

require_relative 'class_gridRepresentation'
require_relative 'class_vectorRepresentation'
require_relative 'class_georectified'
require_relative 'class_georeferenceable'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class SpatialRepresentation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hRepresentation, inContext = nil)

                  # classes used
                  gridClass = MD_GridSpatialRepresentation.new(@xml, @hResponseObj)
                  vectorClass = MD_VectorSpatialRepresentation.new(@xml, @hResponseObj)
                  rectifiedClass = MD_Georectified.new(@xml, @hResponseObj)
                  referenceClass = MD_Georeferenceable.new(@xml, @hResponseObj)

                  outContext = 'spatial representation'
                  outContext = inContext + ' spatial representation' unless inContext.nil?

                  # spatial representation - grid
                  unless hRepresentation[:gridRepresentation].empty?
                     gridClass.writeXML(hRepresentation[:gridRepresentation], outContext)
                  end

                  # spatial representation - vector
                  unless hRepresentation[:vectorRepresentation].empty?
                     vectorClass.writeXML(hRepresentation[:vectorRepresentation], outContext)
                  end

                  # spatial representation - georectified
                  unless hRepresentation[:georectifiedRepresentation].empty?
                     rectifiedClass.writeXML(hRepresentation[:georectifiedRepresentation], outContext)
                  end

                  # spatial representation - georeferenceable
                  unless hRepresentation[:georeferenceableRepresentation].empty?
                     referenceClass.writeXML(hRepresentation[:georeferenceableRepresentation], outContext)
                  end

               end # writeXML
            end # SpatialRepresentation class

         end
      end
   end
end
