# Reader - fgdc to internal data structure
# unpack fgdc horizontal data reference

# History:
#  Stan Smith 2017-10-02 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_horizontalPlanar'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module HorizontalReference

               def self.unpack(xHorizontalRef, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # horizontal reference 4.1.1 (geograph) - geographic coordinate system
                  xGeographic = xHorizontalRef.xpath('./geograph')
                  unless xGeographic.empty?

                     hResolution = intMetadataClass.newSpatialResolution
                     hGeoResolution = intMetadataClass.newGeographicResolution
                     hasValue = false

                     # geographic reference 4.1.1.1 (latres) - latitude resolution
                     # -> spatialResolution.geographicResolution.latitudeResolution
                     latResolution = xGeographic.xpath('./latres').text
                     unless latResolution.empty?
                        hGeoResolution[:latitudeResolution] = latResolution.to_f
                        hasValue = true
                     end

                     # geographic reference 4.1.1.2 (longres) - longitude resolution
                     # -> spatialResolution.geographicResolution.longitudeResolution
                     longResolution = xGeographic.xpath('./longres').text
                     unless longResolution.empty?
                        hGeoResolution[:longitudeResolution] = longResolution.to_f
                        hasValue = true
                     end

                     # geographic reference 4.1.1.3 (geogunit) - latitude/longitude units
                     # -> spatialResolution.geographicResolution.unitOfMeasure
                     unitMeasure = xGeographic.xpath('./geogunit').text
                     unless unitMeasure.empty?
                        hGeoResolution[:unitOfMeasure] = unitMeasure
                        hasValue = true
                     end

                     if hasValue
                        hResolution[:geographicResolution] = hGeoResolution
                        hResourceInfo[:spatialResolutions] << hResolution
                     end

                  end

                  # horizontal reference 4.1.2 (planar) - planar coordinate system []
                  axPlanar = xHorizontalRef.xpath('./planar')
                  unless axPlanar.empty?
                     axPlanar.each do |xPlanar|
                        PlanarReference.unpack(xPlanar, hResourceInfo, hResponseObj)
                     end
                  end

                  # horizontal reference 4.1.3 (local) - local coordinate system
                  xLocal = xHorizontalRef.xpath('./local')
                  unless xLocal.empty?

                     hProjection = intMetadataClass.newProjection
                     hProjection[:projectionName] = 'local'

                     # local planar 4.1.3.1 (localdes) - local description
                     # -> referenceSystemParameters.projection.localPlanarDescription
                     description = xLocal.xpath('./localdes').text
                     unless description.empty?
                        hProjection[:localPlanarDescription] = description
                     end

                     # local planar 4.1.3.2 (localgeo) - local georeference information
                     # -> referenceSystemParameters.projection.localPlanarGeoreference
                     georeference = xLocal.xpath('./localgeo').text
                     unless georeference.empty?
                        hProjection[:localPlanarGeoreference] = georeference
                     end

                     hReferenceSystem = intMetadataClass.newSpatialReferenceSystem
                     hSystemParameters = intMetadataClass.newReferenceSystemParameterSet
                     hSystemParameters[:projection] = hProjection
                     hReferenceSystem[:systemParameterSet] = hSystemParameters
                     hResourceInfo[:spatialReferenceSystems] << hReferenceSystem

                  end

                  # horizontal reference 4.1.4 (geodetic) - parameters for shape of earth
                  xGeodetic = xHorizontalRef.xpath('./geodetic')
                  unless xGeodetic.empty?

                     hEllipsoid = intMetadataClass.newEllipsoid

                     # geodetic model 4.1.4.1 (horizdn) - horizontal datum name
                     # -> referenceSystemParameters.datumIdentifier.identifier.identifier
                     datumName = xGeodetic.xpath('./horizdn').text
                     unless datumName.empty?
                        hIdentifier = intMetadataClass.newIdentifier
                        hIdentifier[:identifier] = datumName
                        hEllipsoid[:ellipsoidIdentifier] = hIdentifier
                     end

                     # geodetic model 4.1.4.2 (ellips) - ellipsoid name
                     # -> referenceSystemParameters.ellipsoid.ellipsoidName
                     ellipsoidName = xGeodetic.xpath('./ellips').text
                     unless ellipsoidName.empty?
                        hEllipsoid[:ellipsoidName] = ellipsoidName
                     end

                     # geodetic model 4.1.4.3 (semiaxis) - semi-major axis
                     # -> referenceSystemParameters.ellipsoid.semiMajorAxis
                     semiAxis = xGeodetic.xpath('./semiaxis').text
                     unless semiAxis.empty?
                        hEllipsoid[:semiMajorAxis] = semiAxis.to_f
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
                                 hEllipsoid[:axisUnits] = units
                              end
                           end
                        end
                     end

                     # geodetic model 4.1.4.4 (denflat) - denominator of flattening ratio
                     # -> referenceSystemParameters.ellipsoid.denominatorOfFlatteningRatio
                     flattening = xGeodetic.xpath('./denflat').text
                     unless flattening.empty?
                        hEllipsoid[:denominatorOfFlatteningRatio] = flattening.to_f
                     end

                     hReferenceSystem = intMetadataClass.newSpatialReferenceSystem
                     hSystemParameters = intMetadataClass.newReferenceSystemParameterSet
                     hSystemParameters[:ellipsoid] = hEllipsoid
                     hReferenceSystem[:systemParameterSet] = hSystemParameters
                     hResourceInfo[:spatialReferenceSystems] << hReferenceSystem

                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
