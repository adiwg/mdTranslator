# MdTranslator - minitest of
# reader / mdJson / module_phone

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_phone'

class TestReaderMdJsonPhone_v1_0 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v1_0/examples/contact.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]['phoneBook'][0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Phone

    def test_complete_phone_object


        hIn = @@hIn.clone
        intObj = []
        intObj << {
            phoneServiceType: 'service11',
            phoneName: 'phoneName1',
            phoneNumber: '111-111-1111'
        }
        intObj << {
            phoneServiceType: 'service12',
            phoneName: 'phoneName1',
            phoneNumber: '111-111-1111'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_phone_service

        hIn = @@hIn.clone
        hIn.delete('service')

        intObj = []
        intObj << {
            phoneServiceType: 'voice',
            phoneName: 'phoneName1',
            phoneNumber: '111-111-1111'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_phone_service

        hIn = @@hIn.clone
        hIn['service'] = ''

        intObj = []
        intObj << {
            phoneServiceType: 'voice',
            phoneName: 'phoneName1',
            phoneNumber: '111-111-1111'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_phone_number

        # missing phone number should return empty object
        hIn = @@hIn.clone
        hIn.delete('phoneNumber')

        intObj = []

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_phone_number

        # empty phone number should return empty object
        hIn = @@hIn.clone
        hIn['phoneNumber'] = ''

        intObj = []

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_phone_object

        hIn = {}
        intObj = []

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

end
