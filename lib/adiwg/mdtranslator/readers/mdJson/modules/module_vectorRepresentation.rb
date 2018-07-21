# unpack vector representation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-27 refactored error and warning messaging
# 	Stan Smith 2016-10-19 original script

require_relative 'module_vectorObject'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module VectorRepresentation

               def self.unpack(hVector, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hVector.empty?
                     @MessagePath.issueWarning(910, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intVector = intMetadataClass.newVectorInfo

                  outContext = 'vector representation'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveVector = false

                  # vector representation - topology level
                  if hVector.has_key?('topologyLevel')
                     unless hVector['topologyLevel'] == ''
                        intVector[:topologyLevel] = hVector['topologyLevel']
                        haveVector = true
                     end
                  end

                  # vector representation - vector object []
                  if hVector.has_key?('vectorObject')
                     hVector['vectorObject'].each do |item|
                        hVec = VectorObject.unpack(item, responseObj, outContext)
                        unless hVec.nil?
                           intVector[:vectorObject] << hVec
                           haveVector = true
                        end
                     end
                  end

                  # error messages
                  unless haveVector
                     @MessagePath.issueError(911, responseObj, inContext)
                  end

                  return intVector

               end

            end

         end
      end
   end
end
