require_relative 'module_identifier'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module QualityMeasure
                    def self.unpack(hQualityMeasure, responseObj)

                        intMetadataClass = InternalMetadata.new
                        intQualityMeasure = intMetadataClass.newQualityMeasure

                        intQualityMeasure[:description] = hQualityMeasure['description']

                        if hQualityMeasure.has_key?('name')
                            intQualityMeasure[:nameOfMeasure] = hQualityMeasure['name']
                        end

                        if hQualityMeasure.has_key?('identifier')
                            hReturn = Identifier.unpack(hQualityMeasure['identifier'], responseObj)
                            unless hReturn.nil?
                                intQualityMeasure[:identifier] = hReturn
                            end
                        end

                        return intQualityMeasure

                    end
                end
            end
        end
    end
end
