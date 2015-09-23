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
                    readerVersionUsed: '1.1.0'
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

class TestReaderMdJsonContact_v1 < MiniTest::Test

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
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:contactId], 'contactId'
        assert_equal metadata[:indName],   'individualName'
        assert_equal metadata[:orgName],   'organizationName'
        assert_equal metadata[:position],  'positionName'
        refute_empty metadata[:phones]
        refute_empty metadata[:address]
        refute_empty metadata[:onlineRes]
        assert_equal metadata[:contactInstructions], 'contactInstructions'
    end

    def test_empty_contactId
        hIn = @@hIn.clone
        hIn['contactId'] = ''
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_missing_contactId
        hIn = @@hIn.clone
        hIn.delete('contactId')
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
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
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:contactId], 'contactId'
        assert_nil metadata[:indName]
        assert_nil metadata[:orgName]
        assert_nil metadata[:position]
        assert_empty metadata[:phones]
        assert_empty metadata[:address]
        assert_empty metadata[:onlineRes]
        assert_nil metadata[:contactInstructions]
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
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:contactId], 'contactId'
        assert_nil metadata[:indName]
        assert_nil metadata[:orgName]
        assert_nil metadata[:position]
        assert_empty metadata[:phones]
        assert_empty metadata[:address]
        assert_empty metadata[:onlineRes]
        assert_nil metadata[:contactInstructions]
    end

    def test_empty_contact_object
        hIn = {}
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
    end

end