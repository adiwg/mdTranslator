# MdTranslator - minitest of
# reader / mdJson / module_contact

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_contact'

class TestReaderMdJsonContact < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Contact
    aIn = TestReaderMdJsonParent.getJson('contact.json')
    @@hIn = aIn['contact'][0]

    def test_complete_contact_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'contactId', metadata[:contactId]
        assert metadata[:isOrganization]
        assert_equal 'name', metadata[:name]
        assert_equal 'positionName', metadata[:positionName]
        assert_equal 2, metadata[:memberOfOrgs].length
        assert_equal 'memberOfOrganization0', metadata[:memberOfOrgs][0]
        assert_equal 'memberOfOrganization1', metadata[:memberOfOrgs][1]
        assert_equal 2, metadata[:logos].length
        assert_equal 2, metadata[:phones].length
        assert_equal 2, metadata[:addresses].length
        assert_equal 2, metadata[:eMailList].length
        assert_equal 'electronicMailAddress0', metadata[:eMailList][0]
        assert_equal 'electronicMailAddress1', metadata[:eMailList][1]
        assert_equal 2, metadata[:onlineResources].length
        assert_equal 2, metadata[:memberOfOrgs].length
        assert_equal 2, metadata[:hoursOfService].length
        assert_equal 'hoursOfService0', metadata[:hoursOfService][0]
        assert_equal 'hoursOfService1', metadata[:hoursOfService][1]
        assert_equal 'contactInstructions', metadata[:contactInstructions]
        assert_equal 'contactType', metadata[:contactType]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_contact_empty_id

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['contactId'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_contact_missing_id

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('contactId')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_contact_empty_name

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['name'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_contact_missing_name

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('name')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_contact_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['positionName'] = ''
        hIn['memberOfOrganization'] = []
        hIn['logoGraphic'] = []
        hIn['phone'] = []
        hIn['address'] = []
        hIn['electronicMailAddress'] = []
        hIn['onlineResource'] = []
        hIn['hoursOfService'] = []
        hIn['contactInstructions'] = ''
        hIn['contactType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'contactId', metadata[:contactId]
        assert metadata[:isOrganization]
        assert_equal 'name', metadata[:name]
        assert_nil metadata[:positionName]
        assert_empty metadata[:memberOfOrgs]
        assert_empty metadata[:logos]
        assert_empty metadata[:phones]
        assert_empty metadata[:addresses]
        assert_empty metadata[:eMailList]
        assert_empty metadata[:onlineResources]
        assert_empty metadata[:memberOfOrgs]
        assert_empty metadata[:hoursOfService]
        assert_nil metadata[:contactInstructions]
        assert_nil metadata[:contactType]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_contact_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('positionName')
        hIn.delete('memberOfOrganization')
        hIn.delete('logoGraphic')
        hIn.delete('phone')
        hIn.delete('address')
        hIn.delete('electronicMailAddress')
        hIn.delete('onlineResource')
        hIn.delete('hoursOfService')
        hIn.delete('contactInstructions')
        hIn.delete('contactType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'contactId', metadata[:contactId]
        assert metadata[:isOrganization]
        assert_equal 'name', metadata[:name]
        assert_nil metadata[:positionName]
        assert_empty metadata[:memberOfOrgs]
        assert_empty metadata[:logos]
        assert_empty metadata[:phones]
        assert_empty metadata[:addresses]
        assert_empty metadata[:eMailList]
        assert_empty metadata[:onlineResources]
        assert_empty metadata[:memberOfOrgs]
        assert_empty metadata[:hoursOfService]
        assert_nil metadata[:contactInstructions]
        assert_nil metadata[:contactType]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_contact_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
