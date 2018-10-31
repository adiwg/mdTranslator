# Reader - fgdc to internal data structure
# unpack fgdc horizontal data local reference

# History:
#  Stan Smith 2018-10-05 refactor mdJson projection object
#  Stan Smith 2017-12-29 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapLocalSystem

               def self.unpack(xLocal, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hProjection = intMetadataClass.newProjection
                  hIdentifier = intMetadataClass.newIdentifier
                  hLocal = intMetadataClass.newLocal
                  hProjection[:projectionIdentifier] = hIdentifier
                  hProjection[:local] = hLocal

                  hIdentifier[:identifier] = 'localSystem'
                  hIdentifier[:name] = 'Local Coordinate System'
                  hLocal[:fixedToEarth] = false

                  # local planar 4.1.3.1 (localdes) - local description
                  # -> ReferenceSystemParameters.projection.local.description
                  description = xLocal.xpath('./localdes').text
                  unless description.empty?
                     hLocal[:description] = description
                  end
                  if description.empty?
                     hResponseObj[:readerExecutionMessages] <<
                        'WARNING: FGDC reader: local coordinate system description is missing'
                  end

                  # local planar 4.1.3.2 (localgeo) - local georeference information
                  # -> ReferenceSystemParameters.projection.local.georeference
                  georeference = xLocal.xpath('./localgeo').text
                  unless georeference.empty?
                     hLocal[:georeference] = georeference
                  end
                  if georeference.empty?
                     hResponseObj[:readerExecutionMessages] <<
                        'WARNING: FGDC reader: local coordinate system georeference information is missing'
                  end

                  # packing
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
