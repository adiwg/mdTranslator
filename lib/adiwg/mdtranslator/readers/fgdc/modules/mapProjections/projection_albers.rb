# Reader - fgdc to internal data structure
# unpack fgdc map projection - albers

# History:
#  Stan Smith 2017-10-04 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module AlbersProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.2 (albers) - Albers Conical Equal Area
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projectionName] = 'albers'

                     # -> ReferenceSystemParameters.projection.standardParallel1
                     # -> ReferenceSystemParameters.projection.standardParallel2
                     paramCount += ProjectionCommon.unpackStandParallel(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     paramCount += ProjectionCommon.unpackLongCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionOrigin
                     paramCount += ProjectionCommon.unpackLatPO(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     # verify parameter count
                     if paramCount == 6
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'albers projection is missing one or more parameters'
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
