# Reader - fgdc to internal data structure
# unpack fgdc horizontal data local reference

# History:
#  Stan Smith 2017-12-29 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module LocalSystem

               def self.unpack(xLocal, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

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

                  return hReferenceSystem

               end

            end

         end
      end
   end
end
