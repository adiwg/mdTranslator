# ISO <<Class>> CI_Series
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-14 original script

require_relative 'class_grid'
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
                        gridClass = Grid.new(@xml, @hResponseObj)
                        vectorClass = MD_VectorSpatialRepresentation.new(@xml, @hResponseObj)
                        rectifiedClass = MD_Georectified.new(@xml, @hResponseObj)
                        referenceClass = MD_Georeferenceable.new(@xml, @hResponseObj)

                        type = hRepresentation[:type]

                        # spatial representation - grid
                        # write MD_GridSpatialRepresentation here
                        # ... it is not written in the Grid class since the
                        # ... Grid attributes are also written into georectified
                        # ... and georeferenceable classes
                        if type == 'grid'
                            @xml.tag!('gmd:MD_GridSpatialRepresentation') do
                                gridClass.writeXML(hRepresentation)
                            end
                        end

                        # spatial representation - vector
                        if type == 'vector'
                            vectorClass.writeXML(hRepresentation)
                        end

                        # spatial representation - georectified
                        if type == 'georectified'
                            rectifiedClass.writeXML(hRepresentation)
                        end

                        # spatial representation - georeferenceable
                        if type == 'georeferenceable'
                            referenceClass.writeXML(hRepresentation)
                        end

                    end # writeXML
                end # SpatialRepresentation class

            end
        end
    end
end
