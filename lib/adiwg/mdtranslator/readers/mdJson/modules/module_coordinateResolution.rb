# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2017-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module CoordinateResolution

               def self.unpack(hCoordRes, responseObj)

                  # return nil object if input is empty
                  if hCoordRes.empty?
                     responseObj[:readerExecutionMessages] <<
                        'WARNING: mdJson reader: spatial resolution coordinate resolution object is empty'
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
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson coordinate spatial resolution abscissa resolution is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # coordinate resolution - ordinate (Y) (required)
                  if hCoordRes.has_key?('ordinateResolutionY')
                     intCoordRes[:ordinateResolutionY] = hCoordRes['ordinateResolutionY']
                  end
                  if intCoordRes[:ordinateResolutionY].nil? || intCoordRes[:ordinateResolutionY] == ''
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson coordinate spatial resolution ordinate resolution is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # coordinate resolution - units of measure (required)
                  if hCoordRes.has_key?('unitOfMeasure')
                     intCoordRes[:unitOfMeasure] = hCoordRes['unitOfMeasure']
                  end
                  if intCoordRes[:unitOfMeasure].nil? || intCoordRes[:unitOfMeasure] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson coordinate spatial resolution units are missing'
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
