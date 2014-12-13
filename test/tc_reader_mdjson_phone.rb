# MdTranslator - minitest of
# reader / mdJson / module_phone

# History:
# Stan Smith 2014-12-09 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9.0/module_phone'

class TestReaderMdJsonAddress < MiniTest::Test

    def test_build_full_phone_object

        json_string = '{ ' +
            '"phoneName": "Name",' +
            '"phoneNumber": "(999)999-9999",' +
            '"service": ["voice","fax","sms"]' +
            '}'
        hIn = JSON.parse(json_string)

        intObj = []
        intObjPart = {
            phoneServiceType: 'voice',
            phoneName: 'Name',
            phoneNumber: '(999)999-9999'
        }
        intObj << intObjPart
        intObjPart = {
            phoneServiceType: 'fax',
            phoneName: 'Name',
            phoneNumber: '(999)999-9999'
        }
        intObj << intObjPart
        intObjPart = {
            phoneServiceType: 'sms',
            phoneName: 'Name',
            phoneNumber: '(999)999-9999'
        }
        intObj << intObjPart

        assert_equal intObj, Md_Phone.unpack(hIn)

    end

    def test_missing_phone_service

        json_string = '{ ' +
            '"phoneName": "Name",' +
            '"phoneNumber": "(999)999-9999"' +
            '}'
        hIn = JSON.parse(json_string)

        intObj = []
        intObjPart = {
            phoneServiceType: 'voice',
            phoneName: 'Name',
            phoneNumber: '(999)999-9999'
        }
        intObj << intObjPart

        assert_equal intObj, Md_Phone.unpack(hIn)

    end

    def test_null_phone_service

        json_string = '{ ' +
            '"phoneName": "Name",' +
            '"phoneNumber": "(999)999-9999",' +
            '"service": ""' +
            '}'
        hIn = JSON.parse(json_string)

        intObj = []
        intObjPart = {
            phoneServiceType: 'voice',
            phoneName: 'Name',
            phoneNumber: '(999)999-9999'
        }
        intObj << intObjPart

        assert_equal intObj, Md_Phone.unpack(hIn)

    end

    def test_missing_phone_number

        json_string = '{ ' +
            '"service": ["service"]' +
            '}'
        hIn = JSON.parse(json_string)

        intObj = []

        assert_equal intObj, Md_Phone.unpack(hIn)

    end

    def test_null_phone_number

        # missing phone number should return empty object
        json_string = '{ ' +
            '"phoneName": "",' +
            '"phoneNumber": "",' +
            '"service": ""' +
            '}'
        hIn = JSON.parse(json_string)

        intObj = []

        assert_equal intObj, Md_Phone.unpack(hIn)

    end

    def test_build_empty_phone_object

        json_string = '{}'
        hIn = JSON.parse(json_string)
        intObj = []

        assert_equal intObj, Md_Phone.unpack(hIn)

    end

end
