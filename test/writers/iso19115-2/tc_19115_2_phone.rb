# MdTranslator - minitest of
# writers / iso19115_2 / class_phone

# History:
#  Stan Smith 2018-04-26 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2016-11-20 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Phone < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:metadataInfo][:metadataContact][0][:party][0] = { contactId: 'CID003' }
   mdHash[:contact][2][:phone] = []
   TDClass.add_phone(mdHash[:contact][2],'111-111-1111',%w(voice))
   TDClass.add_phone(mdHash[:contact][2],'222-222-2222',%w(facsimile))
   TDClass.add_phone(mdHash[:contact][2],'333-333-3333',%w(voice fax))

   @@mdHash = mdHash

   def test_phone_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_phone',
                                                '//gmd:phone[1]',
                                                '//gmd:phone', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_phone_unsupported

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][2][:phone] = []
      TDClass.add_phone(hIn[:contact][2],'444-444-4444',%w(unsupported))


      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_phone',
                                                '//gmd:phone[2]',
                                                '//gmd:phone', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
