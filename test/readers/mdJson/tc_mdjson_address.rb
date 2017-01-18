# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
#   Stan Smith 2017-01-15 added parent class to run successfully within rake
#   Stan Smith 2016-10-03 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_address'

class TestReaderMdJsonAddress < TestReaderMdJsonParent

    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Address
    aIn = TestReaderMdJsonParent.getJson('address.json')
    @@hIn = aIn['address'][0]

    def test_complete_address_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:deliveryPoints].length
        assert_equal 'deliveryPoint0', metadata[:deliveryPoints][0]
        assert_equal 'deliveryPoint1', metadata[:deliveryPoints][1]
        assert_equal 'city', metadata[:city]
        assert_equal 'administrativeArea', metadata[:adminArea]
        assert_equal 'postalCode', metadata[:postalCode]
        assert_equal 'country', metadata[:country]
        assert_equal 2, metadata[:eMailList].length
        assert_equal 'email0@example.com', metadata[:eMailList][0]
        assert_equal 'email1@example.com', metadata[:eMailList][1]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_address_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['deliveryPoint'] = []
        hIn['city'] = ''
        hIn['administrativeArea'] = ''
        hIn['postalCode'] = ''
        hIn['country'] = ''
        hIn['electronicMailAddress'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:deliveryPoints]
        assert_nil metadata[:city]
        assert_nil metadata[:adminArea]
        assert_nil metadata[:postalCode]
        assert_nil metadata[:country]
        assert_empty metadata[:eMailList]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_address_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('deliveryPoint')
        hIn.delete('city')
        hIn.delete('administrativeArea')
        hIn.delete('postalCode')
        hIn.delete('country')
        hIn.delete('electronicMailAddress')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:deliveryPoints]
        assert_nil metadata[:city]
        assert_nil metadata[:adminArea]
        assert_nil metadata[:postalCode]
        assert_nil metadata[:country]
        assert_empty metadata[:eMailList]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_address_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end