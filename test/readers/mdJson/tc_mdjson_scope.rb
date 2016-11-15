# MdTranslator - minitest of
# reader / mdJson / module_scope

# History:
# Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_scope'

class TestReaderMdJsonScope < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Scope
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'scope.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['scope'][0]

    def test_complete_scope_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'scopeCode', metadata[:scopeCode]
        assert_equal 1, metadata[:scopeDescription].length
        assert_equal 1, metadata[:timePeriod].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_scope_empty_scopeCode

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['scopeCode'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_scope_missing_scopeCode

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('scopeCode')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_scope_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['scopeDescription'] = []
        hIn['timePeriod'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'scopeCode', metadata[:scopeCode]
        assert_empty metadata[:scopeDescription]
        assert_empty metadata[:timePeriod]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_scope_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('scopeDescription')
        hIn.delete('timePeriod')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'scopeCode', metadata[:scopeCode]
        assert_empty metadata[:scopeDescription]
        assert_empty metadata[:timePeriod]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_scope_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
