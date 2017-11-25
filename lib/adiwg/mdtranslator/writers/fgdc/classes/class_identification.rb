# FGDC <<Class>> Identification Information
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-17 original script

require_relative 'class_citation'
require_relative 'class_description'
require_relative 'class_timePeriod'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Identification

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(intObj)

                  # classes used
                  citationClass = Citation.new(@xml, @hResponseObj)
                  descriptionClass = Description.new(@xml, @hResponseObj)
                  timePeriodClass = TimePeriod.new(@xml, @hResponseObj)

                  hResourceInfo = intObj[:metadata][:resourceInfo]

                  @xml.tag!('idinfo') do

                     # identification information 1.1 (citation) - citation (required)
                     # <- hResourceInfo[:citation]
                     hCitation = hResourceInfo[:citation]
                     aAssocResource = intObj[:metadata][:associatedResources]
                     unless hCitation.empty?
                        @xml.tag!('citation') do
                           citationClass.writeXML(hCitation, aAssocResource)
                        end
                     end
                     if hCitation.empty?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section missing citation'
                     end

                     # identification information 1.2 (descript) - description (required)
                     # <- hResourceInfo[:abstract,:purpose,:supplementalInfo] (required)
                     unless hResourceInfo[:abstract].nil? && hResourceInfo[:purpose].nil? && hResourceInfo[:supplementalInfo].nil?
                        @xml.tag!('descript') do
                           descriptionClass.writeXML(hResourceInfo)
                        end
                     end
                     if hResourceInfo[:abstract].nil?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section missing abstract'
                     end
                     if hResourceInfo[:purpose].nil?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section missing purpose'
                     end

                     # identification information 1.3 (timeperd) - time period of content (required)
                     # <- hResourceInfo[:timePeriod]
                     unless hResourceInfo[:timePeriod].empty?
                        @xml.tag!('timeperd') do
                           timePeriodClass.writeXML(hResourceInfo[:timePeriod])
                        end
                     end
                     if hResourceInfo[:timePeriod].empty?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section missing time period'
                     end


                     # identification information 1.4 (status) - status (required)
                     # identification information 1.5 (spdom) - spatial domain
                     # identification information 1.6 (keywords) - keywords (required)
                     # identification information bio (taxonomy) - taxonomy
                     # identification information 1.7 (accconst) - access constraint (required)
                     # identification information 1.8 (useconst) - use constraint (required)
                     # identification information 1.9 (ptcontac) - point of contact (required)
                     # identification information 1.10 (browse) - browse graphic []
                     # identification information 1.11 (datacred) - dataset credit
                     # identification information 1.12 (secinfo) - security information
                     # identification information 1.13 (native) - native dataset environment
                     # identification information 1.14 (crossref) - cross reference []
                     # identification information bio (tool) - analytical tool [] (not supported)

                  end # idinfo tag
               end # writeXML
            end # Identification

         end
      end
   end
end
