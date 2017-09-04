# Reader - fgdc to internal data structure
# unpack fgdc spatial data organization

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_pointVector'
require_relative 'module_raster'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module SpatialOrganization

               def self.unpack(xSpatialOrg, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # spatial organization 3.1 (indspref) - indirect spatial reference
                  # -> resourceInfo.spatialReferenceSystems.spatialReferenceSystem.systemIdentifier.identifier per NOAA
                  # -> however definitions are not close
                  indirect = xSpatialOrg.xpath('./indspref').text
                  unless indirect.empty?
                     hSystem = intMetadataClass.newSpatialReferenceSystem
                     hIdentifier = intMetadataClass.newIdentifier
                     hIdentifier[:identifier] = indirect
                     hSystem[:systemIdentifier] = hIdentifier
                     hResourceInfo[:spatialReferenceSystems] << hSystem
                  end

                  # spatial organization 3.2 (direct) - direct spatial reference method
                  # -> resourceInfo.spatialRepresentationTypes, translate FGDC to ISO as:
                  # -> point = vector do 3.3
                  # -> vector = vector do 3.3
                  # -> raster = grid do 3.4
                  direct = xSpatialOrg.xpath('./direct').text
                  unless direct.empty?
                     type = 'vector' if direct == 'Point'
                     type = 'vector' if direct == 'Vector'
                     type = 'grid' if direct == 'Raster'
                     hResourceInfo[:spatialRepresentationTypes] << type

                     # spatial organization 3.3 (ptvctinfo) - point and vector object
                     if type == 'vector'
                        xPtVec = xSpatialOrg.xpath('./ptvctinf')
                        unless xPtVec.empty?
                           PointVector.unpack(xPtVec, hResourceInfo, hResponseObj)
                        end
                     end

                     # spatial organization 3.4 (rastinfo) - raster object
                     if type == 'grid'
                        xRaster = xSpatialOrg.xpath('./rastinfo')
                        unless xRaster.empty?
                           Raster.unpack(xRaster, hResourceInfo, hResponseObj)
                        end
                     end

                  end

                  return hResourceInfo

               end
            end

         end
      end
   end
end
