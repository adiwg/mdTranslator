# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Spatial

               def self.build(intObj)
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  extent = resourceInfo[:extents][0]
                  geographicExtent = extent[:geographicExtents][0]
                  boundingBox = geographicExtent[:boundingBox]
                  return boundingBox
               end           

            end
         end
      end
   end
end
