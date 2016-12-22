# MdTranslator - minitest of
# reader / mdJson / module_taxonomicClassification

# History:
#   Stan Smith 2016-10-22 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
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
        assert_equal 2, metadata[:commonNames].length
        assert_equal 'commonName0', metadata[:commonNames][0]
        assert_equal 'commonName1', metadata[:commonNames][1]
        assert_equal 2, metadata[:subClasses].length
        assert_equal 'taxonomicRank00', metadata[:subClasses][0][:taxonRank]
        assert_equal 'taxonomicRank01', metadata[:subClasses][1][:taxonRank]
        assert_equal 'taxonomicRank0000.1', metadata[:subClasses][0][:subClasses][0][:subClasses][0][:taxonRank]
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
        hIn['subClassification'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'taxonomicRank0', metadata[:taxonRank]
        assert_equal 'latinName', metadata[:taxonValue]
        assert_empty metadata[:commonNames]
        assert_empty metadata[:subClasses]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxClass_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('commonName')
        hIn.delete('subClassification')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'taxonomicRank0', metadata[:taxonRank]
        assert_equal 'latinName', metadata[:taxonValue]
        assert_empty metadata[:commonNames]
        assert_empty metadata[:subClasses]
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
