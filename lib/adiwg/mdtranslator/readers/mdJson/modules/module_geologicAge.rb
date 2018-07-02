# unpack geologic age
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-20 refactored error and warning messaging
# 	Stan Smith 2017-11-07 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeologicAge

               def self.unpack(hGeoAge, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGeoAge.empty?
                     @MessagePath.issueWarning(350, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoAge = intMetadataClass.newGeologicAge

                  outContext = 'geologic age'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # geologic age - time scale (required)
                  if hGeoAge.has_key?('ageTimeScale')
                     intGeoAge[:ageTimeScale] = hGeoAge['ageTimeScale']
                  end
                  if intGeoAge[:ageTimeScale].nil? || intGeoAge[:ageTimeScale] == ''
                     @MessagePath.issueError(351, responseObj, inContext)
                  end

                  # geologic age - age estimate (required)
                  if hGeoAge.has_key?('ageEstimate')
                     intGeoAge[:ageEstimate] = hGeoAge['ageEstimate']
                  end
                  if intGeoAge[:ageEstimate].nil? || intGeoAge[:ageEstimate] == ''
                     @MessagePath.issueError(352, responseObj, inContext)
                  end

                  # geologic age - age uncertainty
                  if hGeoAge.has_key?('ageUncertainty')
                     unless hGeoAge['ageUncertainty'] == ''
                        intGeoAge[:ageUncertainty] = hGeoAge['ageUncertainty']
                     end
                  end

                  # geologic age - age explanation
                  if hGeoAge.has_key?('ageExplanation')
                     unless hGeoAge['ageExplanation'] == ''
                        intGeoAge[:ageExplanation] = hGeoAge['ageExplanation']
                     end
                  end

                  # geologic age - age reference [] {citation}
                  if hGeoAge.has_key?('ageReference')
                     hGeoAge['ageReference'].each do |hCitation|
                        unless hCitation.empty?
                           hReturn = Citation.unpack(hCitation, responseObj, outContext)
                           unless hReturn.nil?
                              intGeoAge[:ageReferences] << hReturn
                           end
                        end
                     end
                  end

                  return intGeoAge

               end

            end

         end
      end
   end
end
