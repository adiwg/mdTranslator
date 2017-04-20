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

                        # spatial representation - grid
                        # write MD_GridSpatialRepresentation tag here
                        # ... it is not written in the Grid class since the
                        # ... Grid attributes are also written into georectified
                        # ... and georeferenceable classes
                        unless hRepresentation[:gridRepresentation].empty?
                            @xml.tag!('gmd:MD_GridSpatialRepresentation') do
                                gridClass.writeXML(hRepresentation[:gridRepresentation])
                            end
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
