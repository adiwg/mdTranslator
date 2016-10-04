# MdTranslator - minitest of
# reader / mdJson / module_duration

# History:
# Stan Smith 2016-10-03 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_duration'

class TestReaderMdJsonDuration < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Duration
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'duration.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['duration'][0]

    def test_complete_duration_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 1, metadata[:years]
        assert_equal 1, metadata[:months]
        assert_equal 1, metadata[:days]
        assert_equal 1, metadata[:hours]
        assert_equal 1, metadata[:minutes]
        assert_equal 1, metadata[:seconds]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_duration_elements

        # empty elements should return 0
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['years'] = nil
        hIn['months'] = nil
        hIn['days'] = nil
        hIn['hours'] = nil
        hIn['minutes'] = nil
        hIn['seconds'] = nil
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 0, metadata[:years]
        assert_equal 0, metadata[:months]
        assert_equal 0, metadata[:days]
        assert_equal 0, metadata[:hours]
        assert_equal 0, metadata[:minutes]
        assert_equal 0, metadata[:seconds]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_duration_elements

        # missing elements should return 0
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = '0'
        hIn.delete('years')
        hIn.delete('months')
        hIn.delete('days')
        hIn.delete('hours')
        hIn.delete('minutes')
        hIn.delete('seconds')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 0, metadata[:years]
        assert_equal 0, metadata[:months]
        assert_equal 0, metadata[:days]
        assert_equal 0, metadata[:hours]
        assert_equal 0, metadata[:minutes]
        assert_equal 0, metadata[:seconds]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_duration_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
