# unpack spatial reference system parameter set
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-10-23 original script

require_relative 'module_projectionParameters'
require_relative 'module_ellipsoid'
require_relative 'module_verticalDatum'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ReferenceSystemParameters

               def self.unpack(hParams, responseObj)

                  # return nil object if input is empty
                  if hParams.empty?
                     responseObj[:readerExecutionMessages] << 'Spatial Reference System Parameters object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intParamSet = intMetadataClass.newReferenceSystemParameterSet

                  # reference system parameters - projection parameters
                  if hParams.has_key?('projection')
                     unless hParams['projection'].empty?
                        hReturn = ProjectionParameters.unpack(hParams['projection'], responseObj)
                        unless hReturn.nil?
                           intParamSet[:projection] = hReturn
                        end
                     end
                  end

                  # reference system parameters - ellipsoid parameters
                  if hParams.has_key?('ellipsoid')
                     unless hParams['ellipsoid'].empty?
                        hReturn = Ellipsoid.unpack(hParams['ellipsoid'], responseObj)
                        unless hReturn.nil?
                           intParamSet[:ellipsoid] = hReturn
                        end
                     end
                  end

                  # reference system parameters - vertical datum parameters
                  if hParams.has_key?('verticalDatum')
                     unless hParams['verticalDatum'].empty?
                        hReturn = VerticalDatum.unpack(hParams['verticalDatum'], responseObj)
                        unless hReturn.nil?
                           intParamSet[:verticalDatum] = hReturn
                        end
                     end
                  end

                  return intParamSet
               end

            end

         end
      end
   end
end
