# unpack time period
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

                module TimePeriod

                    def self.unpack(hTimePeriod, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new

                        # time period
                        intTimePer = intMetadataClass.newTimePeriod

                        if hTimePeriod.has_key?('id')
                            s = hTimePeriod['id']
                            if s != ''
                                intTimePer[:timeId] = s
                            end
                        end

                        if hTimePeriod.has_key?('description')
                            s = hTimePeriod['description']
                            if s != ''
                                intTimePer[:description] = s
                            end
                        end

                        if hTimePeriod.has_key?('beginPosition')
                            s = hTimePeriod['beginPosition']
                            if s != ''
                                intTimePer[:beginTime] = DateTime.unpack(s, responseObj)

                            end
                        end

                        if hTimePeriod.has_key?('endPosition')
                            s = hTimePeriod['endPosition']
                            if s != ''
                                intTimePer[:endTime] = DateTime.unpack(s, responseObj)

                            end
                        end

                        return intTimePer
                    end

                end

            end
        end
    end
end
