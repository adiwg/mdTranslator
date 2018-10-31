# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-10-09 refactor mdJson projection object
#  Stan Smith 2018-03-20 refactored error and warning messaging
#  Stan Smith 2018-01-15 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class LocalSystem

               def initialize(xml, hResponseObj, inContext = nil)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hProjection, inContext = nil)

                  # localSYSTEM is not the same as localPLANAR in fgdc
                  # however they use the same 'local' object
                  # local system sets projectionIdentifier.identifier = 'localSystem'
                  # local planar sets projectionIdentifier.identifier = 'localPlanar'

                  hProjectionId = hProjection[:projectionIdentifier]
                  hLocal = hProjection[:local]

                  outContext = 'local system'
                  outContext = inContext + ' '  + outContext unless inContext.nil?

                  if hLocal.empty?
                     @NameSpace.issueError(250, outContext)
                     return
                  end

                  if hProjectionId[:identifier] == 'localSystem'
                     hProjectionId[:name] = nil unless hProjectionId.has_key?(:name)
                     if hProjectionId[:name].nil?
                        hProjectionId[:name] = 'Local Coordinate System'
                     end
                  end

                  # local system 4.1.3.1 (localdes) - local coordinate system description (required)
                  unless hLocal[:description].nil?
                     @xml.tag!('localdes', hLocal[:description])
                  end
                  if hLocal[:description].nil?
                     @NameSpace.issueError(251, outContext)
                  end

                  # local system 4.1.3.2 (localgeo) - local coordinate system georeference information (required)
                  unless hLocal[:georeference].nil?
                     @xml.tag!('localgeo', hLocal[:georeference])
                  end
                  if hLocal[:georeference].nil?
                     @NameSpace.issueError(252, outContext)
                  end

               end # writeXML
            end # LocalSystem

         end
      end
   end
end
