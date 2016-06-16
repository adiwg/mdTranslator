require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

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
