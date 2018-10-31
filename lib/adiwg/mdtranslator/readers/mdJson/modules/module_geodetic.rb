# unpack spatial reference system ellipsoid
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-09-26 deprecated datumName and ellipseName
#  Stan Smith 2018-06-19 refactored error and warning messaging
# 	Stan Smith 2017-10-23 original script

require_relative 'module_identifier'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Geodetic

               def self.unpack(hGeodetic, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGeodetic.empty?
                     @MessagePath.issueWarning(310, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeodetic = intMetadataClass.newGeodetic

                  outContext = 'geodetic parameters'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # geodetic - datum identifier {identifier}
                  if hGeodetic.has_key?('datumIdentifier')
                     unless hGeodetic['datumIdentifier'].empty?
                        hReturn = Identifier.unpack(hGeodetic['datumIdentifier'], responseObj, outContext)
                        unless hReturn.nil?
                           intGeodetic[:datumIdentifier] = hReturn
                        end
                     end
                  end

                  # TODO remove when mdJson version 3
                  # geodetic - datum name (deprecated), move to datumIdentifier
                  # skip datumName if identifier is already present
                  if hGeodetic.has_key?('datumName')
                     unless hGeodetic['datumName'] == ''
                        @MessagePath.issueWarning(311, responseObj, inContext)
                        if intGeodetic[:datumIdentifier].empty?
                           intGeodetic[:datumIdentifier] = intMetadataClass.newIdentifier
                           intGeodetic[:datumIdentifier][:identifier] = hGeodetic['datumName']
                           @MessagePath.issueNotice(313, responseObj, inContext)
                           @MessagePath.issueNotice(315, responseObj, inContext)
                        end
                     end
                  end

                  # geodetic - ellipsoid identifier {identifier}
                  if hGeodetic.has_key?('ellipsoidIdentifier')
                     unless hGeodetic['ellipsoidIdentifier'].empty?
                        hReturn = Identifier.unpack(hGeodetic['ellipsoidIdentifier'], responseObj, outContext)
                        unless hReturn.nil?
                           intGeodetic[:ellipsoidIdentifier] = hReturn
                        end
                     end
                  end

                  # TODO remove when mdJson version 3
                  # geodetic - ellipsoid name (deprecated), move to ellipsoidIdentifier
                  # skip ellipsoidName if identifier is already present
                  if hGeodetic.has_key?('ellipsoidName')
                     unless hGeodetic['ellipsoidName'] == ''
                        @MessagePath.issueWarning(312, responseObj, inContext)
                        if intGeodetic[:ellipsoidIdentifier].empty?
                           intGeodetic[:ellipsoidIdentifier] = intMetadataClass.newIdentifier
                           intGeodetic[:ellipsoidIdentifier][:identifier] = hGeodetic['ellipsoidName']
                           @MessagePath.issueNotice(314, responseObj, inContext)
                           @MessagePath.issueNotice(316, responseObj, inContext)
                        end
                     end
                  end

                  haveOthers = 0

                  # geodetic - semi-major axis
                  if hGeodetic.has_key?('semiMajorAxis')
                     unless hGeodetic['semiMajorAxis'] == ''
                        intGeodetic[:semiMajorAxis] = hGeodetic['semiMajorAxis']
                        haveOthers += 1
                     end
                  end

                  # geodetic - axis units
                  if hGeodetic.has_key?('axisUnits')
                     unless hGeodetic['axisUnits'] == ''
                        intGeodetic[:axisUnits] = hGeodetic['axisUnits']
                        haveOthers += 1
                     end
                  end

                  # geodetic - denominator of flattening ratio
                  if hGeodetic.has_key?('denominatorOfFlatteningRatio')
                     unless hGeodetic['denominatorOfFlatteningRatio'] == ''
                        intGeodetic[:denominatorOfFlatteningRatio] = hGeodetic['denominatorOfFlatteningRatio']
                        haveOthers += 1
                     end
                  end

                  # error messages
                  if intGeodetic[:ellipsoidIdentifier].empty?
                     unless haveOthers == 0
                        @MessagePath.issueError(317, responseObj, inContext)
                     end
                  else
                     unless haveOthers == 0 || haveOthers == 3
                        @MessagePath.issueError(317, responseObj, inContext)
                     end
                  end

                  return intGeodetic

               end

            end

         end
      end
   end
end
