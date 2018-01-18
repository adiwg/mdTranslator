# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-15 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class GeodeticReference

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGeodetic)

                  # geodetic reference system 4.1.4.1 (horizdn) - horizontal datum name
                  unless hGeodetic[:datumName].nil?
                     @xml.tag!('horizdn', hGeodetic[:datumName])
                  end
                  if hGeodetic[:datumName].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('horizdn')
                  end

                  # geodetic reference system 4.1.4.2 (ellips) - ellipsoid name (required)
                  unless hGeodetic[:ellipsoidName].nil?
                     @xml.tag!('ellips', hGeodetic[:ellipsoidName])
                  end
                  if hGeodetic[:ellipsoidName].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Geodetic Coordinate System is missing ellipsoid name'
                  end

                  # geodetic reference system 4.1.4.3 (semiaxis) - ellipsoid semi-major axis (required)
                  unless hGeodetic[:semiMajorAxis].nil?
                     @xml.tag!('semiaxis', hGeodetic[:semiMajorAxis])
                  end
                  if hGeodetic[:semiMajorAxis].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Geodetic Coordinate System is missing semi-major axis'
                  end

                  # geodetic reference system 4.1.4.4 (denflat) - ellipsoid denominator of flattening ratio (required)
                  unless hGeodetic[:denominatorOfFlatteningRatio].nil?
                     @xml.tag!('denflat', hGeodetic[:denominatorOfFlatteningRatio])
                  end
                  if hGeodetic[:denominatorOfFlatteningRatio].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Geodetic Coordinate System is missing denominator of flattening ratio'
                  end

               end # writeXML
            end # GeodeticReference

         end
      end
   end
end
