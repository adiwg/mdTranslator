# unpack spatial reference system vertical datum
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2017-10-23 original script

require_relative 'module_identifier'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module VerticalDatum

               def self.unpack(hDatum, responseObj)

                  # return nil object if input is empty
                  if hDatum.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson vertical datum object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDatum = intMetadataClass.newVerticalDatum

                  # vertical datum - identifier {identifier}
                  if hDatum.has_key?('datumIdentifier')
                     unless hDatum['datumIdentifier'].empty?
                        hReturn = Identifier.unpack(hDatum['datumIdentifier'], responseObj)
                        unless hReturn.nil?
                           intDatum[:datumIdentifier] = hReturn
                        end
                     end
                  end

                  haveOthers  = 0

                  # vertical datum - datum name
                  if hDatum.has_key?('datumName')
                     unless hDatum['datumName'] == ''
                        intDatum[:datumName] = hDatum['datumName']
                        haveOthers += 1
                     end
                  end

                  # vertical datum - encoding method
                  if hDatum.has_key?('encodingMethod')
                     unless hDatum['encodingMethod'] == ''
                        intDatum[:encodingMethod] = hDatum['encodingMethod']
                        haveOthers += 1
                     end
                  end

                  # vertical datum - is depth system {Boolean} (required)
                  if hDatum.has_key?('isDepthSystem')
                     if hDatum['isDepthSystem'] === true
                        intDatum[:isDepthSystem] = true
                     end
                  end

                  # vertical datum - vertical resolution
                  if hDatum.has_key?('verticalResolution')
                     unless hDatum['verticalResolution'] == ''
                        intDatum[:verticalResolution] = hDatum['verticalResolution']
                        haveOthers += 1
                     end
                  end

                  # vertical datum - unit of measure
                  if hDatum.has_key?('unitOfMeasure')
                     unless hDatum['unitOfMeasure'] == ''
                        intDatum[:unitOfMeasure] = hDatum['unitOfMeasure']
                        haveOthers += 1
                     end
                  end

                  # error messages
                  if intDatum[:datumIdentifier].empty? && haveOthers != 4
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson vertical datum must have an identifier or all other elements'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intDatum
               end

            end

         end
      end
   end
end
