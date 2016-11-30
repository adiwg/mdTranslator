# MdTranslator - minitest of
# reader / mdJson / module_identifier

# History:
#   Stan Smith 2016-10-13 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_identifier'

class TestReaderMdJsonIdentifier < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Identifier
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'identifier.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['identifier'][0]

    def test_complete_identifier_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'identifier', metadata[:identifier]
        assert_equal 'namespace', metadata[:namespace]
        assert_equal 'version', metadata[:version]
        assert_equal 'description', metadata[:description]
        refute_empty metadata[:citation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_identifier_identifier

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['identifier'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_identifier_identifier

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('identifier')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_identifier_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['namespace'] = ''
        hIn['version'] = ''
        hIn['description'] = ''
        hIn['authority'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:namespace]
        assert_nil metadata[:version]
        assert_nil metadata[:description]
        assert_empty metadata[:citation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_identifier_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('namespace')
        hIn.delete('version')
        hIn.delete('description')
        hIn.delete('authority')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:namespace]
        assert_nil metadata[:version]
        assert_nil metadata[:description]
        assert_empty metadata[:citation]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_identifier_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
