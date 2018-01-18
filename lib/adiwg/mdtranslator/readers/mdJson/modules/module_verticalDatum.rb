# unpack spatial reference system vertical datum
# Reader - ADIwg JSON to internal data structure

# History:
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
                     responseObj[:readerExecutionMessages] << 'Vertical Datum object is empty'
                     responseObj[:readerExecutionPass] = false
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

                  # vertical datum - datum name
                  if hDatum.has_key?('datumName')
                     intDatum[:datumName] = hDatum['datumName']
                  end

                  # vertical datum - encoding method
                  if hDatum.has_key?('encodingMethod')
                     intDatum[:encodingMethod] = hDatum['encodingMethod']
                  end

                  # vertical datum - is depth system {Boolean} (required)
                  if hDatum.has_key?('isDepthSystem')
                     if hDatum['isDepthSystem'] === true
                        intDatum[:isDepthSystem] = true
                     end
                  end

                  # vertical datum - vertical resolution
                  if hDatum.has_key?('verticalResolution')
                     intDatum[:verticalResolution] = hDatum['verticalResolution']
                  end

                  # vertical datum - unit of measure
                  if hDatum.has_key?('unitOfMeasure')
                     intDatum[:unitOfMeasure] = hDatum['unitOfMeasure']
                  end

                  return intDatum
               end

            end

         end
      end
   end
end
