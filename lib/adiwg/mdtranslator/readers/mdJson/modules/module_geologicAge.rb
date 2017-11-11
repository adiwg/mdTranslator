# unpack geologic age
# Reader - ADIwg JSON to internal data structure

# History:
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
                     responseObj[:readerExecutionMessages] << 'Geologic Age object is empty'
                     responseObj[:readerExecutionPass] = false
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
                     responseObj[:readerExecutionMessages] << 'Geologic Age is missing time scale'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geologic age - age estimate (required)
                  if hGeoAge.has_key?('ageEstimate')
                     intGeoAge[:ageEstimate] = hGeoAge['ageEstimate']
                  end
                  if intGeoAge[:ageEstimate].nil? || intGeoAge[:ageEstimate] == ''
                     responseObj[:readerExecutionMessages] << 'Geologic Age is missing age estimate'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geologic age - age uncertainty
                  if hGeoAge.has_key?('ageUncertainty')
                     if hGeoAge['ageUncertainty'] != ''
                        intGeoAge[:ageUncertainty] = hGeoAge['ageUncertainty']
                     end
                  end

                  # geologic age - age explanation
                  if hGeoAge.has_key?('ageExplanation')
                     if hGeoAge['ageExplanation'] != ''
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
