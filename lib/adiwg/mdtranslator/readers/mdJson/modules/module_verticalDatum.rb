# unpack spatial reference system vertical datum
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-09-26 datumName is deprecated, use datumIdentifier.identifier
#  Stan Smith 2018-06-27 refactored error and warning messaging
# 	Stan Smith 2017-10-23 original script

require_relative 'module_identifier'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module VerticalDatum

               def self.unpack(hDatum, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hDatum.empty?
                     @MessagePath.issueWarning(920, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDatum = intMetadataClass.newVerticalDatum

                  outContext = 'vertical datum'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # vertical datum - identifier {identifier} (required)
                  if hDatum.has_key?('datumIdentifier')
                     unless hDatum['datumIdentifier'].empty?
                        hReturn = Identifier.unpack(hDatum['datumIdentifier'], responseObj, outContext)
                        unless hReturn.nil?
                           intDatum[:datumIdentifier] = hReturn
                        end
                     end
                  end
                  if intDatum[:datumIdentifier].empty?
                     @MessagePath.issueError(921, responseObj, inContext)
                  end

                  # TODO remove when mdJson version 3
                  # vertical datum - datum name (deprecated), move to datumIdentifier
                  # skip datumName if identifier is already present
                  if hDatum.has_key?('datumName')
                     unless hDatum['datumName'] == ''
                        @MessagePath.issueWarning(922, responseObj, inContext)
                        if intDatum[:datumIdentifier].empty?
                           intDatum[:datumIdentifier] = intMetadataClass.newIdentifier
                           intDatum[:datumIdentifier][:identifier] = hDatum['datumName']
                           @MessagePath.issueNotice(925, responseObj, inContext)
                           @MessagePath.issueNotice(923, responseObj, inContext)
                        end
                     end
                  end

                  haveOthers  = 0

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
                  unless haveOthers == 0 || haveOthers == 3
                     @MessagePath.issueError(924, responseObj, inContext)
                  end

                  return intDatum

               end

            end

         end
      end
   end
end
