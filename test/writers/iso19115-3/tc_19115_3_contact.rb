# MdTranslator - minitest of
# writers / iso19115_3 / class_contact

# History:
#  Stan Smith 2019-04-22 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Contact < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:contact] << TDClass.build_person_full() # CID005
   mdHash[:contact] << TDClass.build_organization_full() # CID006
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] = []
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] << {contactId: 'CID003'}
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] << {contactId: 'CID004'}
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] << {contactId: 'CID005'}
   mdHash[:metadata][:resourceInfo][:pointOfContact][0][:party] << {contactId: 'CID006'}

   @@mdHash = mdHash

   def test_contact

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # individual
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_contact',
                                                '//cit:party[1]',
                                                '//mri:pointOfContact/cit:CI_Responsibility/cit:party', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # organization
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_contact',
                                                '//cit:party[2]',
                                                '//mri:pointOfContact/cit:CI_Responsibility/cit:party', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
