# unpack spatial reference system ellipsoid
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-10-23 original script

require_relative 'module_identifier'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Ellipsoid

               def self.unpack(hEllipsoid, responseObj)

                  # return nil object if input is empty
                  if hEllipsoid.empty?
                     responseObj[:readerExecutionMessages] << 'Ellipsoid object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intEllipsoid = intMetadataClass.newEllipsoid

                  # ellipsoid - identifier {identifier}
                  if hEllipsoid.has_key?('ellipsoidIdentifier')
                     unless hEllipsoid['ellipsoidIdentifier'].empty?
                        hReturn = Identifier.unpack(hEllipsoid['ellipsoidIdentifier'], responseObj)
                        unless hReturn.nil?
                           intEllipsoid[:ellipsoidIdentifier] = hReturn
                        end
                     end
                  end

                  # ellipsoid - ellipsoid name (required)
                  if hEllipsoid.has_key?('ellipsoidName')
                     intEllipsoid[:ellipsoidName] = hEllipsoid['ellipsoidName']
                  end
                  if intEllipsoid[:ellipsoidName].nil? || intEllipsoid[:ellipsoidName] == ''
                     responseObj[:readerExecutionMessages] << 'Ellipsoid name is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # ellipsoid - semi-major axis
                  if hEllipsoid.has_key?('semiMajorAxis')
                     if hEllipsoid['semiMajorAxis'] != ''
                        intEllipsoid[:semiMajorAxis] = hEllipsoid['semiMajorAxis']
                     end
                  end

                  # ellipsoid - axis units
                  if hEllipsoid.has_key?('axisUnits')
                     if hEllipsoid['axisUnits'] != ''
                        intEllipsoid[:axisUnits] = hEllipsoid['axisUnits']
                     end
                  end

                  # ellipsoid - denominator of flattening ratio
                  if hEllipsoid.has_key?('denominatorOfFlatteningRatio')
                     if hEllipsoid['denominatorOfFlatteningRatio'] != ''
                        intEllipsoid[:denominatorOfFlatteningRatio] = hEllipsoid['denominatorOfFlatteningRatio']
                     end
                  end

                  return intEllipsoid
               end

            end

         end
      end
   end
end
