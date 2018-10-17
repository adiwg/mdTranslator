# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2018-10-04 refactor mdJson projection object
#  Stan Smith 2017-10-04 original script

require 'nokogiri'
require_relative 'gridSystems/grid_utm'
require_relative 'gridSystems/grid_ups'
require_relative 'gridSystems/grid_statePlane'
require_relative 'gridSystems/grid_equalArcSecond'
require_relative 'gridSystems/grid_other'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapGridSystem

               def self.unpack(xMapGrid, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hProjection = intMetadataClass.newProjection
                  hGridSystemId = intMetadataClass.newIdentifier
                  hProjectionId = intMetadataClass.newIdentifier
                  hProjection[:gridSystemIdentifier] = hGridSystemId
                  hProjection[:projectionIdentifier] = hProjectionId

                  # grid system 4.1.2.2.1 (gridsysn) - grid coordinate system name (required)
                  # -> ReferenceSystemParameters.projection.projectionIdentifier.identifier
                  gridName = xMapGrid.xpath('./gridsysn').text
                  unless gridName.empty?
                     hGridSystemId[:name] = gridName
                  end
                  if gridName.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: grid system name is missing'
                  end

                  # grid system 4.1.2.2.2 (utm) - universal transverse mercator
                  xUTM = xMapGrid.xpath('./utm')
                  unless xUTM.empty?
                     return MapGridUtm.unpack(xUTM, hProjection, hResponseObj)
                  end

                  # grid system 4.1.2.2.3 (ups) - universal polar stereographic
                  xUPS = xMapGrid.xpath('./ups')
                  unless xUPS.empty?
                     return MapGridUps.unpack(xUPS, hProjection, hResponseObj)
                  end

                  # grid system 4.1.2.2.4 (spcs) - state plane coordinate system
                  xStateP = xMapGrid.xpath('./spcs')
                  unless xStateP.empty?
                     return MapGridStatePlane.unpack(xStateP, hProjection, hResponseObj)
                  end

                  # grid system 4.1.2.2.5 (arcsys) - equal arc-second coordinate system
                  xArc = xMapGrid.xpath('./arcsys')
                  unless xArc.empty?
                     return MapGridEqualArcSecond.unpack(xArc, hProjection, hResponseObj)
                  end

                  # grid system 4.1.2.2.6 (othergrd) - other coordinate system {text}
                  # -> ReferenceSystemParameters.projection.gridSystemIdentifier.description
                  otherG = xMapGrid.xpath('./othergrd').text
                  unless otherG.empty?
                     return MapGridOther.unpack(otherG, hProjection)
                  end

                  # error message
                  hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: grid system is missing'

                  return hProjection

               end

            end

         end
      end
   end
end
