# unpack spatial reference system ellipsoid
# Reader - ADIwg JSON to internal data structure

# History:
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

                  # geodetic - datum name
                  if hGeodetic.has_key?('datumName')
                     unless hGeodetic['datumName'] == ''
                        intGeodetic[:datumName] = hGeodetic['datumName']
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

                  # geodetic - ellipsoid name (required)
                  if hGeodetic.has_key?('ellipsoidName')
                     intGeodetic[:ellipsoidName] = hGeodetic['ellipsoidName']
                  end
                  if intGeodetic[:ellipsoidName].nil? || intGeodetic[:ellipsoidName] == ''
                     @MessagePath.issueError(311, responseObj, inContext)
                  end

                  # geodetic - semi-major axis
                  if hGeodetic.has_key?('semiMajorAxis')
                     unless hGeodetic['semiMajorAxis'] == ''
                        intGeodetic[:semiMajorAxis] = hGeodetic['semiMajorAxis']
                     end
                  end

                  # geodetic - axis units
                  if hGeodetic.has_key?('axisUnits')
                     unless['axisUnits'] == ''
                        intGeodetic[:axisUnits] = hGeodetic['axisUnits']
                     end
                  end

                  # geodetic - denominator of flattening ratio
                  if hGeodetic.has_key?('denominatorOfFlatteningRatio')
                     unless hGeodetic['denominatorOfFlatteningRatio'] == ''
                        intGeodetic[:denominatorOfFlatteningRatio] = hGeodetic['denominatorOfFlatteningRatio']
                     end
                  end

                  return intGeodetic
               end

            end

         end
      end
   end
end
