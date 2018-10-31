# Reader - fgdc to internal data structure
# unpack fgdc horizontal data reference

# History:
#  Stan Smith 2017-10-02 original script

require 'nokogiri'
require_relative 'module_horizontalPlanar'
require_relative 'module_geographicResolution'
require_relative 'module_geodeticReference'
require_relative 'module_localSystem'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module HorizontalReference

               def self.unpack(xHorizontalRef, hResourceInfo, hResponseObj)

                  # horizontal reference 4.1.1 (geograph) - geographic resolution
                  xGeographic = xHorizontalRef.xpath('./geograph')
                  unless xGeographic.empty?
                     hResolution = GeographicResolution.unpack(xGeographic, hResponseObj)
                     unless hResolution.nil?
                        hResourceInfo[:spatialResolutions] << hResolution
                     end
                  end

                  # horizontal reference 4.1.2 (planar) - planar coordinate system []
                  axPlanar = xHorizontalRef.xpath('./planar')
                  unless axPlanar.empty?
                     axPlanar.each do |xPlanar|
                        PlanarReference.unpack(xPlanar, hResourceInfo, hResponseObj)
                     end
                  end

                  # horizontal reference 4.1.3 (local) - local coordinate system
                  xLocal = xHorizontalRef.xpath('./local')
                  unless xLocal.empty?
                     hReferenceSystem = MapLocalSystem.unpack(xLocal, hResponseObj)
                     unless hReferenceSystem.nil?
                        hResourceInfo[:spatialReferenceSystems] << hReferenceSystem
                     end
                  end

                  # horizontal reference 4.1.4 (geodetic) - parameters for shape of earth
                  xGeodetic = xHorizontalRef.xpath('./geodetic')
                  unless xGeodetic.empty?
                     hReferenceSystem = GeodeticReference.unpack(xHorizontalRef, hResponseObj)
                     unless hReferenceSystem.nil?
                        hResourceInfo[:spatialReferenceSystems] << hReferenceSystem
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
