# unpack time instant
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-11 original script
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dateTime')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module TimeInstant

                    def self.unpack(hTimeInst, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new

                        # time instant
                        intTimeInst = intMetadataClass.newTimeInstant

                        if hTimeInst.has_key?('id')
                            s = hTimeInst['id']
                            if s != ''
                                intTimeInst[:timeId] = s
                            end
                        end

                        if hTimeInst.has_key?('description')
                            s = hTimeInst['description']
                            if s != ''
                                intTimeInst[:description] = s
                            end
                        end

                        # time instant will only be inserted if time position provided
                        if hTimeInst.has_key?('timePosition')
                            s = hTimeInst['timePosition']
                            if s != ''
                                intTimeInst[:timePosition] = DateTime.unpack(s, responseObj)
                            end
                        end

                        return intTimeInst
                    end

                end

            end
        end
    end
end
