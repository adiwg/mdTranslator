# Reader - fgdc to internal data structure
# unpack fgdc map projection - orthographic

# History:
#  Stan Smith 2018-10-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module ProjectionOther

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.14 (orthogr) - Orthographic
                  unless xParams.empty?
                     paramCount = 0

                     # -> ReferenceSystemParameters.projection.projectionIdentifier.description
                     paramCount += ProjectionCommon.unpackOtherProjection(xParams, hProjection)

                     # verify parameter count
                     if paramCount == 1
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] <<
                           'WARNING: FGDC reader: other projection description is missing'
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
