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

      # addresses
      assert_equal 2, hContact[:addresses].length

      hAddress = hContact[:addresses][0]
      assert_equal 1, hAddress[:addressTypes].length
      assert_equal 'physical', hAddress[:addressTypes][0]
      assert_equal 2, hAddress[:deliveryPoints].length
      assert_equal '2150 Centre Avenue Bldg C', hAddress[:deliveryPoints][0]
      assert_equal 'Room 258', hAddress[:deliveryPoints][1]
      assert_equal 'Fort Collins', hAddress[:city]
      assert_equal 'CO', hAddress[:adminArea]
      assert_equal '80526', hAddress[:postalCode]
      assert_equal 'USA', hAddress[:country]

      hAddress = hContact[:addresses][1]
      assert_equal 1, hAddress[:addressTypes].length
      assert_equal 'mailing', hAddress[:addressTypes][0]
      assert_equal 1, hAddress[:deliveryPoints].length

      # other contact information
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
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_empty_elements

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hContact = hIn['contacts'][0]
      hContact['contactType'] = ''
      hContact['oldPartyId'] = ''
      hContact['sourceId'] = ''
      hContact['organizationsPerson'] = ''
      hContact['ttyPhone'] = ''
      hContact['officePhone'] = ''
      hContact['faxPhone'] = ''
      hContact['hours'] = ''
      hContact['instructions'] = ''
      hContact['email'] = ''
      hContact['active'] = ''
      hContact['jobTitle'] = ''
      hContact['personalTitle'] = ''
      hContact['firstName'] = ''
      hContact['middleName'] = ''
      hContact['lastName'] = ''
      hContact['note'] = ''
      hContact['aliases'] = []
      hContact['fbmsCodes'] = []
      hContact['logoUrl'] = ''
      hContact['smallLogoUrl'] = ''
      hContact['organization'] = {}
      hContact['primaryLocation'] = {}

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
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_missing_elements

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)

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
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_name_empty

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0]['name'] = ''

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_name_missing

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0].delete('name')

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_contact_contactType_invalid

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contacts'].delete_at(0)
      hIn['contacts'][0]['contactType'] = 'badName'

      metadata = @@NameSpace.unpack(hIn, [], hResponse)

      # test array
      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
