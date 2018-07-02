# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
#  Stan Smith 2018-06-14 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-15 added parent class to run successfully within rake
#  Stan Smith 2016-10-03 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_address'

class TestReaderMdJsonAddress < TestReaderMdJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Address

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.address
   mdHash[:addressType] << 'mailing'
   mdHash[:addressType] << 'physical'

   @@mdHash = mdHash

   def test_address_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'contact.json', fragment: 'address')
      assert_empty errors

   end

   def test_complete_address_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata[:addressTypes].length
      assert_equal 'mailing', metadata[:addressTypes][0]
      assert_equal 'physical', metadata[:addressTypes][1]
      assert_equal 'address description', metadata[:description]
      assert_equal 2, metadata[:deliveryPoints].length
      assert_equal 'address line 1', metadata[:deliveryPoints][0]
      assert_equal 'address line 2', metadata[:deliveryPoints][1]
      assert_equal 'city', metadata[:city]
      assert_equal 'administrative area', metadata[:adminArea]
      assert_equal 'postal code', metadata[:postalCode]
      assert_equal 'country', metadata[:country]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_address_addressType

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['addressType'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'test')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: address type is missing: CONTEXT is test'

   end

   def test_missing_address_addressType

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('addressType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'test')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: address type is missing: CONTEXT is test'

   end

   def test_empty_address_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'test')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: address object is empty: CONTEXT is test'

   end

end