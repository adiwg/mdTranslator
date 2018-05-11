# FGDC <<Class>> GeologicAge
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-19 refactored error and warning messaging
#  Stan Smith 2017-11-24 original script

require_relative '../fgdc_writer'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class GeologicAge

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hGeoAge)

                  # classes used
                  citationClass = Citation.new(@xml, @hResponseObj)

                  # geologic age (geolscal) - geologic scale (required)
                  unless hGeoAge[:ageTimeScale].nil?
                     @xml.tag!('geolscal', hGeoAge[:ageTimeScale])
                  end
                  if hGeoAge[:ageTimeScale].nil?
                     @NameSpace.issueWarning(170, 'geolscal')
                  end

                  # geologic age (geolest) - age estimate (required)
                  unless hGeoAge[:ageEstimate].nil?
                     @xml.tag!('geolest', hGeoAge[:ageEstimate])
                  end
                  if hGeoAge[:ageEstimate].nil?
                     @NameSpace.issueWarning(171, 'geolest')
                  end

                  # geologic age (geolun) - age uncertainty
                  unless hGeoAge[:ageUncertainty].nil?
                     @xml.tag!('geolun', hGeoAge[:ageUncertainty])
                  end
                  if hGeoAge[:ageUncertainty].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('geolun')
                  end

                  # geologic age (geolexpl) - age determination methodology
                  unless hGeoAge[:ageExplanation].nil?
                     @xml.tag!('geolexpl', hGeoAge[:ageExplanation])
                  end
                  if hGeoAge[:ageExplanation].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('geolexpl')
                  end

                  # geologic age (geolcit) - age references [{citation}]
                  hGeoAge[:ageReferences].each do |hCitation|
                     unless hCitation.empty?
                        @xml.tag!('geolcit') do
                           citationClass.writeXML(hCitation, [], 'geologic age')
                        end
                     end
                  end
                  if hGeoAge[:ageReferences].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('geolcit')
                  end

               end # writeXML
            end # GeologicAge

         end
      end
   end
end
