# Reader - fgdc to internal data structure
# unpack fgdc vertical data reference

# History:
#  Stan Smith 2017-10-02 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_verticalAltitude'
require_relative 'module_verticalDepth'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module VerticalReference

               def self.unpack(xVerticalRef, hResourceInfo, hResponseObj)

                  # spatial reference 4.2.1 (altsys) - altitude system definition
                  xAltSys = xVerticalRef.xpath('./altsys')
                  unless xAltSys.empty?
                     hRefSystem = VerticalAltitude.unpack(xAltSys, hResponseObj)
                     unless hRefSystem.nil?
                        hResourceInfo[:spatialReferenceSystems] << hRefSystem
                     end
                  end

                  # spatial reference 4.2.2 (depthsys) - depth system definition
                  xDepthSys = xVerticalRef.xpath('./depthsys')
                  unless xDepthSys.empty?
                     hRefSystem = VerticalDepth.unpack(xDepthSys, hResponseObj)
                     unless hRefSystem.nil?
                        hResourceInfo[:spatialReferenceSystems] << hRefSystem
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
