# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-15 refactored error and warning messaging
# 	Stan Smith 2017-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module BearingDistanceResolution

               def self.unpack(hBearRes, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hBearRes.empty?
                     @MessagePath.issueWarning(60, responseObj, inContext)
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
                     @MessagePath.issueError(61, responseObj, inContext)
                  end

                  # bearing distance resolution - distance unit of measure (required)
                  if hBearRes.has_key?('distanceUnitOfMeasure')
                     intBearRes[:distanceUnitOfMeasure] = hBearRes['distanceUnitOfMeasure']
                  end
                  if intBearRes[:distanceUnitOfMeasure].nil? || intBearRes[:distanceUnitOfMeasure] == ''
                     @MessagePath.issueError(62, responseObj, inContext)
                  end

                  # bearing distance resolution - bearing resolution (required)
                  if hBearRes.has_key?('bearingResolution')
                     intBearRes[:bearingResolution] = hBearRes['bearingResolution']
                  end
                  if intBearRes[:bearingResolution].nil? || intBearRes[:bearingResolution] == ''
                     @MessagePath.issueError(63, responseObj, inContext)
                  end

                  # bearing distance resolution - bearing unit of measure (required)
                  if hBearRes.has_key?('bearingUnitOfMeasure')
                     intBearRes[:bearingUnitOfMeasure] = hBearRes['bearingUnitOfMeasure']
                  end
                  if intBearRes[:bearingUnitOfMeasure].nil? || intBearRes[:bearingUnitOfMeasure] == ''
                     @MessagePath.issueError(64, responseObj, inContext)
                  end

                  # bearing distance resolution - bearing reference direction (required)
                  if hBearRes.has_key?('bearingReferenceDirection')
                     intBearRes[:bearingReferenceDirection] = hBearRes['bearingReferenceDirection']
                  end
                  if intBearRes[:bearingReferenceDirection].nil? || intBearRes[:bearingReferenceDirection] == ''
                     @MessagePath.issueError(65, responseObj, inContext)
                  end

                  # bearing distance resolution - bearing reference meridian (required)
                  if hBearRes.has_key?('bearingReferenceMeridian')
                     intBearRes[:bearingReferenceMeridian] = hBearRes['bearingReferenceMeridian']
                  end
                  if intBearRes[:bearingReferenceMeridian].nil? || intBearRes[:bearingReferenceMeridian] == ''
                     @MessagePath.issueError(66, responseObj, inContext)
                  end

                  return intBearRes

               end

            end

         end
      end
   end
end
