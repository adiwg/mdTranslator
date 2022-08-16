# unpack georeferenceable representation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-20 refactored error and warning messaging
# 	Stan Smith 2016-10-19 original script

require_relative 'module_gridRepresentation'
require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeoreferenceableRepresentation

               def self.unpack(hGeoRef, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGeoRef.empty?
                     @MessagePath.issueWarning(410, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoRef = intMetadataClass.newGeoreferenceableInfo

                  outContext = 'georeferenceable representation'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # georeferenceable representation - grid representation (required)
                  if hGeoRef.has_key?('gridRepresentation')
                     hObject = hGeoRef['gridRepresentation']
                     unless hObject.empty?
                        hReturn = GridRepresentation.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intGeoRef[:gridRepresentation] = hReturn
                        end
                     end
                  end
                  if intGeoRef[:gridRepresentation].empty?
                     @MessagePath.issueError(411, responseObj, inContext)
                  end

                  # georeferenceable representation - control point availability (required)
                  if hGeoRef.has_key?('controlPointAvailable')
                     if hGeoRef['controlPointAvailable'] === true
                        intGeoRef[:controlPointAvailable] = hGeoRef['controlPointAvailable']
                     end
                  end

                  # georeferenceable representation - orientation parameter availability (required)
                  if hGeoRef.has_key?('orientationParameterAvailable')
                     if hGeoRef['orientationParameterAvailable'] === true
                        intGeoRef[:orientationParameterAvailable] = hGeoRef['orientationParameterAvailable']
                     end
                  end

                  # georeferenceable representation - orientation parameter description
                  if hGeoRef.has_key?('orientationParameterDescription')
                     unless hGeoRef['orientationParameterDescription'] == ''
                        intGeoRef[:orientationParameterDescription] = hGeoRef['orientationParameterDescription']
                     end
                  end

                  # georeferenceable representation - georeferenced parameter (required)
                  if hGeoRef.has_key?('georeferencedParameter')
                     unless hGeoRef['georeferencedParameter'] == ''
                        intGeoRef[:georeferencedParameter] = hGeoRef['georeferencedParameter']
                     end
                  end
                  if intGeoRef[:georeferencedParameter].nil?
                     @MessagePath.issueError(412, responseObj, inContext)
                  end

                  # georeferenceable representation - parameter citation [citation]
                  if hGeoRef.has_key?('parameterCitation')
                     aCitation = hGeoRef['parameterCitation']
                     aCitation.each do |item|
                        hCitation = Citation.unpack(item, responseObj, outContext)
                        unless hCitation.nil?
                           intGeoRef[:parameterCitation] << hCitation
                        end
                     end
                  end

                  if hGeoRef.has_key?('scope')
                     hGeoRef['scope'].each do |item|
                        scope = Scope.unpack(item, responseObj, inContext)
                        unless scope.nil?
                           intGeoRef[:scope] << scope
                        end
                     end
                  end

                  return intGeoRef

               end

            end

         end
      end
   end
end
