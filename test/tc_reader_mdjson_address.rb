# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator
# Stan Smith 2014-12-16 restructure tests to use schema examples

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9/module_address'

class TestReaderMdJsonAddress_v0_9 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v0_9/examples/address.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    def test_build_full_address_object

        hIn = @@hIn.clone

        intObj = {
            deliveryPoints: %w[deliveryPoint1 deliveryPoint2],
            city: 'city',
            adminArea: 'administrativeArea',
            postalCode: 'postalCode',
            country: 'country',
            eMailList: %w[example1@example.com example2@example.com]
        }

        assert_equal intObj, ADIWG::Mdtranslator::Readers::MdJson::Address.unpack(hIn)

    end

    def test_email_address_only

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

        assert_equal intObj, ADIWG::Mdtranslator::Readers::MdJson::Address.unpack(hIn)

    end

    def test_build_empty_address_object

        hIn = JSON.parse('{}')
        intObj = nil

        assert_equal intObj, ADIWG::Mdtranslator::Readers::MdJson::Address.unpack(hIn)

    end

end