# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9/module_address'


class TestReaderMdJsonAddress_v0_9 < MiniTest::Test

    def test_build_full_address_object

        json_string = '{ ' +
            '"deliveryPoint": ["Line 1","2 Line"],' +
            '"city": "City",' +
            '"administrativeArea": "ST",' +
            '"postalCode": "99999-9999",' +
            '"country": "US",' +
            '"electronicMailAddress": ["hello@example.com","bye@example.com"]' +
            '}'
        hIn = JSON.parse(json_string)

        intObj = {
            deliveryPoints: ['Line 1', '2 Line'],
            city: 'City',
            adminArea: 'ST',
            postalCode: '99999-9999',
            country: 'US',
            eMailList: %w[hello@example.com bye@example.com]
        }

        assert_equal intObj, ADIWG::Mdtranslator::Readers::MdJson::Address.unpack(hIn)

    end

    def test_email_address_only

        json_string = '{ ' +
            '"electronicMailAddress": ["hello@example.com"]' +
            '}'
        hIn = JSON.parse(json_string)

        intObj = {
            deliveryPoints: [],
            city: nil,
            adminArea: nil,
            postalCode: nil,
            country: nil,
            eMailList: %w[hello@example.com]
        }

        assert_equal intObj, ADIWG::Mdtranslator::Readers::MdJson::Address.unpack(hIn)

    end

    def test_build_empty_address_object

        json_string = '{}'
        hIn = JSON.parse(json_string)
        intObj = nil

        assert_equal intObj, ADIWG::Mdtranslator::Readers::MdJson::Address.unpack(hIn)

    end


end