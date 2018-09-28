# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-09-27 deprecated datumName and ellipsoidName
#  Stan Smith 2018-03-18 refactored error and warning messaging
#  Stan Smith 2018-01-15 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class GeodeticReference

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hGeodetic)

                  # geodetic reference system 4.1.4.1 (horizdn) - horizontal datum name
                  unless hGeodetic[:datumIdentifier].empty?
                     @xml.tag!('horizdn', hGeodetic[:datumIdentifier][:identifier])
                  end
                  if hGeodetic[:datumIdentifier].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('horizdn')
                  end

                  # geodetic reference system 4.1.4.2 (ellips) - ellipsoid name (required)
                  unless hGeodetic[:ellipsoidIdentifier].empty?
                     @xml.tag!('ellips', hGeodetic[:ellipsoidIdentifier][:identifier])
                  end
                  if hGeodetic[:ellipsoidIdentifier].nil?
                     @NameSpace.issueWarning(150, 'ellips')
                  end

                  # geodetic reference system 4.1.4.3 (semiaxis) - ellipsoid semi-major axis (required)
                  unless hGeodetic[:semiMajorAxis].nil?
                     @xml.tag!('semiaxis', hGeodetic[:semiMajorAxis])
                  end
                  if hGeodetic[:semiMajorAxis].nil?
                     @NameSpace.issueWarning(151, 'semiaxis')
                  end

                  # geodetic reference system 4.1.4.4 (denflat) - ellipsoid denominator of flattening ratio (required)
                  unless hGeodetic[:denominatorOfFlatteningRatio].nil?
                     @xml.tag!('denflat', hGeodetic[:denominatorOfFlatteningRatio])
                  end
                  if hGeodetic[:denominatorOfFlatteningRatio].nil?
                     @NameSpace.issueWarning(152, 'denflat')
                  end

               end # writeXML
            end # GeodeticReference

         end
      end
   end
end
