# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Spatial

               def self.build(intObj)
                  resourceInfo = intObj.dig(:metadata, :resourceInfo)
                  extent = resourceInfo&.dig(:extents, 0)
                  geographicExtent = extent&.dig(:geographicExtents, 0)
                  boundingBox = geographicExtent&.dig(:boundingBox)

                  if boundingBox
                    return [
                      boundingBox[:eastLongitude],
                      boundingBox[:southLatitude],
                      boundingBox[:westLongitude],
                      boundingBox[:northLatitude]
                    ].join(',')
                  elsif geographicExtent&.dig(:geographicElement, 0, :type) == 'point'
                    point = geographicExtent.dig(:geographicElement, 0, :coordinate)
                    return "#{point[1]},#{point[0]}" if point&.length == 2
                  end

                  nil
               end           

            end
         end
      end
   end
end
