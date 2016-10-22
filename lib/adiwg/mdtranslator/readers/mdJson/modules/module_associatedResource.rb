# unpack associated resource
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-18 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-30 added return if empty input
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-11-06 added resourceType for 0.9.0
#   Stan Smith 2014-11-06 changed resourceType to initiative type for 0.9.0
#   Stan Smith 2014-08-18 moved resourceIdentifier to citation module schema 0.6.0
#   Stan Smith 2014-07-08 resolve require statements using Mdtranslator.reader_module
# 	Stan Smith 2014-06-02 added resource metadata citation section
# 	Stan Smith 2014-05-28 added resource identifier section
# 	Stan Smith 2014-05-02 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module AssociatedResource

                    def self.unpack(hAssocRes, responseObj)

                        # return nil object if input is empty
                        if hAssocRes.empty?
                            responseObj[:readerExecutionMessages] << 'Associated Resource object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAssocRes = intMetadataClass.newAssociatedResource

                        # associated resource - resource type (required)
                        if hAssocRes.has_key?('resourceType')
                            intAssocRes[:resourceType] = hAssocRes['resourceType']
                        end
                        if intAssocRes[:resourceType].nil? || intAssocRes[:resourceType] == ''
                            responseObj[:readerExecutionMessages] << 'Associated Resource attribute resourceType is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # associated resource - association type (required)
                        if hAssocRes.has_key?('associationType')
                            intAssocRes[:associationType] = hAssocRes['associationType']
                        end
                        if intAssocRes[:associationType].nil? || intAssocRes[:associationType] == ''
                            responseObj[:readerExecutionMessages] << 'Associated Resource attribute associationType is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # associated resource - initiative type
                        if hAssocRes.has_key?('initiativeType')
                            if hAssocRes['initiativeType'] != ''
                                intAssocRes[:initiativeType] = hAssocRes['initiativeType']
                            end
                        end

                         # associated resource - resource citation
                        if hAssocRes.has_key?('resourceCitation')
                            hObject = hAssocRes['resourceCitation']
                            unless hObject.empty?
                                hReturn = Citation.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intAssocRes[:resourceCitation] = hReturn
                                end
                            end
                        end

                        # associated resource - metadata citation
                        if hAssocRes.has_key?('metadataCitation')
                            hObject = hAssocRes['metadataCitation']
                            unless hObject.empty?
                                hReturn = Citation.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intAssocRes[:metadataCitation] = hReturn
                                end
                            end
                        end

                        if intAssocRes[:metadataCitation].empty? && intAssocRes[:resourceCitation].empty?
                            responseObj[:readerExecutionMessages] << 'Associated Resource requires either a resource or metadata citation'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intAssocRes
                    end

                end

            end
        end
    end
end