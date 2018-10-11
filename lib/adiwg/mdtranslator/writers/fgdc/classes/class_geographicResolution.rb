# FGDC <<Class>> GeographicResolution
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-19 refactored error and warning messaging
#  Stan Smith 2017-12-29 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class GeographicResolution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hGeoRes, inContext = nil)
                  
                  # horizontal reference 4.1.1 (geograph) - geographic resolution

                  # geographic resolution 4.1.1.1 (latres) - latitude resolution (required)
                  unless hGeoRes[:latitudeResolution].nil?
                     @xml.tag!('latres', hGeoRes[:latitudeResolution]).to_s
                  end
                  if hGeoRes[:latitudeResolution].nil?
                     @NameSpace.issueWarning(160, 'latres')
                  end

                  # geographic resolution 4.1.1.2 (longres) - longitude resolution (required)
                  unless hGeoRes[:longitudeResolution].nil?
                     @xml.tag!('longres', hGeoRes[:longitudeResolution]).to_s
                  end
                  if hGeoRes[:longitudeResolution].nil?
                     @NameSpace.issueWarning(161, 'longres')
                  end

                  # geographic resolution 4.1.1.3 (geogunit) - longitude resolution (required)
                  unless hGeoRes[:unitOfMeasure].nil?
                     @xml.tag!('geogunit', hGeoRes[:unitOfMeasure])
                  end
                  if hGeoRes[:unitOfMeasure].nil?
                     @NameSpace.issueWarning(162, 'geogunit')
                  end

               end # writeXML
            end # GeographicResolution

         end
      end
   end
end
