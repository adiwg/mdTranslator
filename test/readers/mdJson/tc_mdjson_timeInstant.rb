# MdTranslator - minitest of
# reader / mdJson / module_instant

# History:
# Stan Smith 2016-10-24 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_timeInstant'

class TestReaderMdJsonTimeInstant < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TimeInstant
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'timeInstant.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['timeInstant'][0]

    def test_complete_timeInstant_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'id', metadata[:timeId]
        assert_equal 'description', metadata[:description]
        assert_equal 'identifier', metadata[:identifier]
        assert_equal 2, metadata[:instantNames].length
        assert_equal 'instantName0', metadata[:instantNames][0]
        assert_equal 'instantName1', metadata[:instantNames][1]
        assert_kind_of DateTime, metadata[:timeInstant][:dateTime]
        assert_equal 'YMDhms', metadata[:timeInstant][:dateResolution]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_timeInstant_empty_dateTime

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['dateTime'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_timeInstant_missing_dateTime

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('dateTime')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_timeInstant_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['id'] = ''
        hIn['description'] = ''
        hIn['identifier'] = ''
        hIn['instantName'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:timeId]
        assert_nil metadata[:description]
        assert_nil metadata[:identifier]
        assert_empty metadata[:instantNames]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_timeInstant_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('id')
        hIn.delete('description')
        hIn.delete('identifier')
        hIn.delete('instantName')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:timeId]
        assert_nil metadata[:description]
        assert_nil metadata[:identifier]
        assert_empty metadata[:instantNames]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_timeInstant_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
