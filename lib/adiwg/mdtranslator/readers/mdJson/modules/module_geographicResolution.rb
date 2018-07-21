# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-19 refactored error and warning messaging
# 	Stan Smith 2017-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeographicResolution

               def self.unpack(hGeoRes, responseObj, outContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  outContext = 'spatial resolution'

                  # return nil object if input is empty
                  if hGeoRes.empty?
                     @MessagePath.issueWarning(330, responseObj, outContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoRes = intMetadataClass.newGeographicResolution

                  # geographic resolution - latitude resolution (required)
                  if hGeoRes.has_key?('latitudeResolution')
                     intGeoRes[:latitudeResolution] = hGeoRes['latitudeResolution']
                  end
                  if intGeoRes[:latitudeResolution].nil? || intGeoRes[:latitudeResolution] == ''
                     @MessagePath.issueError(331, responseObj, outContext)
                  end

                  # geographic resolution - longitude resolution (required)
                  if hGeoRes.has_key?('longitudeResolution')
                     intGeoRes[:longitudeResolution] = hGeoRes['longitudeResolution']
                  end
                  if intGeoRes[:longitudeResolution].nil? || intGeoRes[:longitudeResolution] == ''
                     @MessagePath.issueError(332, responseObj, outContext)
                  end

                  # geographic resolution - unit of measure (required)
                  if hGeoRes.has_key?('unitOfMeasure')
                     intGeoRes[:unitOfMeasure] = hGeoRes['unitOfMeasure']
                  end
                  if intGeoRes[:unitOfMeasure].nil? || intGeoRes[:unitOfMeasure] == ''
                     @MessagePath.issueError(333, responseObj, outContext)
                  end

                  return intGeoRes

               end

            end

         end
      end
   end
end
