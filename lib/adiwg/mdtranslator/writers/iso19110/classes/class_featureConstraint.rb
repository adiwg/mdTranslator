# ISO <<Class>> FC_Constraint
# writer output in XML
# create constraints for primary keys and indexes
# ... FC_Constraint only has one attribute, description
# ... all constraints need to be expressed as character strings

# History:
# 	Stan Smith 2014-12-02 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19110

                class FC_Constraint

                    def initialize(xml, responseObj)
                        @xml = xml
                        @hResponseObj = responseObj
                    end

                    def writeXML(conType, hConstraint)

                        @xml.tag!('gfc:FC_Constraint') do
                            @xml.tag!('gfc:description') do

                                # find type of constraint (primary key or index)
                                case conType

                                    # primary keys
                                    when 'pk'
                                        s = 'primary key: '
                                        s += hConstraint.to_s

                                    # indexes
                                    when 'index'
                                        if hConstraint[:duplicate]
                                            indexType = 'duplicate'
                                        else
                                            indexType = 'unique'
                                        end
                                        s = indexType + ' index ' + hConstraint[:indexCode]
                                        s += ' on ' + hConstraint[:attributeNames].to_s

                                    # foreign keys
                                    when 'fk'
                                        s = 'foreign key '
                                        s += hConstraint[:fkLocalAttributes].to_s
                                        s += ' references ' + hConstraint[:fkReferencedEntity] + '.'
                                        s += hConstraint[:fkReferencedAttributes].to_s

                                end

                                @xml.tag!('gco:CharacterString', s)

                            end
                        end

                    end

                end

            end
        end
    end
end
