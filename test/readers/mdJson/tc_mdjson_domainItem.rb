# MdTranslator - minitest of
# reader / mdJson / module_domainMember

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-07 refactored for mdJson 2.0
#   Stan Smith 2015-07-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_domainItem'

class TestReaderMdJsonDomainItem < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DomainItem
   aIn = TestReaderMdJsonParent.getJson('domainItem.json')
   @@hIn = aIn['domainItem'][0]

   # TODO reinstate on schema update
   # def test_domainItem_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'domain.json', :fragment=>'domainItem')
   #     assert_empty errors
   #
   # end

   def test_complete_domainItem_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'name', metadata[:itemName]
      assert_equal 'value', metadata[:itemValue]
      assert_equal 'definition', metadata[:itemDefinition]
      assert_equal 'domain item reference title', metadata[:itemReference][:title]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_domainItem_name

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['name'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain item name is missing'

   end

   def test_missing_domainItem_name

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('name')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain item name is missing'

   end

   def test_empty_domainItem_value

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['value'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain item value is missing'

   end

   def test_missing_domainItem_value

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('value')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain item value is missing'

   end

   def test_empty_domainItem_definition

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['definition'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain item definition is missing'

   end

   def test_missing_domainItem_definition

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['definition'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain item definition is missing'

   end

   def test_empty_domainItem_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: data dictionary domain item object is empty'

   end

end
