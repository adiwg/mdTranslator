# Reader - fgdc to internal data structure
# unpack fgdc bio geologic age

# History:
#  Stan Smith 2017-11-06 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module GeologicAge

               def self.unpack(xGeoAge, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoAge = intMetadataClass.newGeologicAge

                  # geologic age bio (geolscal) - time scale (required)
                  scale = xGeoAge.xpath('./geolscal').text
                  unless scale.empty?
                     intGeoAge[:ageTimeScale] = scale
                  end
                  if scale.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: BIO geologic age time scale is missing'
                  end

                  # geologic age bio (geolest) - age estimate (required)
                  estimate = xGeoAge.xpath('./geolest').text
                  unless estimate.empty?
                     intGeoAge[:ageEstimate] = estimate
                  end
                  if estimate.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: BIO geologic age estimate is missing'
                  end

                  # geologic age bio (geolun) - age estimate uncertainty
                  uncertain = xGeoAge.xpath('./geolun').text
                  unless uncertain.empty?
                     intGeoAge[:ageUncertainty] = uncertain
                  end

                  # geologic age bio (geolexpl) - explanation
                  explain = xGeoAge.xpath('./geolexpl').text
                  unless explain.empty?
                     intGeoAge[:ageExplanation] = explain
                  end

                  # geologic age bio (geolcit) - age references [] {citation}
                  axReferences = xGeoAge.xpath('./geolcit')
                  unless axReferences.empty?
                     axReferences.each do |xCitation|
                        hCitation = Citation.unpack(xCitation, hResponseObj)
                        intGeoAge[:ageReferences] << hCitation unless hCitation.nil?
                     end
                  end

                  return intGeoAge

               end

            end

         end
      end
   end
end
