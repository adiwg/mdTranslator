# MdTranslator - minitest of
# reader / mdJson / module_phone

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-01 refactored to mdJson 2.0.0
#   Stan Smith 2015-06-22 refactored setup after removal of globals
#   Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator
#   Stan Smith 2014-12-09 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_phone'

class TestReaderMdJsonPhone < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Phone
   aIn = TestReaderMdJsonParent.getJson('phone.json')
   @@hIn = aIn['phone'][0]

   def test_phone_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'contact.json', :fragment => 'phone')
      assert_empty errors

   end

   def test_complete_phone_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'phoneName', metadata[:phoneName]
      assert_equal '111-111-1111', metadata[:phoneNumber]
      assert_equal 3, metadata[:phoneServiceTypes].length
      assert_equal 'service1', metadata[:phoneServiceTypes][1]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_phone_number

      # empty phone number should return empty object
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['phoneNumber'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson phone number is missing'

   end

   def test_missing_phone_number

      # missing phone number should return empty object
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('phoneNumber')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson phone number is missing'

   end

   def test_empty_phone_service

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['service'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'phoneName', metadata[:phoneName]
      assert_equal '111-111-1111', metadata[:phoneNumber]
      assert_equal 0, metadata[:phoneServiceTypes].length
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson phone service type is missing'

   end

   def test_missing_phone_service

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('service')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'phoneName', metadata[:phoneName]
      assert_equal '111-111-1111', metadata[:phoneNumber]
      assert_equal 0, metadata[:phoneServiceTypes].length
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson phone service type is missing'

   end

   def test_empty_phone_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson phone object is empty'

   end

end
