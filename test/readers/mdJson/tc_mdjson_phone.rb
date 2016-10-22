# MdTranslator - minitest of
# reader / mdJson / module_phone

# History:
# Stan Smith 2016-10-01 refactored to mdJson 2.0.0
# Stan Smith 2015-06-22 refactored setup to after removal of globals
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator
# Stan Smith 2014-12-09 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_phone'

class TestReaderMdJsonPhone < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Phone
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'phone.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['phone'][0]

    def test_complete_phone_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'phoneName', metadata[:phoneName]
        assert_equal '111-111-1111', metadata[:phoneNumber]
        assert_equal 3, metadata[:phoneServiceTypes].length
        assert_equal 'service1', metadata[:phoneServiceTypes][1]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_phone_number

        # empty phone number should return empty object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['phoneNumber'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_phone_number

        # missing phone number should return empty object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('phoneNumber')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_phone_service

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['service'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'phoneName', metadata[:phoneName]
        assert_equal '111-111-1111', metadata[:phoneNumber]
        assert_equal 0, metadata[:phoneServiceTypes].length
        assert hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_phone_service

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('service')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'phoneName', metadata[:phoneName]
        assert_equal '111-111-1111', metadata[:phoneNumber]
        assert_equal 0, metadata[:phoneServiceTypes].length
        assert hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_phone_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
