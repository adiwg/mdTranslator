# unpack vector representation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2016-10-19 original script

require_relative 'module_vectorObject'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module VectorRepresentation

               def self.unpack(hVector, responseObj)

                  # return nil object if input is empty
                  if hVector.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: vector representation object is empty'
                     return nil
                  end

                  haveVector = false

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intVector = intMetadataClass.newVectorInfo

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
                        hVec = VectorObject.unpack(item, responseObj)
                        unless hVec.nil?
                           intVector[:vectorObject] << hVec
                           haveVector = true
                        end
                     end
                  end

                  # error messages
                  unless haveVector
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson reader: vector representation must have a topology level or vector object'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intVector

               end

            end

         end
      end
   end
end
