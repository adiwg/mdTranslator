# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
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

                  hProjection[:projection] = 'localPlanar'
                  hProjection[:projectionName] = 'local planar coordinate system'

                  # local planar 4.1.2.3.1 (localpd) - local planar description (required)
                  # -> ReferenceSystemParameters.projection.localPlanarDescription
                  description = xMapLocal.xpath('./localpd').text
                  unless description.empty?
                     hProjection[:localPlanarDescription] = description
                  end
                  if description.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC local planar coordinate system description is missing'
                  end

                  # local planar 4.1.2.3.2 (localpgi) - local planar georeference information (required)
                  # -> ReferenceSystemParameters.projection.localPlanarGeoreference
                  georeference = xMapLocal.xpath('./localpgi').text
                  unless georeference.empty?
                     hProjection[:localPlanarGeoreference] = georeference
                  end
                  if georeference.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC local planar coordinate system georeference information is missing'
                  end

                  return hProjection

               end

            end

         end
      end
   end
end
