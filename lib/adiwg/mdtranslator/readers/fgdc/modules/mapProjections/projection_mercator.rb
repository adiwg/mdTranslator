# Reader - fgdc to internal data structure
# unpack fgdc map projection - mercator

# History:
#  Stan Smith 2018-10-03 refactor mdJson projection object
#  Stan Smith 2017-10-16 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MercatorProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.10 (mercator) - Mercator
                  # -> ReferenceSystemParameters.projection.[ standardParallel1 | scaleFactorAtEquator ]
                  unless xParams.empty?
                     paramCount = 0

                     # -> ReferenceSystemParameters.projection.standardParallel1
                     # -> ReferenceSystemParameters.projection.standardParallel2
                     paramCount += ProjectionCommon.unpackStandParallel(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtEquator
                     paramCount += ProjectionCommon.unpackSFEquator(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     paramCount += ProjectionCommon.unpackLongCM(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection)

                     # verify parameter count
                     if paramCount == 4
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] <<
                           'WARNING: Mercator projection is missing one or more parameters'
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
