# MdTranslator - minitest of
# reader / mdJson / module_roleExtent

# History:
# Stan Smith 2016-10-08 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_roleExtent'

class TestReaderMdJsonARoleExtent < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::RoleExtent
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'roleExtent.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['roleExtent'][0]

    def test_complete_roleExtent_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        assert_kind_of DateTime, metadata[:startDateTime][:dateTime]
        assert_equal 'YMD', metadata[:startDateTime][:dateResolution]
        assert_kind_of DateTime, metadata[:endDateTime][:dateTime]
        assert_equal 'YMDhmsLZ', metadata[:endDateTime][:dateResolution]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_roleExtent_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['description'] = ''
        hIn['startDateTime'] = ''
        hIn['endDateTime'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:scope]
        assert_nil metadata[:description]
        assert_empty metadata[:startDateTime]
        assert_empty metadata[:endDateTime]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_roleExtent_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = '0'
        hIn.delete('description')
        hIn.delete('startDateTime')
        hIn.delete('endDateTime')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:scope]
        assert_nil metadata[:description]
        assert_empty metadata[:startDateTime]
        assert_empty metadata[:endDateTime]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_roleExtent_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
