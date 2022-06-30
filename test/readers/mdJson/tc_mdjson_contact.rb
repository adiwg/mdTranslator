# MdTranslator - minitest of
# reader / mdJson / module_contact

# History:
#  Stan Smith 2018-06-17 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_contact'

class TestReaderMdJsonContact < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Contact

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = []
   mdHash << TDClass.person_full
   mdHash << TDClass.organization_full

   @@mdHash = mdHash

   def test_contact_schema

      # test is individual
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      errors = TestReaderMdJsonParent.testSchema(hIn[0], 'contact.json', remove: ['externalIdentifiers'])
      assert_empty errors

      # test is organization
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      errors = TestReaderMdJsonParent.testSchema(hIn[1], 'contact.json', :remove => ['positionName', 'externalIdentifiers'])
      assert_empty errors

   end

   def test_complete_contact_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn[0], hResponse)

      assert_equal 'CID005', metadata[:contactId]
      refute metadata[:isOrganization]
      assert_equal 'person name five', metadata[:name]
      assert_equal 'position name five', metadata[:positionName]
      assert_equal 2, metadata[:memberOfOrgs].length
      assert_equal 'CID002', metadata[:memberOfOrgs][0]
      assert_equal 'CID004', metadata[:memberOfOrgs][1]
      assert_equal 2, metadata[:logos].length
      assert_equal 2, metadata[:phones].length
      assert_equal 2, metadata[:addresses].length
      assert_equal 2, metadata[:eMailList].length
      assert_equal 'name1@adiwg.org', metadata[:eMailList][0]
      assert_equal 'name2@adiwg.org', metadata[:eMailList][1]
      assert_equal 2, metadata[:onlineResources].length
      assert_equal 2, metadata[:memberOfOrgs].length
      assert_equal 2, metadata[:hoursOfService].length
      assert_equal 'hours one', metadata[:hoursOfService][0]
      assert_equal 'hours two', metadata[:hoursOfService][1]
      assert_equal 'contact instructions', metadata[:contactInstructions]
      assert_equal 'contact type', metadata[:contactType]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_empty_id

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn[0].to_json)
      hIn['contactId'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: contact id is missing'

   end

   def test_contact_missing_id

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn[0].to_json)
      hIn.delete('contactId')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: contact id is missing'

   end

   def test_contact_empty_organization_name

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn[1].to_json)
      hIn['name'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: organization name is missing: CONTEXT is contact ID CID006'

   end

   def test_contact_missing_organization_name

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn[1].to_json)
      hIn.delete('name')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: organization name is missing: CONTEXT is contact ID CID006'

   end

   def test_contact_empty_individual_name_have_position

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn[0].to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_empty_individual_name_no_position

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn[0].to_json)
      hIn['name'] = ''
      hIn['positionName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: individual name and/or position are missing: CONTEXT is contact ID CID005'

   end

   def test_contact_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn[0].to_json)
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

      assert_equal 'CID005', metadata[:contactId]
      refute metadata[:isOrganization]
      assert_equal 'person name five', metadata[:name]
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn[0].to_json)
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

      assert_equal 'CID005', metadata[:contactId]
      refute metadata[:isOrganization]
      assert_equal 'person name five', metadata[:name]
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

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: contact object is empty'

   end

end
