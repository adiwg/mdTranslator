# unpack spatial reference system ellipsoid
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-10-23 original script

require_relative 'module_identifier'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Geodetic

               def self.unpack(hGeodetic, responseObj)

                  # return nil object if input is empty
                  if hGeodetic.empty?
                     responseObj[:readerExecutionMessages] << 'Geodetic object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeodetic = intMetadataClass.newGeodetic

                  # geodetic - datum identifier {identifier}
                  if hGeodetic.has_key?('datumIdentifier')
                     unless hGeodetic['datumIdentifier'].empty?
                        hReturn = Identifier.unpack(hGeodetic['datumIdentifier'], responseObj)
                        unless hReturn.nil?
                           intGeodetic[:datumIdentifier] = hReturn
                        end
                     end
                  end

                  # geodetic - datum name
                  if hGeodetic.has_key?('datumName')
                     if hGeodetic['datumName'] != ''
                        intGeodetic[:datumName] = hGeodetic['datumName']
                     end
                  end

                  # geodetic - ellipsoid identifier {identifier}
                  if hGeodetic.has_key?('ellipsoidIdentifier')
                     unless hGeodetic['ellipsoidIdentifier'].empty?
                        hReturn = Identifier.unpack(hGeodetic['ellipsoidIdentifier'], responseObj)
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
                     responseObj[:readerExecutionMessages] << 'Ellipsoid name is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geodetic - semi-major axis
                  if hGeodetic.has_key?('semiMajorAxis')
                     if hGeodetic['semiMajorAxis'] != ''
                        intGeodetic[:semiMajorAxis] = hGeodetic['semiMajorAxis']
                     end
                  end

                  # geodetic - axis units
                  if hGeodetic.has_key?('axisUnits')
                     if hGeodetic['axisUnits'] != ''
                        intGeodetic[:axisUnits] = hGeodetic['axisUnits']
                     end
                  end

                  # geodetic - denominator of flattening ratio
                  if hGeodetic.has_key?('denominatorOfFlatteningRatio')
                     if hGeodetic['denominatorOfFlatteningRatio'] != ''
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
