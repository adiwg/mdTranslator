# unpack additional documentation
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-11-17 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-30 added return if empty input
#   ... found & fixed error of method using associatedResource object instead of
#   ... additionalDocumentation object
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-11-06 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module AdditionalDocumentation

                    def self.unpack(hAddDoc, responseObj)

                        # return nil object if input is empty
                        if hAddDoc.empty?
                            responseObj[:readerExecutionMessages] << 'Additional Documentation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAddDoc = intMetadataClass.newAdditionalDocumentation

                        # additional documentation - resource type
                        if hAddDoc.has_key?('resourceType')
                            if hAddDoc['resourceType'] != ''
                                intAddDoc[:resourceType] = hAddDoc['resourceType']
                            end
                        end

                        # additional documentation - citation [] (required)
                        if hAddDoc.has_key?('citation')
                            hAddDoc['citation'].each do |item|
                                hDoc = Citation.unpack(item, responseObj)
                                unless hDoc.nil?
                                    intAddDoc[:citation] << hDoc
                                end
                            end
                        end
                        if intAddDoc[:citation].empty?
                            responseObj[:readerExecutionMessages] << 'Additional Documentation is missing citation'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intAddDoc

                    end

                end

            end
        end
    end
end
