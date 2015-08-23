# MdTranslator - minitest of
# reader / mdJson / module_dateTime

# History:
# Stan Smith 2015-08-23 original script

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.2.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_dateTime'

class TestReaderMdJsonDateTime_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DateTime
    @@responseObj = {}

    # supported date formats to test
    @@hIn = %w[
        2013
        2013-02
        2013-02-03
        2013-02-03T04
        2013-02-03T04:05
        2013-02-03T04:05:06
        2013-02-03T04:05:06.78
        2013-02-03T04Z
        2013-02-03T04-09
        2013-02-03T04+09:10
        2013-02-03T04:05Z
        2013-02-03T04:05-09
        2013-02-03T04:05+09:10
        2013-02-03T04:05:06Z
        2013-02-03T04:05:06-09
        2013-02-03T04:05:06+09:10
        2013-02-03T04:05:06.78Z
        2013-02-03T04:05:06.78-09
        2013-02-03T04:05:06.78+09:10
    ]

    def test_dateTime

        # year
        metadata = @@NameSpace.unpack(@@hIn[0], @@responseObj)
        assert_equal '2013-01-01T00:00:00+00:00', metadata[:dateTime].to_s
        assert_equal 'Y', metadata[:dateResolution]
        assert_nil metadata[:dateType]

        # year-month
        metadata = @@NameSpace.unpack(@@hIn[1], @@responseObj)
        assert_equal '2013-02-01T00:00:00+00:00', metadata[:dateTime].to_s
        assert_equal 'YM', metadata[:dateResolution]

        # year-month-day
        metadata = @@NameSpace.unpack(@@hIn[2], @@responseObj)
        assert_equal '2013-02-03T00:00:00+00:00', metadata[:dateTime].to_s
        assert_equal 'YMD', metadata[:dateResolution]

        # year-month-day-hour
        metadata = @@NameSpace.unpack(@@hIn[3], @@responseObj)
        assert_equal '2013-02-03T04:00:00+00:00', metadata[:dateTime].to_s
        assert_equal 'YMDh', metadata[:dateResolution]

        # year-month-day-hour-minute
        metadata = @@NameSpace.unpack(@@hIn[4], @@responseObj)
        assert_equal '2013-02-03T04:05:00+00:00', metadata[:dateTime].to_s
        assert_equal 'YMDhm', metadata[:dateResolution]

        # year-month-day-hour-minute-second
        metadata = @@NameSpace.unpack(@@hIn[5], @@responseObj)
        assert_equal '2013-02-03T04:05:06+00:00', metadata[:dateTime].to_s
        assert_equal 'YMDhms', metadata[:dateResolution]

        # year-month-day-hour-minute-second.fraction
        metadata = @@NameSpace.unpack(@@hIn[6], @@responseObj)
        assert_equal '2013-02-03T04:05:06.780+00:00', metadata[:dateTime].strftime('%Y-%m-%dT%H:%M:%S.%L%:z')
        assert_equal 'YMDhmsL', metadata[:dateResolution]

        # year-month-day-hour-zulu
        metadata = @@NameSpace.unpack(@@hIn[7], @@responseObj)
        assert_equal '2013-02-03T04:00:00+00:00', metadata[:dateTime].to_s
        assert_equal 'YMDhZ', metadata[:dateResolution]

        # year-month-day-hour-offset(-)
        metadata = @@NameSpace.unpack(@@hIn[8], @@responseObj)
        assert_equal '2013-02-03T04:00:00-09:00', metadata[:dateTime].to_s
        assert_equal 'YMDhZ', metadata[:dateResolution]

        # year-month-day-hour-offset(+)
        metadata = @@NameSpace.unpack(@@hIn[9], @@responseObj)
        assert_equal '2013-02-03T04:00:00+09:10', metadata[:dateTime].to_s
        assert_equal 'YMDhZ', metadata[:dateResolution]

        # year-month-day-hour-minute-zulu
        metadata = @@NameSpace.unpack(@@hIn[10], @@responseObj)
        assert_equal '2013-02-03T04:05:00+00:00', metadata[:dateTime].to_s
        assert_equal 'YMDhmZ', metadata[:dateResolution]

        # year-month-day-hour-minute-offset(-)
        metadata = @@NameSpace.unpack(@@hIn[11], @@responseObj)
        assert_equal '2013-02-03T04:05:00-09:00', metadata[:dateTime].to_s
        assert_equal 'YMDhmZ', metadata[:dateResolution]

        # year-month-day-hour-minute-offset(+)
        metadata = @@NameSpace.unpack(@@hIn[12], @@responseObj)
        assert_equal '2013-02-03T04:05:00+09:10', metadata[:dateTime].to_s
        assert_equal 'YMDhmZ', metadata[:dateResolution]

        # year-month-day-hour-minute-second-zulu
        metadata = @@NameSpace.unpack(@@hIn[13], @@responseObj)
        assert_equal '2013-02-03T04:05:06+00:00', metadata[:dateTime].to_s
        assert_equal 'YMDhmsZ', metadata[:dateResolution]

        # year-month-day-hour-minute-second-offset(-)
        metadata = @@NameSpace.unpack(@@hIn[14], @@responseObj)
        assert_equal '2013-02-03T04:05:06-09:00', metadata[:dateTime].to_s
        assert_equal 'YMDhmsZ', metadata[:dateResolution]

        # year-month-day-hour-minute-second-offset(+)
        metadata = @@NameSpace.unpack(@@hIn[15], @@responseObj)
        assert_equal '2013-02-03T04:05:06+09:10', metadata[:dateTime].to_s
        assert_equal 'YMDhmsZ', metadata[:dateResolution]

        # year-month-day-hour-minute-second.fraction-zulu
        metadata = @@NameSpace.unpack(@@hIn[16], @@responseObj)
        assert_equal '2013-02-03T04:05:06.78+00:00', metadata[:dateTime].to_s
        assert_equal 'YMDhmsZ', metadata[:dateResolution]

        # year-month-day-hour-minute-second.fraction-offset(-)
        metadata = @@NameSpace.unpack(@@hIn[17], @@responseObj)
        assert_equal '2013-02-03T04:05:06.78-09:00', metadata[:dateTime].to_s
        assert_equal 'YMDhmsZ', metadata[:dateResolution]

        # year-month-day-hour-minute-second.fraction-offset(+)
        metadata = @@NameSpace.unpack(@@hIn[18], @@responseObj)
        assert_equal '2013-02-03T04:05:06.78+09:10', metadata[:dateTime].to_s
        assert_equal 'YMDhmsZ', metadata[:dateResolution]

    end

end