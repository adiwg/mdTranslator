# unpack geologic age
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2017-11-07 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeologicAge

               def self.unpack(hGeoAge, responseObj)

                  # return nil object if input is empty
                  if hGeoAge.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: geologic age object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoAge = intMetadataClass.newGeologicAge

                  # geologic age - time scale (required)
                  if hGeoAge.has_key?('ageTimeScale')
                     intGeoAge[:ageTimeScale] = hGeoAge['ageTimeScale']
                  end
                  if intGeoAge[:ageTimeScale].nil? || intGeoAge[:ageTimeScale] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: geologic age time scale is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geologic age - age estimate (required)
                  if hGeoAge.has_key?('ageEstimate')
                     intGeoAge[:ageEstimate] = hGeoAge['ageEstimate']
                  end
                  if intGeoAge[:ageEstimate].nil? || intGeoAge[:ageEstimate] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: geologic age age-estimate is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
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
                           hReturn = Citation.unpack(hCitation, responseObj)
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
