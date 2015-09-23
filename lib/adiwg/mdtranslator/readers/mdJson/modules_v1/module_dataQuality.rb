# unpack data quality
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_lineage')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DataQuality

                    def self.unpack(hDataQual, responseObj)

                        # return nil object if input is empty
                        intDataQual = nil
                        return if hDataQual.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDataQual = intMetadataClass.newDataQuality

                        # data quality - scope
                        if hDataQual.has_key?('scope')
                            s = hDataQual['scope']
                            if s != ''
                                intDataQual[:dataScope] = s
                            else
                                responseObj[:readerExecutionPass] =  false
                                responseObj[:readerExecutionMessages] << 'dataQuality: {scope: } is blank.'
                                return nil
                            end
                        else
                            responseObj[:readerExecutionPass] =  false
                            responseObj[:readerExecutionMessages] << 'dataQuality: {scope: } is missing.'
                            return nil
                        end

                        # data quality - report
                        # on hold

                        # data quality - lineage
                        if hDataQual.has_key?('lineage')
                            hLineage = hDataQual['lineage']
                            unless hLineage.empty?
                                intDataQual[:dataLineage] = Lineage.unpack(hLineage, responseObj)
                            end
                        end

                        return intDataQual
                    end

                end

            end
        end
    end
end