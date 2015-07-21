# MdTranslator - minitest of
# reader / mdJson / module_contacts

# History:
# Stan Smith 2014-12-19 original script
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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_contacts'

class TestReaderMdJsonContact_v1_0 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Contact
    @@responseObj = {
        readerVersionUsed: '1.0',
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'contact.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]

    def test_complete_contact_object

        hIn = @@hIn.clone
        hIn.delete('phoneBook')
        hIn.delete('address')
        hIn.delete('onlineResource')

        intObj = {
            contactId: 'contactId',
            indName: 'individualName',
            orgName: 'organizationName',
            position: 'positionName',
            phones: [],
            address: {},
            onlineRes: [],
            contactInstructions: 'contactInstructions'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_contact_elements

        hIn = @@hIn.clone
        hIn['individualName'] = ''
        hIn['organizationName'] = ''
        hIn['positionName'] = ''
        hIn['onlineResource'] = []
        hIn['contactInstructions'] = ''
        hIn['phoneBook'] = []
        hIn['address'] = {}

        intObj = {
            contactId: 'contactId',
            indName: nil,
            orgName: nil,
            position: nil,
            phones: [],
            address: {},
            onlineRes: [],
            contactInstructions: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_missing_contact_elements

        hIn = @@hIn.clone
        hIn.delete('individualName')
        hIn.delete('organizationName')
        hIn.delete('positionName')
        hIn.delete('onlineResource')
        hIn.delete('contactInstructions')
        hIn.delete('phoneBook')
        hIn.delete('address')

        intObj = {
            contactId: 'contactId',
            indName: nil,
            orgName: nil,
            position: nil,
            phones: [],
            address: {},
            onlineRes: [],
            contactInstructions: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_missing_contact_id

        hIn = @@hIn.clone
        hIn.delete('contactId')
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []

        assert_equal nil, @@NameSpace.unpack(hIn, @@responseObj)
        assert_equal false, @@responseObj[:readerExecutionPass]
        refute_empty @@responseObj[:readerExecutionMessages]

    end

    def test_blank_contact_id

        hIn = @@hIn.clone
        hIn['contactId'] = ''
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []

        assert_equal nil, @@NameSpace.unpack(hIn, @@responseObj)
        assert_equal false, @@responseObj[:readerExecutionPass]
        refute_empty @@responseObj[:readerExecutionMessages]

    end

    def test_empty_contact_object

        hIn = {}
        @@responseObj[:readerExecutionPass] = true
        @@responseObj[:readerExecutionMessages] = []

        assert_equal nil, @@NameSpace.unpack(hIn, @@responseObj)
        assert_equal true, @@responseObj[:readerExecutionPass]
        assert_empty @@responseObj[:readerExecutionMessages]

    end

end