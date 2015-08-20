# unpack classed data
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-20 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_classedDataItem')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ClassedData

                    def self.unpack(hClassData, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hClass = intMetadataClass.newClassedData

                        # classed data - number of classed items
                        if hClassData.has_key?('numberOfClasses')
                            s = hClassData['numberOfClasses']
                            if s != ''
                                hClass[:numberOfClasses] = s
                            end
                        end

                        # classed data - classed data items
                        if hClassData.has_key?('classedDataItem')
                            aClassItems = hClassData['classedDataItem']
                            aClassItems.each do |hClassItem|
                                if !hClassItem.empty?
                                    hClass[:classedDataItem] << ClassedDataItem.unpack(hClassItem, responseObj)
                                end
                            end
                        end

                        return hClass

                    end

                end

            end
        end
    end
end
