# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2018-10-04 refactor mdJson projection object
#  Stan Smith 2017-10-04 original script

require 'nokogiri'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapLocalPlanar

               def self.unpack(xMapLocal, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hProjection = intMetadataClass.newProjection
                  hIdentifier = intMetadataClass.newIdentifier
                  hLocal = intMetadataClass.newLocal
                  hProjection[:projectionIdentifier] = hIdentifier
                  hProjection[:local] = hLocal

                  hIdentifier[:identifier] = 'localPlanar'
                  hIdentifier[:name] = 'Local Planar Coordinate System'
                  hLocal[:fixedToEarth] = true

                  # local planar 4.1.2.3.1 (localpd) - local planar description (required)
                  # -> ReferenceSystemParameters.projection.local.description
                  description = xMapLocal.xpath('./localpd').text
                  unless description.empty?
                     hLocal[:description] = description
                  end
                  if description.empty?
                     hResponseObj[:readerExecutionMessages] <<
                        'WARNING: FGDC reader: local planar coordinate system description is missing'
                  end

                  # local planar 4.1.2.3.2 (localpgi) - local planar georeference information (required)
                  # -> ReferenceSystemParameters.projection.local.georeference
                  georeference = xMapLocal.xpath('./localpgi').text
                  unless georeference.empty?
                     hLocal[:georeference] = georeference
                  end
                  if georeference.empty?
                     hResponseObj[:readerExecutionMessages] <<
                        'WARNING: FGDC reader: local planar coordinate system georeference information is missing'
                  end

                  return hProjection

               end

            end

         end
      end
   end
end
