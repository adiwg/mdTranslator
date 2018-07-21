# unpack spatial reference system parameter set
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-22 refactored error and warning messaging
# 	Stan Smith 2017-10-23 original script

require_relative 'module_projectionParameters'
require_relative 'module_geodetic'
require_relative 'module_verticalDatum'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ReferenceSystemParameters

               def self.unpack(hParams, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hParams.empty?
                     @MessagePath.issueWarning(660, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intParamSet = intMetadataClass.newReferenceSystemParameterSet

                  outContext = 'reference system parameter set'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveParams = false

                  # reference system parameters - projection parameters
                  if hParams.has_key?('projection')
                     unless hParams['projection'].empty?
                        hReturn = ProjectionParameters.unpack(hParams['projection'], responseObj, outContext)
                        unless hReturn.nil?
                           intParamSet[:projection] = hReturn
                           haveParams = true
                        end
                     end
                  end

                  # reference system parameters - ellipsoid parameters
                  if hParams.has_key?('geodetic')
                     unless hParams['geodetic'].empty?
                        hReturn = Geodetic.unpack(hParams['geodetic'], responseObj, outContext)
                        unless hReturn.nil?
                           intParamSet[:geodetic] = hReturn
                           haveParams = true
                        end
                     end
                  end

                  # reference system parameters - vertical datum parameters
                  if hParams.has_key?('verticalDatum')
                     unless hParams['verticalDatum'].empty?
                        hReturn = VerticalDatum.unpack(hParams['verticalDatum'], responseObj, outContext)
                        unless hReturn.nil?
                           intParamSet[:verticalDatum] = hReturn
                           haveParams = true
                        end
                     end
                  end

                  # error messages
                  unless haveParams
                     @MessagePath.issueWarning(661, responseObj, inContext)
                  end

                  return intParamSet
               end

            end

         end
      end
   end
end
