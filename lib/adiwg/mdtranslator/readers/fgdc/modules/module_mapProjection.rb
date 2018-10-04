# Reader - fgdc to internal data structure
# unpack fgdc map projection

# History:
#  Stan Smith 2018-10-03 refactor mdJson projection object
#  Stan Smith 2017-10-03 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'mapProjections/projection_albers'
require_relative 'mapProjections/projection_azimuthEquidistant'
require_relative 'mapProjections/projection_equidistantConic'
require_relative 'mapProjections/projection_equirectangular'
require_relative 'mapProjections/projection_generalVertical'
require_relative 'mapProjections/projection_gnomonic'
require_relative 'mapProjections/projection_lambertEqualArea'
require_relative 'mapProjections/projection_lambertConic'
require_relative 'mapProjections/projection_mercator'
require_relative 'mapProjections/projection_modifiedAlaska'
require_relative 'mapProjections/projection_millerCylinder'
require_relative 'mapProjections/projection_obliqueMercator'
require_relative 'mapProjections/projection_orthographic'
require_relative 'mapProjections/projection_polarStereo'
require_relative 'mapProjections/projection_polyconic'
require_relative 'mapProjections/projection_robinson'
require_relative 'mapProjections/projection_sinusoidal'
require_relative 'mapProjections/projection_spaceOblique'
require_relative 'mapProjections/projection_stereographic'
require_relative 'mapProjections/projection_transverseMercator'
require_relative 'mapProjections/projection_vanDerGrinten'
require_relative 'mapProjections/projection_parameters'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapProjection

               def self.unpack(xMapProjection, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hProjection = intMetadataClass.newProjection
                  hIdentifier = intMetadataClass.newIdentifier
                  hProjection[:projectionIdentifier] = hIdentifier

                  # map projection 4.1.2.1.1 (mapprojn) - map projection name (required)
                  # -> ReferenceSystemParameters.projection.projectionIdentifier.identifier
                  name = xMapProjection.xpath('./mapprojn').text
                  unless name.empty?
                     hIdentifier[:name] = name
                  end
                  if name.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: map projection name is missing'
                  end

                  # map projection 4.1.2.1.2 (albers) - Albers Conical Equal Area
                  xAlbers = xMapProjection.xpath('./albers')
                  unless xAlbers.empty?
                     hIdentifier[:identifier] = 'albers'
                     hIdentifier[:name] = 'Albers Conical Equal Area' if name.empty?
                     return AlbersProjection.unpack(xAlbers, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.3 (azimequi) - Azimuthal Equidistant
                  xAzimequi = xMapProjection.xpath('./azimequi')
                  unless xAzimequi.empty?
                     hIdentifier[:identifier] = 'azimuthalEquidistant'
                     hIdentifier[:name] = 'Azimuthal Equidistant' if name.empty?
                     return AzimuthEquidistantProjection.unpack(xAzimequi, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.4 (equicon) - Equidistant Conic
                  xEquiCon = xMapProjection.xpath('./equicon')
                  unless xEquiCon.empty?
                     hIdentifier[:identifier] = 'equidistantConic'
                     hIdentifier[:name] = 'Equidistant Conic' if name.empty?
                     return EquidistantConicProjection.unpack(xEquiCon, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.5 (equirect) - Equirectangular
                  xEquirec = xMapProjection.xpath('./equirect')
                  unless xEquirec.empty?
                     hIdentifier[:identifier] = 'equirectangular'
                     hIdentifier[:name] = 'Equirectangular' if name.empty?
                     return EquirectangularProjection.unpack(xEquirec, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.6 (gvnsp) - General Vertical Near-sided Perspective
                  xGenVert = xMapProjection.xpath('./gvnsp')
                  unless xGenVert.empty?
                     hIdentifier[:identifier] = 'generalVertical'
                     hIdentifier[:name] = 'General Vertical Near-sided Perspective' if name.empty?
                     return GeneralVerticalProjection.unpack(xGenVert, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.7 (gnomonic) - Gnomonic
                  xGeomonic = xMapProjection.xpath('./gnomonic')
                  unless xGeomonic.empty?
                     hIdentifier[:identifier] = 'gnomonic'
                     hIdentifier[:name] = 'Gnomonic' if name.empty?
                     return GnomonicProjection.unpack(xGeomonic, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.8 (lamberta) - Lambert Azimuthal Equal Area
                  xLambertA = xMapProjection.xpath('./lamberta')
                  unless xLambertA.empty?
                     hIdentifier[:identifier] = 'lambertEqualArea'
                     hIdentifier[:name] = 'Lambert Azimuthal Equal Area' if name.empty?
                     return LambertEqualAreaProjection.unpack(xLambertA, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.9 (lambertc) - Lambert Conformal Conic
                  xLambertC = xMapProjection.xpath('./lambertc')
                  unless xLambertC.empty?
                     hIdentifier[:identifier] = 'lambertConic'
                     hIdentifier[:name] = 'Lambert Conformal Conic' if name.empty?
                     return LambertConicProjection.unpack(xLambertC, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.10 (mercator) - Mercator
                  xMercator = xMapProjection.xpath('./mercator')
                  unless xMercator.empty?
                     hIdentifier[:identifier] = 'mercator'
                     hIdentifier[:name] = 'Mercator' if name.empty?
                     return MercatorProjection.unpack(xMercator, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.11 (modsak) - Modified Stereographic for Alaska
                  xAlaska = xMapProjection.xpath('./modsak')
                  unless xAlaska.empty?
                     hIdentifier[:identifier] = 'alaska'
                     hIdentifier[:name] = 'Modified Stereographic for Alaska' if name.empty?
                     return ModifiedAlaskaProjection.unpack(xAlaska, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.12 (miller) - Miller Cylindrical
                  xMiller = xMapProjection.xpath('./miller')
                  unless xMiller.empty?
                     hIdentifier[:identifier] = 'miller'
                     hIdentifier[:name] = 'Miller Cylindrical' if name.empty?
                     return MillerCylinderProjection.unpack(xMiller, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.13 (obqmerc) - Oblique Mercator
                  xObliqueM = xMapProjection.xpath('./obqmerc')
                  unless xObliqueM.empty?
                     hIdentifier[:identifier] = 'obliqueMercator'
                     hIdentifier[:name] = 'Oblique Mercator' if name.empty?
                     return ObliqueMercatorProjection.unpack(xObliqueM, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.14 (orthogr) - Orthographic
                  xOrtho = xMapProjection.xpath('./orthogr')
                  unless xOrtho.empty?
                     hIdentifier[:identifier] = 'orthographic'
                     hIdentifier[:name] = 'Orthographic' if name.empty?
                     return OrthographicProjection.unpack(xOrtho, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.15 (polarst) - Polar Stereographic
                  xPolarStereo = xMapProjection.xpath('./polarst')
                  unless xPolarStereo.empty?
                     hIdentifier[:identifier] = 'polarStereo'
                     hIdentifier[:name] = 'Polar Stereographic' if name.empty?
                     return PolarStereoProjection.unpack(xPolarStereo, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.16 (polycon) - Polyconic
                  xPolycon = xMapProjection.xpath('./polycon')
                  unless xPolycon.empty?
                     hIdentifier[:identifier] = 'polyconic'
                     hIdentifier[:name] = 'Polyconic' if name.empty?
                     return PolyconicProjection.unpack(xPolycon, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.17 (robinson) - Robinson
                  xRobin = xMapProjection.xpath('./robinson')
                  unless xRobin.empty?
                     hIdentifier[:identifier] = 'robinson'
                     hIdentifier[:name] = 'Robinson' if name.empty?
                     return RobinsonProjection.unpack(xRobin, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.18 (sinusoid) - Sinusoidal
                  xSinu = xMapProjection.xpath('./sinusoid')
                  unless xSinu.empty?
                     hIdentifier[:identifier] = 'sinusoidal'
                     hIdentifier[:name] = 'Sinusoidal'
                     return SinusoidalProjection.unpack(xSinu, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.19 (spaceobq) - Space Oblique Mercator (Landsat)
                  xSpaceO = xMapProjection.xpath('./spaceobq')
                  unless xSpaceO.empty?
                     hIdentifier[:identifier] = 'spaceOblique'
                     hIdentifier[:name] = 'Space Oblique Mercator (Landsat)'
                     return SpaceObliqueProjection.unpack(xSpaceO, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.20 (stereo) - Stereographic
                  xStereo = xMapProjection.xpath('./stereo')
                  unless xStereo.empty?
                     hIdentifier[:identifier] = 'stereographic'
                     hIdentifier[:name] = 'Stereographic'
                     return StereographicProjection.unpack(xStereo, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.21 (transmer) - Transverse Mercator
                  xTransMer = xMapProjection.xpath('./transmer')
                  unless xTransMer.empty?
                     hIdentifier[:identifier] = 'transverseMercator'
                     hIdentifier[:name] = 'Transverse Mercator'
                     return TransverseMercatorProjection.unpack(xTransMer, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.22 (vdgrin) - van der Grinten
                  xVanDerG = xMapProjection.xpath('./vdgrin')
                  unless xVanDerG.empty?
                     hIdentifier[:identifier] = 'grinten'
                     hIdentifier[:name] = 'Van Der Grinten'
                     return VanDerGrintenProjection.unpack(xVanDerG, hProjection, hResponseObj)
                  end

                  # map projection 4.1.2.1.23 (mapprojp) - projection parameter set
                  xParamSet = xMapProjection.xpath('./mapprojp')
                  unless xParamSet.empty?
                     hIdentifier[:identifier] = 'parameters'
                     hIdentifier[:name] = 'Projection Parameters'
                     return ProjectionParameters.unpack(xParamSet, hProjection, hResponseObj)
                  end

                  return nil

               end

            end

         end
      end
   end
end
