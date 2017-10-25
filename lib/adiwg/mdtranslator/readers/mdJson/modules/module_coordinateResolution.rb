# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module CoordinateResolution

               def self.unpack(hCoordRes, responseObj)

                  # return nil object if input is empty
                  if hCoordRes.empty?
                     responseObj[:readerExecutionMessages] << 'Coordinate Resolution object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intCoordRes = intMetadataClass.newCoordinateResolution

                  # coordinate resolution - abscissa (X) (required)
                  if hCoordRes.has_key?('abscissaResolutionX')
                     intCoordRes[:abscissaResolutionX] = hCoordRes['abscissaResolutionX']
                  end
                  if intCoordRes[:abscissaResolutionX].nil? || intCoordRes[:abscissaResolutionX] == ''
                     responseObj[:readerExecutionMessages] << 'Coordinate Resolution is missing abscissa resolution'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # coordinate resolution - ordinate (Y) (required)
                  if hCoordRes.has_key?('ordinateResolutionY')
                     intCoordRes[:ordinateResolutionY] = hCoordRes['ordinateResolutionY']
                  end
                  if intCoordRes[:ordinateResolutionY].nil? || intCoordRes[:ordinateResolutionY] == ''
                     responseObj[:readerExecutionMessages] << 'Coordinate Resolution is missing ordinate resolution'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # coordinate resolution - units of measure (required)
                  if hCoordRes.has_key?('unitOfMeasure')
                     intCoordRes[:unitOfMeasure] = hCoordRes['unitOfMeasure']
                  end
                  if intCoordRes[:unitOfMeasure].nil? || intCoordRes[:unitOfMeasure] == ''
                     responseObj[:readerExecutionMessages] << 'Coordinate Resolution is missing units of measure'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intCoordRes

               end

            end

         end
      end
   end
end
