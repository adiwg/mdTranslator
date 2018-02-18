# Reader - fgdc to internal data structure
# unpack fgdc map projection - van der grinten

# History:
#  Stan Smith 2017-10-18 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module VanDerGrintenProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.22 (vdgrin) - van der Grinten
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projection] = 'grinten'
                     hProjection[:projectionName] = 'van der Grinten'

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     paramCount += ProjectionCommon.unpackLongCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     if paramCount == 3
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC Van Der Grinten projection is missing one or more parameters'
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
