# Reader - fgdc to internal data structure
# unpack fgdc map projection - modified stereographic for alaska

# History:
#  Stan Smith 2017-10-16 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module ModifiedAlaskaProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.11 (modsak) - Modified Stereographic for Alaska
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projectionName] = 'alaska modified stereographic'

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     # verify parameter count
                     if paramCount == 2
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'alaska modified stereographic projection is missing one or more parameters'
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
