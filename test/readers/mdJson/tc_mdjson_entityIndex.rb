# MdTranslator - minitest of
# reader / mdJson / module_entityIndex

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-07 refactored for mdJson 2.0
#   Stan Smith 2015-07-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entityIndex'

class TestReaderMdJsonEntityIndex < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::EntityIndex
   aIn = TestReaderMdJsonParent.getJson('entityIndex.json')
   @@hIn = aIn['index'][0]

   def test_entityIndex_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'entity.json', :fragment => 'index')
      assert_empty errors

   end

   def test_complete_entityIndex_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'codeName', metadata[:indexCode]
      refute metadata[:duplicate]
      assert_equal 'attributeCodeName0', metadata[:attributeNames][0]
      assert_equal 'attributeCodeName1', metadata[:attributeNames][1]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_entityIndex_name

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['codeName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson data dictionary entity index code name is missing'

   end

   def test_missing_entityIndex_name

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('codeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson data dictionary entity index code name is missing'

   end

   def test_empty_entityIndex_attributeCode

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['attributeCodeName'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson data dictionary entity index attribute list is missing'

   end

   def test_missing_entityIndex_attributeCode

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('attributeCodeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson data dictionary entity index attribute list is missing'

   end

   def test_empty_entityIndex_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson data dictionary entity index object is empty'

   end

end
