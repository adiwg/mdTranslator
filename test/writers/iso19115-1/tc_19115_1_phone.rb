# MdTranslator - minitest of
# writers / iso19115_1 / class_phone

# History:
#  Stan Smith 2019-05-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Phone < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_phone_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_phone',
                                                '//cit:phone[1]',
                                                '//cit:phone', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_phone_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      TDClass.add_phone(hIn[:contact][0],'222-222-2222',%w(facsimile))
      TDClass.add_phone(hIn[:contact][0],'333-333-3333',%w(subspace))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_phone',
                                                '//cit:phone[2]',
                                                '//cit:phone', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_phone',
                                                '//cit:phone[3]',
                                                '//cit:phone', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_phone',
                                                '//cit:phone[4]',
                                                '//cit:phone', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
