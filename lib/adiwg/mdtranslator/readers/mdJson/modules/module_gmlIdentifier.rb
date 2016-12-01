# unpack GML identifier
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-11-30 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GMLIdentifier

                    def self.unpack(hIdentifier, responseObj)

                        # return nil object if input is empty
                        if hIdentifier.empty?
                            responseObj[:readerExecutionMessages] << 'GML Identifier object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intIdentifier = intMetadataClass.newGMLIdentifier

                        # gml identifier - identifier (required)
                        if hIdentifier.has_key?('identifier')
                            intIdentifier[:identifier] = hIdentifier['identifier']
                        end
                        if intIdentifier[:identifier].nil? || intIdentifier[:identifier] == ''
                            responseObj[:readerExecutionMessages] << 'GML Identifier attribute identifier is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # gml identifier - namespace (required)
                        if hIdentifier.has_key?('namespace')
                            intIdentifier[:namespace] = hIdentifier['namespace']
                        end
                        if intIdentifier[:namespace].nil? || intIdentifier[:namespace] == ''
                            responseObj[:readerExecutionMessages] << 'GML Identifier attribute namespace is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intIdentifier

                    end
                end

            end
        end
    end
end
