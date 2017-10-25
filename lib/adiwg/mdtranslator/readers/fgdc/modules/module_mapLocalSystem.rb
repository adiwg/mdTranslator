# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2017-10-04 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'mapProjections/projection_transverseMercator'
require_relative 'mapProjections/projection_polarStereo'
require_relative 'mapProjections/projection_lambertConic'
require_relative 'mapProjections/projection_obliqueMercator'
require_relative 'mapProjections/projection_polyconic'
require_relative 'mapProjections/projection_equirectangular'
require_relative 'mapProjections/projection_azimuthEquidistant'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapLocalSystem

               def self.unpack(xMapLocal, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hProjection = intMetadataClass.newProjection

                  # -> ReferenceSystemParameters.projection.projectionIdentifier.identifier
                  hIdentifier = intMetadataClass.newIdentifier
                  hIdentifier[:identifier] = 'local planar coordinate system'
                  hProjection[:projectionIdentifier] = hIdentifier
                  hProjection[:projectionName] = 'local planar'

                  # local planar 4.1.2.3.1 (localpd) - local planar description
                  # -> ReferenceSystemParameters.projection.localPlanarDescription
                  description = xMapLocal.xpath('./localpd').text
                  unless description.empty?
                     hProjection[:localPlanarDescription] = description
                  end

                  # local planar 4.1.2.3.2 (localpgi) - local planar georeference information
                  # -> ReferenceSystemParameters.projection.localPlanarGeoreference
                  georeference = xMapLocal.xpath('./localpgi').text
                  unless georeference.empty?
                     hProjection[:localPlanarGeoreference] = georeference
                  end

                  return hProjection

               end

            end

         end
      end
   end
end
