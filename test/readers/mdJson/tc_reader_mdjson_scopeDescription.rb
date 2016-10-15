# MdTranslator - minitest of
# reader / mdJson / module_scopeDescription

# History:
# Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_scopeDescription'

class TestReaderMdJsonScopeDescription < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ScopeDescription
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'scopeDescription.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['scopeDescription'][0]

    def test_complete_scopeDescription_dataset_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'dataset', metadata[:type]
        assert_equal 'description', metadata[:description]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_complete_scopeDescription_invalid_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = 'invalid'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_scopeDescription_empty_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['type'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_scopeDescription_missing_type

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('type')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_scopeDescription_empty_description

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['description'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_scopeDescription_missing_description

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('description')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_scopeDescription_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        require 'pp'
        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end



end
