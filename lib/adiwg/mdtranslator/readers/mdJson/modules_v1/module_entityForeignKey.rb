# unpack an data entity foreign key
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-07-24 added error reporting of missing items

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module EntityForeignKey

                    def self.unpack(hFKey, responseObj)

                        # return nil object if input is empty
                        intFKey = nil
                        return if hFKey.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intFKey = intMetadataClass.newEntityForeignKey

                        # entity foreign key - local attribute code name
                        if hFKey.has_key?('localAttributeCodeName')
                            aLocalAttributes = hFKey['localAttributeCodeName']
                            unless aLocalAttributes.empty?
                                intFKey[:fkLocalAttributes] = aLocalAttributes
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary foreign key local attribute code name is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # entity foreign key - referenced entity code name
                        if hFKey.has_key?('referencedEntityCodeName')
                            s = hFKey['referencedEntityCodeName']
                            if s != ''
                                intFKey[:fkReferencedEntity] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary foreign key referenced entity name is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # entity foreign key - referenced attribute code name
                        if hFKey.has_key?('referencedAttributeCodeName')
                            aRefAttributes = hFKey['referencedAttributeCodeName']
                            unless aRefAttributes.empty?
                                intFKey[:fkReferencedAttributes] = aRefAttributes
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary foreign key referenced attribute name is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        return intFKey

                    end

                end

            end
        end
    end
end
