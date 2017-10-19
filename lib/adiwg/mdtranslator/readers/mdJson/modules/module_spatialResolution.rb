# unpack spatial resolution
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2017-10-19 add geographic resolution
#  Stan Smith 2017-10-19 add bearingDistance resolution
#  Stan Smith 2017-10-19 add coordinate resolution
#  Stan Smith 2016-10-17 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-11-26 original script

require_relative 'module_measure'
require_relative 'module_coordinateResolution'
require_relative 'module_bearingDistanceResolution'
require_relative 'module_geographicResolution'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module SpatialResolution

               def self.unpack(hResolution, responseObj)

                  # return nil object if input is empty
                  if hResolution.empty?
                     responseObj[:readerExecutionMessages] << 'Spatial Resolution object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intResolution = intMetadataClass.newSpatialResolution
                  haveOne = false

                  # spatial resolution - scale factor (required if not others)
                  if hResolution.has_key?('scaleFactor')
                     if hResolution['scaleFactor'] != ''
                        intResolution[:scaleFactor] = hResolution['scaleFactor']
                        haveOne = true
                     end
                  end

                  # spatial resolution - measure (required if not others)
                  if hResolution.has_key?('measure')
                     hMeasure = hResolution['measure']
                     unless hMeasure.empty?
                        hObject = Measure.unpack(hMeasure, responseObj)
                        unless hObject.nil?
                           intResolution[:measure] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # spatial resolution - coordinate resolution (required if not others)
                  if hResolution.has_key?('coordinateResolution')
                     hCoordRes = hResolution['coordinateResolution']
                     unless hCoordRes.empty?
                        hReturn = CoordinateResolution.unpack(hCoordRes, responseObj)
                        unless hReturn.nil?
                           intResolution[:coordinateResolution] = hReturn
                           haveOne = true
                        end
                     end
                  end

                  # spatial resolution - bearing distance resolution (required if not others)
                  if hResolution.has_key?('bearingDistanceResolution')
                     hBearRes = hResolution['bearingDistanceResolution']
                     unless hBearRes.empty?
                        hReturn = BearingDistanceResolution.unpack(hBearRes, responseObj)
                        unless hReturn.nil?
                           intResolution[:bearingDistanceResolution] = hReturn
                           haveOne = true
                        end
                     end
                  end

                  # spatial resolution - geographic resolution (required if not others)
                  if hResolution.has_key?('geographicResolution')
                     hGeoRes = hResolution['geographicResolution']
                     unless hGeoRes.empty?
                        hReturn = GeographicResolution.unpack(hGeoRes, responseObj)
                        unless hReturn.nil?
                           intResolution[:geographicResolution] = hReturn
                           haveOne = true
                        end
                     end
                  end

                  # spatial resolution - level of detail (required if not others)
                  if hResolution.has_key?('levelOfDetail')
                     if hResolution['levelOfDetail'] != ''
                        intResolution[:levelOfDetail] = hResolution['levelOfDetail']
                        haveOne = true
                     end
                  end

                  unless haveOne
                     responseObj[:readerExecutionMessages] << 'Spatial Resolution did not have an object of supported type'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intResolution

               end

            end

         end
      end
   end
end
