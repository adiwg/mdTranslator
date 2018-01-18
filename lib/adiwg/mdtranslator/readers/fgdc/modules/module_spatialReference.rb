# Reader - fgdc to internal data structure
# unpack fgdc spatial data reference

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_horizontalReference'
require_relative 'module_verticalDatum'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module SpatialReference

               def self.unpack(xSpatialRef, hResourceInfo, hResponseObj)

                  # spatial reference 4.1 (horizsys) - horizontal coordinate system
                  xHorizontalRef = xSpatialRef.xpath('./horizsys')
                  unless xHorizontalRef.empty?
                     HorizontalReference.unpack(xHorizontalRef, hResourceInfo, hResponseObj)
                  end

                  # spatial reference 4.2 (vertdef) - vertical coordinate system
                  xVerticalRef = xSpatialRef.xpath('./vertdef')
                  unless xVerticalRef.empty?
                     VerticalReference.unpack(xVerticalRef, hResourceInfo, hResponseObj)
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
