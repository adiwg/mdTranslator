# Reader - fgdc to internal data structure
# unpack fgdc raster data organization

# History:
#  Stan Smith 2017-09-01 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Raster

               def self.unpack(xRaster, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hSpatialRepresentation = intMetadataClass.newSpatialRepresentation
                  hGridInfo = intMetadataClass.newGridInfo

                  # raster object 3.4.1 (rasttype) - raster object type (require)
                  # -> spatialRepresentation.gridInfo.numberOfDimensions per NOAA
                  # -> FGDC and ISO definitions do not match on this element
                  # -> however elements do match on  spatialRepresentation.gridInfo.cellGeometry
                  cellGeometry = xRaster.xpath('./rasttype').text
                  unless cellGeometry.empty?
                     hGridInfo[:cellGeometry] = cellGeometry.downcase
                  end
                  if cellGeometry.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC spatial domain raster type is missing'
                  end

                  # -> compute number of dimensions from total occurrence of 3.4.2-4
                  hGridInfo[:numberOfDimensions] = 0
                  rows = xRaster.xpath('./rowcount').text
                  columns = xRaster.xpath('./colcount').text

                  # raster object 3.4.2 (rowcount) - row count
                  # -> spatialRepresentation.gridInfo.dimension.dimensionSize
                  # -> spatialRepresentation.gridInfo.dimension.dimensionType = row
                  unless rows.empty?
                     hDimension = intMetadataClass.newDimension
                     hDimension[:dimensionType] = 'row'
                     hDimension[:dimensionSize] = rows.to_i
                     hGridInfo[:dimension] << hDimension
                     hGridInfo[:numberOfDimensions] += 1
                  end
                  if rows.empty? && !columns.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC spatial domain raster row count is missing'
                  end

                  # raster object 3.4.3 (colcount) - column count
                  # -> spatialRepresentation.gridInfo.dimension.dimensionSize
                  # -> spatialRepresentation.gridInfo.dimension.dimensionType = column
                  unless columns.empty?
                     hDimension = intMetadataClass.newDimension
                     hDimension[:dimensionType] = 'column'
                     hDimension[:dimensionSize] = columns.to_i
                     hGridInfo[:dimension] << hDimension
                     hGridInfo[:numberOfDimensions] += 1
                  end
                  if columns.empty? && !rows.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC spatial domain raster column count is missing'
                  end

                  # raster object 3.4.4 (vrtcount) - vertical count
                  # -> spatialRepresentation.gridInfo.dimension.dimensionSize
                  # -> spatialRepresentation.gridInfo.dimension.dimensionType = vertical
                  verts = xRaster.xpath('./vrtcount').text
                  unless verts.empty?
                     hDimension = intMetadataClass.newDimension
                     hDimension[:dimensionType] = 'vertical'
                     hDimension[:dimensionSize] = verts.to_i
                     hGridInfo[:dimension] << hDimension
                     hGridInfo[:numberOfDimensions] += 1
                  end

                  hSpatialRepresentation[:gridRepresentation] = hGridInfo
                  hResourceInfo[:spatialRepresentations] << hSpatialRepresentation

                  return hResourceInfo

               end

            end

         end
      end
   end
end
