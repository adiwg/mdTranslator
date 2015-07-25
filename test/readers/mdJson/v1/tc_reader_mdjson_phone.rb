# MdTranslator - minitest of
# reader / mdJson / module_phone

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator
# Stan Smith 2015-06-22 refactored setup to after removal of globals

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.2.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_phone'

class TestReaderMdJsonPhone_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Phone
    @@responseObj = {}

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'contact.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]['phoneBook'][0]

    def test_complete_phone_object

        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata.length, 2
        assert_equal metadata[0][:phoneServiceType], 'service11'
        assert_equal metadata[0][:phoneName],        'phoneName1'
        assert_equal metadata[0][:phoneNumber],      '111-111-1111'
        assert_equal metadata[1][:phoneServiceType], 'service12'
        assert_equal metadata[1][:phoneName],        'phoneName1'
        assert_equal metadata[1][:phoneNumber],      '111-111-1111'
    end

    def test_empty_phone_service
        # empty service should default to 'voice'
        hIn = @@hIn.clone
        hIn['service'] = []
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[0][:phoneServiceType], 'voice'
        assert_equal metadata[0][:phoneName],        'phoneName1'
        assert_equal metadata[0][:phoneNumber],      '111-111-1111'
    end

    def test_empty_phone_number
        # empty phone number should return empty object
        hIn = @@hIn.clone
        hIn['phoneNumber'] = ''
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_empty metadata
    end

    def test_missing_phone_number
        # missing phone number should return empty object
        hIn = @@hIn.clone
        hIn.delete('phoneNumber')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_empty metadata
    end

    def test_missing_phone_service
        hIn = @@hIn.clone
        hIn.delete('service')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[0][:phoneServiceType], 'voice'
        assert_equal metadata[0][:phoneName],        'phoneName1'
        assert_equal metadata[0][:phoneNumber],      '111-111-1111'
    end

    def test_empty_phone_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_empty metadata
    end

end
