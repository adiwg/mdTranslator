# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-10-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeographicResolution

               def self.unpack(hGeoRes, responseObj)

                  # return nil object if input is empty
                  if hGeoRes.empty?
                     responseObj[:readerExecutionMessages] << 'Geographic Resolution object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoRes = intMetadataClass.newGeographicResolution

                  # geographic resolution - latitude resolution (required)
                  if hGeoRes.has_key?('latitudeResolution')
                     # careful here: .to_f converts nil and '' to 0.0
                     latRes = hGeoRes['latitudeResolution']
                     unless latRes.nil? || latRes == ''
                        intGeoRes[:latitudeResolution] = latRes.to_f
                     end
                  end
                  if intGeoRes[:latitudeResolution].nil? || intGeoRes[:latitudeResolution] == ''
                     responseObj[:readerExecutionMessages] << 'Geographic Resolution is missing latitude resolution'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geographic resolution - longitude resolution (required)
                  if hGeoRes.has_key?('longitudeResolution')
                     # careful here: .to_f converts nil and '' to 0.0
                     lonRes = hGeoRes['longitudeResolution']
                     unless lonRes.nil? || lonRes == ''
                        intGeoRes[:longitudeResolution] = lonRes.to_f
                     end
                  end
                  if intGeoRes[:longitudeResolution].nil? || intGeoRes[:longitudeResolution] == ''
                     responseObj[:readerExecutionMessages] << 'Geographic Resolution is missing longitude resolution'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geographic resolution - unit of measure (required)
                  if hGeoRes.has_key?('unitOfMeasure')
                     intGeoRes[:unitOfMeasure] = hGeoRes['unitOfMeasure']
                  end
                  if intGeoRes[:unitOfMeasure].nil? || intGeoRes[:unitOfMeasure] == ''
                     responseObj[:readerExecutionMessages] << 'Geographic resolution is missing unit of measure'
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
