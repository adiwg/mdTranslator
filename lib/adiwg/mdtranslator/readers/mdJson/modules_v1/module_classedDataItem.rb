# unpack classed data item
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-20 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ClassedDataItem

                    def self.unpack(hClassData, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hClassItem = intMetadataClass.newClassedDataItem

                        # classed data item - name
                        if hClassData.has_key?('className')
                            s = hClassData['className']
                            if s != ''
                                hClassItem[:className] = s
                            end
                        end

                        # classed data item - description
                        if hClassData.has_key?('classDescription')
                            s = hClassData['classDescription']
                            if s != ''
                                hClassItem[:classDescription] = s
                            end
                        end

                        # classed data item - value
                        if hClassData.has_key?('classValue')
                            s = hClassData['classValue']
                            if s != ''
                                hClassItem[:classValue] = s
                            end
                        end

                        return hClassItem

                    end

                end

            end
        end
    end
end
