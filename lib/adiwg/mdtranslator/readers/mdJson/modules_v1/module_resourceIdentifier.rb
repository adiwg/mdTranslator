# unpack resource identifier
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-05-28 original script
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-08-18 added type to identifier schema 0.6.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-07-31 added support for fields added by ISO 19115-1 (RS_Identifier)

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ResourceIdentifier

                    def self.unpack(hResID, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intResID = intMetadataClass.newResourceId

                        # resource identifier - identifier
                        if hResID.has_key?('identifier')
                            s = hResID['identifier']
                            if s != ''
                                intResID[:identifier] = s
                            end
                        end

                        # resource identifier - identifier type
                        if hResID.has_key?('type')
                            s = hResID['type']
                            if s != ''
                                intResID[:identifierType] = s
                            end
                        end

                        # resource identifier - namespace
                        if hResID.has_key?('namespace')
                            s = hResID['namespace']
                            if s != ''
                                intResID[:identifierNamespace] = s
                            end
                        end

                        # resource identifier - version
                        if hResID.has_key?('version')
                            s = hResID['version']
                            if s != ''
                                intResID[:identifierVersion] = s
                            end
                        end

                        # resource identifier - description
                        if hResID.has_key?('description')
                            s = hResID['description']
                            if s != ''
                                intResID[:identifierDescription] = s
                            end
                        end

                        # resource identifier - authority (expressed as a citation)
                        if hResID.has_key?('authority')
                            hCitation = hResID['authority']
                            unless hCitation.empty?
                                intResID[:identifierCitation] = Citation.unpack(hCitation, responseObj)
                            end
                        end

                        return intResID

                    end

                end

            end
        end
    end
end