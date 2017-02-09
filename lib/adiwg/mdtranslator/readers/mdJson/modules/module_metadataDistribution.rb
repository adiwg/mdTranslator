# unpack metadata distribution
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-02-09 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module MetadataDistribution

                    def self.unpack(hMdDist, responseObj)

                        # return nil object if input is empty
                        if hMdDist.empty?
                            responseObj[:readerExecutionMessages] << 'Metadata Distribution object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMdDist = intMetadataClass.newMetadataDistribution

                        # metadata distribution - clearinghouse (required)
                        if hMdDist.has_key?('clearingHouse')
                            intMdDist[:clearingHouse] = hMdDist['clearingHouse']
                        end
                        if intMdDist[:clearingHouse].nil? || intMdDist[:clearingHouse] == ''
                            responseObj[:readerExecutionMessages] << 'Metadata Distribution clearinghouse is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # metadata distribution - record ID
                        if hMdDist.has_key?('recordId')
                            unless hMdDist['recordId'] == ''
                                intMdDist[:recordId] = hMdDist['recordId']
                            end
                        end

                        # metadata distribution - push method (required) {enum}
                        if hMdDist.has_key?('pushMethod')
                            if hMdDist['pushMethod'] != ''
                                type = hMdDist['pushMethod']
                                if %w{ add update delete }.one? { |word| word == type }
                                    intMdDist[:pushMethod] = hMdDist['pushMethod']
                                else
                                    responseObj[:readerExecutionMessages] << 'Metadata Distribution push method must be add, update, or delete'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intMdDist[:pushMethod].nil? || intMdDist[:pushMethod] == ''
                            responseObj[:readerExecutionMessages] << 'Metadata Distribution push method is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # metadata distribution - metadata format (required) {mdTranslator writer}
                        if hMdDist.has_key?('metadataFormat')
                            if hMdDist['metadataFormat'] != ''
                                type = hMdDist['metadataFormat']
                                if %w{ iso19115_2 iso19110 html sbJson mdJson }.one? { |word| word == type }
                                    intMdDist[:metadataFormat] = hMdDist['metadataFormat']
                                else
                                    responseObj[:readerExecutionMessages] << 'Metadata Distribution format must be supported mdTranslator writer'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intMdDist[:metadataFormat].nil? || intMdDist[:metadataFormat] == ''
                            responseObj[:readerExecutionMessages] << 'Metadata Distribution format is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        if intMdDist[:pushMethod] == 'update' || intMdDist[:pushMethod] == 'delete'
                            if intMdDist[:recordId].nil?
                                responseObj[:readerExecutionMessages] << 'Metadata Distribution record ID is required to push update or delete'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        return intMdDist

                    end

                end

            end
        end
    end
end
