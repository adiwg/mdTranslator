# unpack spatial reference system
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
#  Stan Smith 2018-01-10 added reference system WKT
#  Stan Smith 2017-10-23 added reference system parameter set
#  Stan Smith 2016-10-16 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-09-03 original script

require_relative 'module_identifier'
require_relative 'module_referenceSystemParameters'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module SpatialReferenceSystem

               def self.unpack(hSpatialRef, responseObj)

                  # return nil object if input is empty
                  if hSpatialRef.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson spatial reference system object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intSpatialRef = intMetadataClass.newSpatialReferenceSystem

                  haveSystem = false

                  # spatial reference system - type
                  if hSpatialRef.has_key?('referenceSystemType')
                     unless hSpatialRef['referenceSystemType'] == ''
                        intSpatialRef[:systemType] = hSpatialRef['referenceSystemType']
                        haveSystem = true
                     end
                  end

                  # spatial reference system - reference system {identifier}
                  if hSpatialRef.has_key?('referenceSystemIdentifier')
                     hObject = hSpatialRef['referenceSystemIdentifier']
                     unless hObject.empty?
                        hReturn = Identifier.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intSpatialRef[:systemIdentifier] = hReturn
                           haveSystem = true
                        end
                     end
                  end

                  # spatial reference system - wkt
                  if hSpatialRef.has_key?('referenceSystemWKT')
                     unless hSpatialRef['referenceSystemWKT'] == ''
                        intSpatialRef[:systemWKT] = hSpatialRef['referenceSystemWKT']
                        haveSystem = true
                     end
                  end

                  # spatial reference system - reference system parameters {referenceSystemParameterSet}
                  if hSpatialRef.has_key?('referenceSystemParameterSet')
                     hObject = hSpatialRef['referenceSystemParameterSet']
                     unless hObject.empty?
                        hReturn = ReferenceSystemParameters.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intSpatialRef[:systemParameterSet] = hReturn
                           haveSystem = true
                        end
                     end
                  end

                  unless haveSystem
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson spatial reference system must declare reference system type, identifier, WKT, or parameter set'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intSpatialRef
               end

            end

         end
      end
   end
end
