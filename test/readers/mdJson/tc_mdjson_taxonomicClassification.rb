# MdTranslator - minitest of
# reader / mdJson / module_taxonomicClassification

# History:
#   Stan Smith 2016-10-22 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_taxonomicClassification'

class TestReaderMdJsonTaxonomicClassification < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TaxonomicClassification
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'taxonomicClassification.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['taxonomicClassification'][0]

    def test_complete_taxClass_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'taxonomicRank0', metadata[:taxonRank]
        assert_equal 'latinName', metadata[:taxonValue]
        assert_equal 2, metadata[:commonName].length
        assert_equal 'commonName0', metadata[:commonName][0]
        assert_equal 'commonName1', metadata[:commonName][1]
        assert_equal 2, metadata[:taxonClass].length
        assert_equal 'taxonomicRank00', metadata[:taxonClass][0][:taxonRank]
        assert_equal 'taxonomicRank01', metadata[:taxonClass][1][:taxonRank]
        assert_equal 'taxonomicRank0000', metadata[:taxonClass][0][:taxonClass][0][:taxonClass][0][:taxonRank]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxClass_empty_taxRank

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['taxonomicRank'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxClass_missing_taxRank

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('taxonomicRank')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxClass_empty_latinName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['latinName'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxClass_missing_latinName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('latinName')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxClass_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['commonName'] = []
        hIn['taxonomicClassification'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'taxonomicRank0', metadata[:taxonRank]
        assert_equal 'latinName', metadata[:taxonValue]
        assert_empty metadata[:commonName]
        assert_empty metadata[:taxonClass]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxClass_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('commonName')
        hIn.delete('taxonomicClassification')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'taxonomicRank0', metadata[:taxonRank]
        assert_equal 'latinName', metadata[:taxonValue]
        assert_empty metadata[:commonName]
        assert_empty metadata[:taxonClass]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_taxClass_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
