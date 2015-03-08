# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator
# Stan Smith 2014-12-16 restructure tests to use schema examples
# Stan Smith 2014-12-19 added test for blank elements

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_address'

class TestReaderMdJsonAddress_v1_0 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v1_0/examples/address.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Address

    def test_complete_address_object

        hIn = @@hIn.clone

        intObj = {
            deliveryPoints: %w[deliveryPoint1 deliveryPoint2],
            city: 'city',
            adminArea: 'administrativeArea',
            postalCode: 'postalCode',
            country: 'country',
            eMailList: %w[example1@example.com example2@example.com]
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_email_address_only

        # note: this test also serves to test missing elements
        # ... except for missing electronicMailAddress

        hIn = @@hIn.clone
        hIn.delete('deliveryPoint')
        hIn.delete('city')
        hIn.delete('administrativeArea')
        hIn.delete('postalCode')
        hIn.delete('country')

        intObj = {
            deliveryPoints: [],
            city: nil,
            adminArea: nil,
            postalCode: nil,
            country: nil,
            eMailList: %w[example1@example.com example2@example.com]
        }

        assert_equal intObj,@@NameSpace.unpack(hIn)

    end

    def test_empty_address_elements

        hIn = @@hIn.clone
        hIn['deliveryPoint'] = ['']
        hIn['city'] = ''
        hIn['administrativeArea'] = ''
        hIn['postalCode'] = ''
        hIn['country'] = ''
        hIn['electronicMailAddress'] = ['']

        intObj = {
            deliveryPoints: [],
            city: nil,
            adminArea: nil,
            postalCode: nil,
            country: nil,
            eMailList: []
        }

        assert_equal intObj,@@NameSpace.unpack(hIn)

    end

    def test_empty_address_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end