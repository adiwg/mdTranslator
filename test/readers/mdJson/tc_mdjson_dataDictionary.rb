# MdTranslator - minitest of
# reader / mdJson / module_dataDictionary

# History:
#   Stan Smith 2016-10-20 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_dataDictionary'

class TestReaderMdJsonDataDictionary < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DataDictionary
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'dictionary.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['dataDictionary'][0]

    def test_complete_dictionary_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:citation]
        assert_equal 'description', metadata[:description]
        assert_equal 'resourceType', metadata[:resourceType]
        assert_equal 'language', metadata[:language]
        assert metadata[:includedWithDataset]
        assert_equal 2, metadata[:domains].length
        assert_equal 2, metadata[:entities].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_dictionary_empty_citation

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['citation'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dictionary_missing_citation

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('citation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dictionary_empty_resourceType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dictionary_missing_resourceType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resourceType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dictionary_empty_description

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['description'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dictionary_missing_description

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('description')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_dictionary_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['language'] = ''
        hIn['dictionaryIncludedWithResource'] = ''
        hIn['domain'] = []
        hIn['entity'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:citation]
        assert_equal 'description', metadata[:description]
        assert_equal 'resourceType', metadata[:resourceType]
        assert_nil metadata[:language]
        refute metadata[:includedWithDataset]
        assert_empty metadata[:domains]
        assert_empty metadata[:entities]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_dictionary_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('language')
        hIn.delete('dictionaryIncludedWithResource')
        hIn.delete('domain')
        hIn.delete('entity')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:citation]
        assert_equal 'description', metadata[:description]
        assert_equal 'resourceType', metadata[:resourceType]
        assert_nil metadata[:language]
        refute metadata[:includedWithDataset]
        assert_empty metadata[:domains]
        assert_empty metadata[:entities]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_dictionary_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
