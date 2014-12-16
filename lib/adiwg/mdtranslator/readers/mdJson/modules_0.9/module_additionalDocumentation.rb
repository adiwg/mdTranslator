# unpack additional documentation
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-11-06 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

require $ReaderNS.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module AdditionalDocumentation

                    def self.unpack(hAddDoc)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAddDoc = intMetadataClass.newAssociatedResource

                        # associated resource - resource type
                        if hAddDoc.has_key?('resourceType')
                            s = hAddDoc['resourceType']
                            if s != ''
                                intAddDoc[:resourceType] = s
                            end
                        end

                        # associated resource - resource citation
                        if hAddDoc.has_key?('citation')
                            hCitation = hAddDoc['citation']
                            unless hCitation.empty?
                                intAddDoc[:citation] = $ReaderNS::Citation.unpack(hCitation)
                            end
                        end

                        return intAddDoc
                    end

                end

            end
        end
    end
end
