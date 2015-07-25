# unpack a data dictionary domain item
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-07-23 added error reporting of missing items

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DomainItem

                    def self.unpack(hDoItem, responseObj)

                        # return nil object if input is empty
                        intItem = nil
                        return if hDoItem.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intItem = intMetadataClass.newDomainItem

                        # data dictionary domain item - name - required
                        if hDoItem.has_key?('name')
                            s = hDoItem['name']
                            if s != ''
                                intItem[:itemName] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary domain item name is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # data dictionary domain item - value - required
                        if hDoItem.has_key?('value')
                            s = hDoItem['value']
                            if s != ''
                                intItem[:itemValue] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary domain item value is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # data dictionary domain item - definition - required
                        if hDoItem.has_key?('definition')
                            s = hDoItem['definition']
                            if s != ''
                                intItem[:itemDefinition] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary domain item definition is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        return intItem
                    end

                end

            end
        end
    end
end
