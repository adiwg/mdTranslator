# MdTranslator - minitest of
# writers / iso19115_2 / class_contact

# History:
#  Stan Smith 2018-04-17 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-11-21 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Contact < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:contact] << TDClass.build_person_full()
   mdHash[:contact] << TDClass.build_organization_full()
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] = []
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] << {contactId: 'CID003'}
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] << {contactId: 'CID004'}
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] << {contactId: 'CID005'}
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] << {contactId: 'CID006'}

   @@mdHash = mdHash

   def test_citation_person_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_contact',
                                                '//gmd:pointOfContact[1]',
                                                '//gmd:pointOfContact', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_citation_person_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_contact',
                                                '//gmd:pointOfContact[2]',
                                                '//gmd:pointOfContact', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_citation_organization_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_contact',
                                                '//gmd:pointOfContact[3]',
                                                '//gmd:pointOfContact', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_citation_organization_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_contact',
                                                '//gmd:pointOfContact[4]',
                                                '//gmd:pointOfContact', 3)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
