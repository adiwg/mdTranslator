# MdTranslator - minitest of
# reader / mdJson / module_constraints

# History:
# Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_constraints'

class TestReaderMdJsonConstraints < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Constraints
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'constraints.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['constraints'][0]

    def test_complete_constraints_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:constraints].length
        assert_equal 'useLimitation0', metadata[:constraints][0][:useLimitation][0]
        assert_equal 2, metadata[:legalConstraints].length
        assert_equal 'accessConstraint0', metadata[:legalConstraints][0][:accessCodes][0]
        assert_equal 2, metadata[:securityConstraints].length
        assert_equal 'classification0', metadata[:securityConstraints][0][:classCode]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_constraints_objects

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['constraint'] = []
        hIn['legalConstraint'] = []
        hIn['securityConstraint'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:constraints]
        assert_empty metadata[:legalConstraints]
        assert_empty metadata[:securityConstraints]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_constraint_objects

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('constraint')
        hIn.delete('legalConstraint')
        hIn.delete('securityConstraint')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:constraints]
        assert_empty metadata[:legalConstraints]
        assert_empty metadata[:securityConstraints]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_constraints_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
