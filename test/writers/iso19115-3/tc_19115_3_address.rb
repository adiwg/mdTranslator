# MdTranslator - minitest of
# writers / iso19115_3 / class_address

# History:
#  Stan Smith 2019-04-11 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Address < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   TDClass.add_email(mdHash[:contact][0], 'e1.mail@address.org')

   @@mdHash = mdHash

   def test_contact_address_complete_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0][:deliveryPoint].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[1]',
                                                '//cit:address', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[2]',
                                                '//cit:address', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_contact_complete_multi

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      TDClass.add_email(hIn[:contact][0], 'e2.mail@address.org')

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[3]',
                                                '//cit:address', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[4]',
                                                '//cit:address', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_address_multi

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      TDClass.add_address(hIn[:contact][0], ['physical'])

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[5]',
                                                '//cit:address', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[6]',
                                                '//cit:address', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[7]',
                                                '//cit:address', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_address_empty_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0][:deliveryPoint] = []
      hIn[:contact][0][:address][0][:city] = ''
      hIn[:contact][0][:address][0][:administrativeArea] = ''
      hIn[:contact][0][:address][0][:postalCode] = ''
      hIn[:contact][0][:address][0][:country] = ''
      hIn[:contact][0][:electronicMailAddress] = []


      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[8]',
                                                     '//cit:address', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_address_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0].delete(:deliveryPoint)
      hIn[:contact][0][:address][0].delete(:city)
      hIn[:contact][0][:address][0].delete(:administrativeArea)
      hIn[:contact][0][:address][0].delete(:postalCode)
      hIn[:contact][0][:address][0].delete(:country)
      hIn[:contact][0].delete(:electronicMailAddress)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[8]',
                                                    '//cit:address', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_address_email_only

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[9]',
                                                '//cit:address', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[10]',
                                                '//cit:address', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_address_empty

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address] = []
      hIn[:contact][0][:eMailList] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[11]',
                                                '//cit:address', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_address_missing

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0].delete(:address)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_address', '//cit:address[11]',
                                                '//cit:address', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
