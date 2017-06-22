# MdTranslator - minitest of
# reader / sbJson / module_contact

# History:
#   Stan Smith 2017-06-21 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_contact'

class TestReaderSbJsonContact < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Contact
   @@hIn = TestReaderSbJsonParent.getJson('contact.json')

   def test_complete_contact

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_equal 3, metadata.length

      # test person contact
      hContact = metadata[0]
      refute_nil hContact[:contactId]
      refute hContact[:isOrganization]
      assert_equal 'Robert N Prescott', hContact[:name]
      assert_equal 'Computer Programmer', hContact[:positionName]
      assert_equal metadata[1][:contactId], hContact[:memberOfOrgs][0]
      assert_equal 2, hContact[:logos].length

      # logos
      hLogo = hContact[:logos][0]
      assert_equal 'logoUrl', hLogo[:graphicName]
      assert_equal 1, hLogo[:graphicURI].length
      hUri = hLogo[:graphicURI][0]
      assert_equal 'http://my.usgs.gov/logosMed/USGSLogo.gif', hUri[:olResURI]

      hLogo = hContact[:logos][1]
      assert_equal 'smallLogoUrl', hLogo[:graphicName]
      assert_equal 1, hLogo[:graphicURI].length
      hUri = hLogo[:graphicURI][0]
      assert_equal 'http://my.usgs.gov/logosSmall/USGSLogo.gif', hUri[:olResURI]

      # phones
      assert_equal 3, hContact[:phones].length

      hPhone = hContact[:phones][0]
      assert_nil hPhone[:phoneName]
      assert_equal '222-222-2222', hPhone[:phoneNumber]
      assert_equal 1, hPhone[:phoneServiceTypes].length
      assert_equal 'voice', hPhone[:phoneServiceTypes][0]

      hPhone = hContact[:phones][1]
      assert_nil hPhone[:phoneName]
      assert_equal '333-333-3333', hPhone[:phoneNumber]
      assert_equal 1, hPhone[:phoneServiceTypes].length
      assert_equal 'facsimile', hPhone[:phoneServiceTypes][0]

      hPhone = hContact[:phones][2]
      assert_nil hPhone[:phoneName]
      assert_equal '111-111-1111', hPhone[:phoneNumber]
      assert_equal 1, hPhone[:phoneServiceTypes].length
      assert_equal 'tty', hPhone[:phoneServiceTypes][0]

      # address (see primary location)
      # TODO refute_empty hContact[:addresses]

      assert_equal 1, hContact[:eMailList].length
      assert_equal 'rprescott@usgs.gov', hContact[:eMailList][0]
      assert_empty hContact[:onlineResources]
      assert_equal 1, hContact[:hoursOfService].length
      assert_equal '8-4', hContact[:hoursOfService][0]
      assert_equal 'test', hContact[:contactInstructions]
      assert_equal 'Distributor', hContact[:contactType]

      # test organization contact
      hContact = metadata[1]
      refute_nil hContact[:contactId]
      assert hContact[:isOrganization]
      assert_equal 'Fort Collins Science Center', hContact[:name]

      # test response object
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(1)
      hIn0 = hIn['contacts'][0]
      hIn0['oldPartyId'] = ''
      hIn0['sourceId'] = ''
      hIn0['organizationsPerson'] = ''
      hIn0['ttyPhone'] = ''
      hIn0['officePhone'] = ''
      hIn0['faxPhone'] = ''
      hIn0['hours'] = ''
      hIn0['instructions'] = ''
      hIn0['email'] = ''
      hIn0['active'] = ''
      hIn0['jobTitle'] = ''
      hIn0['personalTitle'] = ''
      hIn0['firstName'] = ''
      hIn0['middleName'] = ''
      hIn0['lastName'] = ''
      hIn0['note'] = ''
      hIn0['aliases'] = []
      hIn0['fbmsCodes'] = []
      hIn0['logoUrl'] = ''
      hIn0['smallLogoUrl'] = ''
      hIn0['organization'] = {}
      hIn0['primaryLocation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_equal 1, metadata.length

      # test person contact
      hContact = metadata[0]
      refute_nil hContact[:contactId]
      refute hContact[:isOrganization]
      assert_equal 'Robert N Prescott', hContact[:name]
      assert_equal 'Distributor', hContact[:contactType]

      # empty elements
      assert_nil hContact[:positionName]
      assert_empty hContact[:memberOfOrgs]
      assert_empty hContact[:logos]
      assert_empty hContact[:phones]
      assert_empty hContact[:addresses]
      assert_empty hContact[:eMailList]
      assert_empty hContact[:onlineResources]
      assert_empty hContact[:hoursOfService]
      assert_nil hContact[:contactInstructions]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_equal 1, metadata.length

      # test person contact
      hContact = metadata[0]
      refute_nil hContact[:contactId]
      refute hContact[:isOrganization]
      assert_equal 'Jordan S Read', hContact[:name]
      assert_equal 'Metadata Contact', hContact[:contactType]

      # empty elements
      assert_nil hContact[:positionName]
      assert_empty hContact[:memberOfOrgs]
      assert_empty hContact[:logos]
      assert_empty hContact[:phones]
      assert_empty hContact[:addresses]
      assert_empty hContact[:eMailList]
      assert_empty hContact[:onlineResources]
      assert_empty hContact[:hoursOfService]
      assert_nil hContact[:contactInstructions]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_name_empty

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0]['name'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_name_missing

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0].delete('name')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_contactType_empty

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0]['contactType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_contactType_missing

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0].delete('contactType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_contactType_invalid

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0]['contactType'] = 'badName'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_type_empty

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0]['type'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_type_missing

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0].delete('type')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
