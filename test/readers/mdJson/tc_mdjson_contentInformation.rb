# MdTranslator - minitest of
# reader / mdJson / module_contentInformation

# History:
#   Stan Smith 2016-10-18 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_contentInformation'

class TestReaderMdJsonContentInformation < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ContentInformation
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'contentInfo.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['contentInformation'][0]

    def test_complete_contentInfo_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'coverageName', metadata[:coverageName]
        assert_equal 'coverageDescription', metadata[:coverageDescription]
        refute_empty metadata[:processingLevelCode]
        assert_equal 2, metadata[:attributeGroup].length
        refute_empty metadata[:imageDescription]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_contentInfo_empty_coverageName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['coverageName'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_contentInfo_missing_coverageName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('coverageName')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_contentInfo_empty_coverageDescription

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['coverageDescription'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_contentInfo_missing_coverageDescription

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('coverageDescription')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_contentInfo_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['processingLevelCode'] = {}
        hIn['attributeGroup'] = []
        hIn['imageDescription'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'coverageName', metadata[:coverageName]
        assert_equal 'coverageDescription', metadata[:coverageDescription]
        assert_empty metadata[:processingLevelCode]
        assert_empty metadata[:attributeGroup]
        assert_empty metadata[:imageDescription]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_contentInfo_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('processingLevelCode')
        hIn.delete('attributeGroup')
        hIn.delete('imageDescription')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'coverageName', metadata[:coverageName]
        assert_equal 'coverageDescription', metadata[:coverageDescription]
        assert_empty metadata[:processingLevelCode]
        assert_empty metadata[:attributeGroup]
        assert_empty metadata[:imageDescription]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_contentInformation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
