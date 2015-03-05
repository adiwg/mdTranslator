# MdTranslator - minitest of
# reader / mdJson / module_responsibleParty

# History:
# Stan Smith 2015-01-18 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_responsibleParty'

class TestReaderMdJsonResponsibleParty_v1_0 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v1_0/examples/contactRef.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResponsibleParty

    def test_complete_responsibleParty_object

        hIn = @@hIn.clone

        intObj = {
            contactId: 'contactId',
            roleName: 'role'
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_missing_responsibleParty_elements

        # except for contactId

        hIn = @@hIn.clone
        hIn.delete('role')

        intObj = {
            contactId: 'contactId',
            roleName: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_responsibleParty_elements

        hIn = @@hIn.clone
        hIn['contactId'] = ''
        hIn['role'] = ''

        intObj = {
            contactId: nil,
            roleName: nil
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_responsibleParty_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end
