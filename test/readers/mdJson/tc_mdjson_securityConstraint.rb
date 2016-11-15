# MdTranslator - minitest of
# reader / mdJson / module_securityConstraint

# History:
# Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_securityConstraint'

class TestReaderMdJsonSecurityConstraint < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SecurityConstraint
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'securityConstraint.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['securityConstraint'][0]

    def test_complete_securityConstraint_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:constraint]
        assert_equal 'classification', metadata[:classCode]
        assert_equal 'userNote', metadata[:userNote]
        assert_equal 'classificationSystem', metadata[:classSystem]
        assert_equal 'handlingDescription', metadata[:handling]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_securityConstraint_empty_classification

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['classification'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_securityConstraint_missing_classification

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('classification')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_securityConstraint_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['constraint'] = {}
        hIn['classificationSystem'] = ''
        hIn['userNote'] = ''
        hIn['handlingDescription'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:constraint]
        assert_nil metadata[:useCodes]
        assert_nil metadata[:accessCodes]
        assert_nil metadata[:otherCodes]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_securityConstraint_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('constraint')
        hIn.delete('classificationSystem')
        hIn.delete('userNote')
        hIn.delete('handlingDescription')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:constraint]
        assert_nil metadata[:useCodes]
        assert_nil metadata[:accessCodes]
        assert_nil metadata[:otherCodes]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_securityConstraint_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
