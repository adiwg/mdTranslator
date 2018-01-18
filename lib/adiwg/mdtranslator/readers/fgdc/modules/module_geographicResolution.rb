# Reader - fgdc to internal data structure
# unpack fgdc horizontal data geographic resolution

# History:
#  Stan Smith 2017-12-29 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module GeographicResolution

               def self.unpack(xGeographic)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  hResolution = intMetadataClass.newSpatialResolution
                  hGeoResolution = intMetadataClass.newGeographicResolution

                  # geographic reference 4.1.1.1 (latres) - latitude resolution
                  # -> spatialResolution.geographicResolution.latitudeResolution
                  latResolution = xGeographic.xpath('./latres').text
                  unless latResolution.empty?
                     hGeoResolution[:latitudeResolution] = latResolution.to_f
                  end

                  # geographic reference 4.1.1.2 (longres) - longitude resolution
                  # -> spatialResolution.geographicResolution.longitudeResolution
                  longResolution = xGeographic.xpath('./longres').text
                  unless longResolution.empty?
                     hGeoResolution[:longitudeResolution] = longResolution.to_f
                  end

                  # geographic reference 4.1.1.3 (geogunit) - latitude/longitude units
                  # -> spatialResolution.geographicResolution.unitOfMeasure
                  unitMeasure = xGeographic.xpath('./geogunit').text
                  unless unitMeasure.empty?
                     hGeoResolution[:unitOfMeasure] = unitMeasure
                  end

                  hResolution[:geographicResolution] = hGeoResolution

                  return hResolution

               end

            end

         end
      end
   end
end
