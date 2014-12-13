# unpack an data entity foreign key
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script

module Md_EntityForeignKey

    def self.unpack(hFKey)

        # instance classes needed in script
        intMetadataClass = InternalMetadata.new
        intFKey = intMetadataClass.newEntityForeignKey

        # entity foreign key - local attribute code name
        if hFKey.has_key?('localAttributeCodeName')
            aLocalAttributes = hFKey['localAttributeCodeName']
            unless aLocalAttributes.empty?
                intFKey[:fkLocalAttributes] = aLocalAttributes
            end
        end

        # entity foreign key - referenced entity code name
        if hFKey.has_key?('referencedEntityCodeName')
            s = hFKey['referencedEntityCodeName']
            if s != ''
                intFKey[:fkReferencedEntity] = s
            end
        end

        # entity foreign key - referenced attribute code name
        if hFKey.has_key?('referencedAttributeCodeName')
            aRefAttributes = hFKey['referencedAttributeCodeName']
            unless aRefAttributes.empty?
                intFKey[:fkReferencedAttributes] = aRefAttributes
            end
        end

        return intFKey

    end

end
