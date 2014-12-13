# unpack time period
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-11 original script
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_dateTime', $response[:readerVersionUsed])

module Md_TimePeriod

    def self.unpack(hTimePeriod)

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
                intTimePer[:beginTime] = Md_DateTime.unpack(s)

            end
        end

        if hTimePeriod.has_key?('endPosition')
            s = hTimePeriod['endPosition']
            if s != ''
                intTimePer[:endTime] = Md_DateTime.unpack(s)

            end
        end

        return intTimePer
    end

end