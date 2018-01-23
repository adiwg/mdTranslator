# FGDC <<Class>> GeographicResolution
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-12-29 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class GeographicResolution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeoRes)

                  # horizontal reference 4.1.1 (geograph) - geographic resolution

                  # geographic resolution 4.1.1.1 (latres) - latitude resolution (required)
                  unless hGeoRes[:latitudeResolution].nil?
                     @xml.tag!('latres', hGeoRes[:latitudeResolution]).to_s
                  end
                  if hGeoRes[:latitudeResolution].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Geographic Resolution is missing latitude resolution'
                  end

                  # geographic resolution 4.1.1.2 (longres) - longitude resolution (required)
                  unless hGeoRes[:longitudeResolution].nil?
                     @xml.tag!('longres', hGeoRes[:longitudeResolution]).to_s
                  end
                  if hGeoRes[:longitudeResolution].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Geographic Resolution is missing longitude resolution'
                  end

                  # geographic resolution 4.1.1.3 (geogunit) - longitude resolution (required)
                  unless hGeoRes[:unitOfMeasure].nil?
                     @xml.tag!('geogunit', hGeoRes[:unitOfMeasure])
                  end
                  if hGeoRes[:unitOfMeasure].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Geographic Resolution is missing unit of measure'
                  end

               end # writeXML
            end # GeographicResolution

         end
      end
   end
end
