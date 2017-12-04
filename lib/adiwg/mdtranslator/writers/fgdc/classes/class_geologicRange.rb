# FGDC <<Class>> GeologicRange
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-24 original script

require_relative 'class_geologicAge'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class GeologicRange

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hAgeStart, hAgeEnd)

                  # classes used
                  ageClass = GeologicAge.new(@xml, @hResponseObj)

                  # geologic age range (beggeol) - starting geologic age (required)
                  unless hAgeStart.empty?
                     @xml.tag!('beggeol') do
                        ageClass.writeXML(hAgeStart)
                     end
                  end
                  if hAgeStart.empty?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Geologic Age Range is missing starting age'
                  end

                  # geologic age range (endgeol) - ending geologic age (required)
                  unless hAgeStart.empty?
                     @xml.tag!('endgeol') do
                        ageClass.writeXML(hAgeEnd)
                     end
                  end
                  if hAgeEnd.empty?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Geologic Age Range is missing ending age'
                  end

               end # writeXML
            end # GeologicAge

         end
      end
   end
end
