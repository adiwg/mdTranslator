# unpack metadata distribution
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-02-09 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module MetadataRepository

                    def self.unpack(hMdDist, responseObj)

                        # return nil object if input is empty
                        if hMdDist.empty?
                            responseObj[:readerExecutionMessages] << 'Metadata Repository object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMdDist = intMetadataClass.newMetadataRepository

                        # metadata distribution - repository (required)
                        if hMdDist.has_key?('repository')
                            intMdDist[:repository] = hMdDist['repository']
                        end
                        if intMdDist[:repository].nil? || intMdDist[:repository] == ''
                            responseObj[:readerExecutionMessages] << 'Metadata Repository repository is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # metadata distribution - metadata format {mdTranslator writer}
                        if hMdDist.has_key?('metadataFormat')
                            if hMdDist['metadataFormat'] != ''
                                type = hMdDist['metadataFormat']
                                if %w{ iso19115_2 iso19110 html sbJson mdJson }.one? { |word| word == type }
                                    intMdDist[:metadataFormat] = hMdDist['metadataFormat']
                                end
                            end
                        end

                        return intMdDist

                    end

                end

            end
        end
    end
end
