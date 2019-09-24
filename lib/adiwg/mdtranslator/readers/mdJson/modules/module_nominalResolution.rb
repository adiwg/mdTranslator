# unpack nominal resolution
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2019-09-22 original script

require_relative 'module_measure'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module NominalResolution

               def self.unpack(hResolution, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hResolution.empty?
                     @MessagePath.issueWarning(960, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intResolution = intMetadataClass.newNominalResolution

                  outContext = 'nominal resolution'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveRequired = 0

                  # nominal resolution - scanning resolution (required if)
                  if hResolution.has_key?('scanningResolution')
                     hMeasure = hResolution['scanningResolution']
                     unless hMeasure.empty?
                        hMeasure['type'] = 'distance'
                        hReturn = Measure.unpack(hMeasure, responseObj, outContext)
                        unless hReturn.nil?
                           intResolution[:scanningResolution] = hReturn
                           haveRequired += 1
                        end
                     end
                  end

                  # nominal resolution - ground resolution (required if)
                  if hResolution.has_key?('groundResolution')
                     hMeasure = hResolution['groundResolution']
                     unless hMeasure.empty?
                        hMeasure['type'] = 'distance'
                        hReturn = Measure.unpack(hMeasure, responseObj, outContext)
                        unless hReturn.nil?
                           intResolution[:groundResolution] = hReturn
                           haveRequired += 1
                        end
                     end
                  end

                  unless haveRequired > 0
                     @MessagePath.issueError(961, responseObj, inContext)
                  end

                  if haveRequired == 2
                     @MessagePath.issueError(962, responseObj, inContext)
                  end

                  return intResolution

               end

            end

         end
      end
   end
end
