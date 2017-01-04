# MdTranslator - minitest of
# reader / mdJson / module_timePeriod

# History:
#   Stan Smith 2016-10-08 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_timePeriod'

class TestReaderMdJsonTimePeriod < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TimePeriod
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'timePeriod.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['timePeriod'][0]

    def test_complete_timePeriod_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'id', metadata[:timeId]
        assert_equal 'description', metadata[:description]
        refute_empty metadata[:identifier]
        assert_equal 2, metadata[:periodNames].length
        assert_equal 'periodName0', metadata[:periodNames][0]
        assert_equal 'periodName1', metadata[:periodNames][1]
        assert_kind_of DateTime, metadata[:startDateTime][:dateTime]
        assert_equal 'YMDhmsLZ', metadata[:startDateTime][:dateResolution]
        assert_kind_of DateTime, metadata[:endDateTime][:dateTime]
        assert_equal 'YMD', metadata[:endDateTime][:dateResolution]
        refute_empty metadata[:timeInterval]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_timePeriod_empty_start_end_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['startDateTime'] = ''
        hIn['endDateTime'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_timePeriod_missing_start_end_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('startDateTime')
        hIn.delete('endDateTime')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_timePeriod_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['id'] = ''
        hIn['description'] = ''
        hIn['identifier'] = {}
        hIn['periodName'] = []
        hIn['timeInterval'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:timeId]
        assert_nil metadata[:description]
        assert_empty metadata[:identifier]
        assert_empty metadata[:periodNames]
        assert_empty metadata[:timeInterval]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_timePeriod_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('id')
        hIn.delete('description')
        hIn.delete('identifier')
        hIn.delete('periodName')
        hIn.delete('timeInterval')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:timeId]
        assert_nil metadata[:description]
        assert_empty metadata[:identifier]
        assert_empty metadata[:periodNames]
        assert_empty metadata[:timeInterval]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_timePeriod_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
