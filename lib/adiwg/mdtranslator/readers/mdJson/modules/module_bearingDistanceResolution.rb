# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module BearingDistanceResolution

               def self.unpack(hBearRes, responseObj)

                  # return nil object if input is empty
                  if hBearRes.empty?
                     responseObj[:readerExecutionMessages] << 'Bearing Distance Resolution object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intBearRes = intMetadataClass.newBearingDistanceResolution

                  # bearing distance resolution - distance resolution (required)
                  if hBearRes.has_key?('distanceResolution')
                     intBearRes[:distanceResolution] = hBearRes['distanceResolution']
                  end
                  if intBearRes[:distanceResolution].nil? || intBearRes[:distanceResolution] == ''
                     responseObj[:readerExecutionMessages] << 'Bearing Distance Resolution is missing distance resolution'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bearing distance resolution - distance unit of measure (required)
                  if hBearRes.has_key?('distanceUnitOfMeasure')
                     intBearRes[:distanceUnitOfMeasure] = hBearRes['distanceUnitOfMeasure']
                  end
                  if intBearRes[:distanceUnitOfMeasure].nil? || intBearRes[:distanceUnitOfMeasure] == ''
                     responseObj[:readerExecutionMessages] << 'Bearing Distance Resolution is missing distance unit of measure'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bearing distance resolution - bearing resolution (required)
                  if hBearRes.has_key?('bearingResolution')
                     intBearRes[:bearingResolution] = hBearRes['bearingResolution']
                  end
                  if intBearRes[:bearingResolution].nil? || intBearRes[:bearingResolution] == ''
                     responseObj[:readerExecutionMessages] << 'Bearing Distance Resolution is missing bearing resolution'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bearing distance resolution - bearing unit of measure (required)
                  if hBearRes.has_key?('bearingUnitOfMeasure')
                     intBearRes[:bearingUnitOfMeasure] = hBearRes['bearingUnitOfMeasure']
                  end
                  if intBearRes[:bearingUnitOfMeasure].nil? || intBearRes[:bearingUnitOfMeasure] == ''
                     responseObj[:readerExecutionMessages] << 'Bearing Distance resolution is missing bearing unit of measure'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bearing distance resolution - bearing reference direction (required)
                  if hBearRes.has_key?('bearingReferenceDirection')
                     intBearRes[:bearingReferenceDirection] = hBearRes['bearingReferenceDirection']
                  end
                  if intBearRes[:bearingReferenceDirection].nil? || intBearRes[:bearingReferenceDirection] == ''
                     responseObj[:readerExecutionMessages] << 'Bearing Distance Resolution is missing bearing direction'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # bearing distance resolution - bearing reference meridian (required)
                  if hBearRes.has_key?('bearingReferenceMeridian')
                     intBearRes[:bearingReferenceMeridian] = hBearRes['bearingReferenceMeridian']
                  end
                  if intBearRes[:bearingReferenceMeridian].nil? || intBearRes[:bearingReferenceMeridian] == ''
                     responseObj[:readerExecutionMessages] << 'Bearing Distance Resolution is missing bearing meridian'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intBearRes

               end

            end

         end
      end
   end
end
