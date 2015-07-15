# unpack metadata extension information
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-22 original script
#   Stan Smith 2014-05-15 modified for JSON schema 0.4.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module MetadataExtension

                    def self.addExtensionISObio(responseObj)

                        intMetadataClass = InternalMetadata.new
                        intMetaExt = intMetadataClass.newMetadataExtension
                        intContactRole = intMetadataClass.newRespParty

                        # extension online information
                        intMetaExt[:onLineResource] = {}

                        # extension entity information
                        intMetaExt[:extName] = 'Taxonomy System'
                        intMetaExt[:extShortName] = 'TaxonSys'
                        intMetaExt[:extDefinition] = 'Documentation of taxonomic sources, procedures, and treatments'
                        intMetaExt[:obligation] = 'optional'
                        intMetaExt[:dataType] = 'class'
                        intMetaExt[:maxOccurrence] = '1'
                        intMetaExt[:parentEntities] << 'MD_Identification'
                        intMetaExt[:rule] = 'New Metadata section as a class to MD_Identification'
                        intMetaExt[:rationales] << 'The set of data elements contained within this class element ' +
                            'represents an attempt to provide better documentation of ' +
                            'taxonomic sources, procedures, and treatments.'

                        # source information
                        intContactRole[:contactId] = 'ADIwgBio'
                        intContactRole[:roleName] = 'resourceProvider'
                        intMetaExt[:extSources] << intContactRole

                        return intMetaExt
                    end

                end

            end
        end
    end
end
