# MdTranslator - minitest of
# reader / mdJson / module_domain

# History:
#   Stan Smith 2016-10-07 refactored for mdJson 2.0
#   Stan Smith 2015-06-22 refactored setup to after removal of globals
#   Stan Smith 2015-01-20 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_domain'

class TestReaderMdJsonDomain < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Domain
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'domain.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['domain'][0]

    def test_complete_domain_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'domainId', metadata[:domainId]
        assert_equal 'commonName', metadata[:domainName]
        assert_equal 'codeName', metadata[:domainCode]
        assert_equal 'description', metadata[:domainDescription]
        assert_equal 2, metadata[:domainItems].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_domain_id

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['domainId'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_domain_codeName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['codeName'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_domain_description

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['description'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_domain_item

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['domainItem'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_domain_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['commonName'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:domainName]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_domain_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('commonName')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:domainName]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_domain_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
