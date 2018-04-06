# MdTranslator - minitest of
# writers / iso19110 / class_phone

# History:
#  Stan Smith 2018-04-02 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-01 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110Phone < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary 1
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_phone_single

      hReturn = TestWriter19110Parent.get_complete(@@mdHash, '19110_phone',
                                                   '//gmd:phone[1]', '//gmd:phone')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_phone_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      TDClass.add_phone(hIn[:contact][0], '222-222-2222', 'voice')
      TDClass.add_phone(hIn[:contact][0], '333-333-3333', 'fax')
      TDClass.add_phone(hIn[:contact][0], '444-444-4444', 'facsimile')

      hReturn = TestWriter19110Parent.get_complete(hIn, '19110_phone',
                                                   '//gmd:phone[2]', '//gmd:phone')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_phone_unknown

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:phone] = []
      TDClass.add_phone(hIn[:contact][0], '111-111-1111', 'mobile')

      hReturn = TestWriter19110Parent.get_complete(hIn, '19110_phone',
                                                   '//gmd:phone[3]', '//gmd:phone')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_phone_empty

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:phone] = []

      hReturn = TestWriter19110Parent.get_complete(hIn, '19110_phone',
                                                   '//gmd:phone[4]', '//gmd:phone')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_phone_missing

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0].delete(:phone)

      hReturn = TestWriter19110Parent.get_complete(hIn, '19110_phone',
                                                   '//gmd:phone[4]', '//gmd:phone')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
