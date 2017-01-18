# MdTranslator - minitest of
# reader / mdJson / module_distributor

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-21 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_distributor'

class TestReaderMdJsonDistributor < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Distributor
    aIn = TestReaderMdJsonParent.getJson('distributor.json')
    @@hIn = aIn['distributor'][0]

    def test_complete_distributor_object

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:contact]
        assert_equal 2, metadata[:orderProcess].length
        assert_equal 2, metadata[:transferOptions].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_distributor_empty_contact

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['contact'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_distributor_missing_contact

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('contact')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_distributor_empty_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['orderProcess'] = []
        hIn['transferOptions'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:contact]
        assert_empty metadata[:orderProcess]
        assert_empty metadata[:transferOptions]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_distributor_missing_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('orderProcess')
        hIn.delete('transferOptions')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:contact]
        assert_empty metadata[:orderProcess]
        assert_empty metadata[:transferOptions]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_distributor_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
