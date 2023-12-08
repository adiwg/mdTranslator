# MdTranslator - minitest of
# writers / iso19115_3 / class_organization

# History:
#  Stan Smith 2019-05-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Organizationl < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hContact = TDClass.build_organization_full
   mdHash[:contact] << hContact

   @@mdHash = mdHash

   def test_organization_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hContact = hIn[:contact][4]
      hContact[:logoGraphic].delete_at(1)
      hParty = hIn[:metadata][:metadataInfo][:metadataContact][0][:party][0]
      hParty[:contactId] = 'CID006'


      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_organization',
                                                '//cit:party[1]',
                                                '//cit:party', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_organization_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hContact = hIn[:contact][4]
      hContact[:memberOfOrganization] << 'CID001'
      hParty = hIn[:metadata][:metadataInfo][:metadataContact][0][:party][0]
      hParty[:contactId] = 'CID006'

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_organization',
                                                '//cit:party[2]',
                                                '//cit:party', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_organization_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hParty = hIn[:metadata][:metadataInfo][:metadataContact][0][:party][0]
      hParty[:contactId] = 'CID004'

      # missing elements
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_organization',
                                                '//cit:party[3]',
                                                '//cit:party', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # empty elements
      hContact = hIn[:contact][0]
      hContact[:logoGraphic] = []
      hContact[:memberOfOrganization] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_organization',
                                                '//cit:party[3]',
                                                '//cit:party', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
