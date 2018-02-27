# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
#   Stan Smith 2017-01-15 added parent class to run successfully within rake
#   Stan Smith 2016-10-03 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_address'

class TestReaderMdJsonAddress < TestReaderMdJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Address
   aIn = TestReaderMdJsonParent.getJson('address.json')
   @@hIn = aIn['address'][0]

   def test_address_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'contact.json', fragment: 'address')
      assert_empty errors

   end

   def test_complete_address_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata[:addressTypes].length
      assert_equal 'mailing', metadata[:addressTypes][0]
      assert_equal 'physical', metadata[:addressTypes][1]
      assert_equal 'description', metadata[:description]
      assert_equal 2, metadata[:deliveryPoints].length
      assert_equal 'deliveryPoint0', metadata[:deliveryPoints][0]
      assert_equal 'deliveryPoint1', metadata[:deliveryPoints][1]
      assert_equal 'city', metadata[:city]
      assert_equal 'administrativeArea', metadata[:adminArea]
      assert_equal 'postalCode', metadata[:postalCode]
      assert_equal 'country', metadata[:country]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_address_addressType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['addressType'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: address type is missing'

   end

   def test_missing_address_addressType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('addressType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: address type is missing'

   end

   def test_empty_address_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['description'] = ''
      hIn['deliveryPoint'] = []
      hIn['city'] = ''
      hIn['administrativeArea'] = ''
      hIn['postalCode'] = ''
      hIn['country'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:description]
      assert_empty metadata[:deliveryPoints]
      assert_nil metadata[:city]
      assert_nil metadata[:adminArea]
      assert_nil metadata[:postalCode]
      assert_nil metadata[:country]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_address_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('description')
      hIn.delete('deliveryPoint')
      hIn.delete('city')
      hIn.delete('administrativeArea')
      hIn.delete('postalCode')
      hIn.delete('country')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:description]
      assert_empty metadata[:deliveryPoints]
      assert_nil metadata[:city]
      assert_nil metadata[:adminArea]
      assert_nil metadata[:postalCode]
      assert_nil metadata[:country]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_address_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: address object is empty'

   end

end