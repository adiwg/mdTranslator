# Reader - fgdc to internal data structure
# unpack fgdc horizontal data geodetic reference

# History:
#  Stan Smith 2017-12-29 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module GeodeticReference

               def self.unpack(xHorizontalRef, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  hGeodetic = intMetadataClass.newGeodetic
                  xGeodetic = xHorizontalRef.xpath('./geodetic')

                  # geodetic model 4.1.4.1 (horizdn) - horizontal datum name
                  # -> referenceSystemParameters.geodetic.datumName
                  datumName = xGeodetic.xpath('./horizdn').text
                  unless datumName.empty?
                     hGeodetic[:datumName] = datumName
                  end

                  # geodetic model 4.1.4.2 (ellips) - ellipsoid name (required)
                  # -> referenceSystemParameters.geodetic.ellipsoidName
                  ellipsoidName = xGeodetic.xpath('./ellips').text
                  unless ellipsoidName.empty?
                     hGeodetic[:ellipsoidName] = ellipsoidName
                  end
                  if ellipsoidName.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: geodetic reference ellipsoid name is missing'
                  end

                  # geodetic model 4.1.4.3 (semiaxis) - semi-major axis (required)
                  # -> referenceSystemParameters.geodetic.semiMajorAxis
                  semiAxis = xGeodetic.xpath('./semiaxis').text
                  unless semiAxis.empty?
                     hGeodetic[:semiMajorAxis] = semiAxis.to_f
                  end
                  if semiAxis.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: geodetic reference semi-major axis is missing'
                  end

                  # geodetic model 4.1.2.4.4 (plandu) - distance units
                  # take value from the first 'planar' section with 'plandu' specified
                  axPlanar = xHorizontalRef.xpath('./planar')
                  unless axPlanar.empty?
                     axPlanar.each do |xPlanar|
                        xPlanCI = xPlanar.xpath('./planci')
                        unless xPlanCI.empty?
                           units = xPlanCI.xpath('./plandu').text
                           unless units.empty?
                              hGeodetic[:axisUnits] = units
                           end
                        end
                     end
                  end

                  # geodetic model 4.1.4.4 (denflat) - denominator of flattening ratio (required)
                  # -> referenceSystemParameters.geodetic.denominatorOfFlatteningRatio
                  flattening = xGeodetic.xpath('./denflat').text
                  unless flattening.empty?
                     hGeodetic[:denominatorOfFlatteningRatio] = flattening.to_f
                  end
                  if flattening.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: geodetic reference flattening ratio is missing'
                  end

                  hReferenceSystem = intMetadataClass.newSpatialReferenceSystem
                  hSystemParameters = intMetadataClass.newReferenceSystemParameterSet
                  hSystemParameters[:geodetic] = hGeodetic
                  hReferenceSystem[:systemParameterSet] = hSystemParameters

                  return hReferenceSystem

               end

            end

         end
      end
   end
end
