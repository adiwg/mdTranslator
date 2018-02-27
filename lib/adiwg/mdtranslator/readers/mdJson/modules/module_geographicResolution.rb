# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2017-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeographicResolution

               def self.unpack(hGeoRes, responseObj)

                  # return nil object if input is empty
                  if hGeoRes.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: geographic spatial resolution object is empty'
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
                     responseObj[:readerExecutionMessages] <<
                        'WARNING: mdJson reader: geographic spatial resolution latitude resolution is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geographic resolution - longitude resolution (required)
                  if hGeoRes.has_key?('longitudeResolution')
                     intGeoRes[:longitudeResolution] = hGeoRes['longitudeResolution']
                  end
                  if intGeoRes[:longitudeResolution].nil? || intGeoRes[:longitudeResolution] == ''
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: geographic spatial resolution longitude resolution is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geographic resolution - unit of measure (required)
                  if hGeoRes.has_key?('unitOfMeasure')
                     intGeoRes[:unitOfMeasure] = hGeoRes['unitOfMeasure']
                  end
                  if intGeoRes[:unitOfMeasure].nil? || intGeoRes[:unitOfMeasure] == ''
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: geographic spatial resolution units are missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intGeoRes

               end

            end

         end
      end
   end
end
