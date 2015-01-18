# MdTranslator - minitest of
# reader / mdJson / module_contacts

# History:
# Stan Smith 2014-12-19 original script

#set globals used in testing
#set globals used by mdJson_reader.rb before requiring module
$response = {
    readerVersionUsed: '0.9',
    readerExecutionPas: true,
    readerExecutionMessages: []
}

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9/module_contacts'

class TestReaderMdJsonContact_v0_9 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v0_9/examples/contact.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Contact

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

        assert_equal intObj, @@NameSpace.unpack(hIn)

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

        assert_equal intObj, @@NameSpace.unpack(hIn)

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

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_contact_id

        hIn = @@hIn.clone
        hIn.delete('contactId')

        intObj = nil

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_blank_contact_id

        hIn = @@hIn.clone
        hIn['contactId'] = ''

        intObj = nil

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_contact_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end