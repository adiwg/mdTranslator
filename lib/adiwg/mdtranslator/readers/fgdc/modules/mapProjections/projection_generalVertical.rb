# Reader - fgdc to internal data structure
# unpack fgdc map projection - general vertical near-side perspective projection

# History:
#  Stan Smith 2017-10-16 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module GeneralVerticalProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.6 (gvnsp) - General Vertical Near-sided Perspective
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projection] = 'generalVertical'
                     hProjection[:projectionName] = 'General Vertical Near-sided Perspective'

                     # -> ReferenceSystemParameters.projection.heightOfProspectivePointAboveSurface
                     paramCount += ProjectionCommon.unpackHeightAS(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.longitudeOfProjectionCenter
                     paramCount += ProjectionCommon.unpackLongPC(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionCenter
                     paramCount += ProjectionCommon.unpackLatPC(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     # add distance units
                     # verify parameter count
                     if paramCount == 5
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'general vertical near-side perspective projection is missing one or more parameters'
                        return nil
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
