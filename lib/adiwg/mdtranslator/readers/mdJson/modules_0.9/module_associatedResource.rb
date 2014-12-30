# unpack associated resource
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-05-02 original script
# 	Stan Smith 2014-05-28 added resource identifier section
# 	Stan Smith 2014-06-02 added resource metadata citation section
#   Stan Smith 2014-07-08 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-08-18 moved resourceIdentifier to citation module schema 0.6.0
#   Stan Smith 2014-11-06 changed resourceType to initiative type for 0.9.0
#   Stan Smith 2014-11-06 added resourceType for 0.9.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-30 added return if empty input

require $ReaderNS.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module AssociatedResource

                    def self.unpack(hAssocRes)

                        # return nil object if input is empty
                        intAssocRes = nil
                        return if hAssocRes.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAssocRes = intMetadataClass.newAssociatedResource

                        # associated resource - association type
                        if hAssocRes.has_key?('associationType')
                            s = hAssocRes['associationType']
                            if s != ''
                                intAssocRes[:associationType] = s
                            end
                        end

                        # associated resource - initiative type
                        if hAssocRes.has_key?('initiativeType')
                            s = hAssocRes['initiativeType']
                            if s != ''
                                intAssocRes[:initiativeType] = s
                            end
                        end

                        # associated resource - resource type
                        if hAssocRes.has_key?('resourceType')
                            s = hAssocRes['resourceType']
                            if s != ''
                                intAssocRes[:resourceType] = s
                            end
                        end

                        # associated resource - resource citation
                        if hAssocRes.has_key?('resourceCitation')
                            hCitation = hAssocRes['resourceCitation']
                            unless hCitation.empty?
                                intAssocRes[:resourceCitation] = $ReaderNS::Citation.unpack(hCitation)
                            end
                        end

                        # associated resource - metadata citation
                        if hAssocRes.has_key?('metadataCitation')
                            hCitation = hAssocRes['metadataCitation']
                            unless hCitation.empty?
                                intAssocRes[:metadataCitation] = $ReaderNS::Citation.unpack(hCitation)
                            end
                        end

                        return intAssocRes
                    end

                end

            end
        end
    end
end
