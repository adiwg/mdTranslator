# MdTranslator - minitest of
# reader / mdJson / module_resourceType

# History:
#   Stan Smith 2017-02-15 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_resourceType'

class TestReaderMdJsonResourceType < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceType
   aIn = TestReaderMdJsonParent.getJson('resourceType.json')
   @@hIn = aIn['resourceType'][0]

   def test_resourceType_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'resourceType.json')
      assert_empty errors

   end

   def test_complete_resourceType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'type', metadata[:type]
      assert_equal 'name', metadata[:name]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_resourceType_empty_type

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['type'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: resource type is missing'

   end

   def test_resourceType_missing_type

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('type')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: resource type is missing'

   end

   def test_resourceType_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['name'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'type', metadata[:type]
      assert_nil metadata[:keywordId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_resourceType_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('name')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'type', metadata[:type]
      assert_nil metadata[:keywordId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_resourceType

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: resource type object is empty'

   end

end
