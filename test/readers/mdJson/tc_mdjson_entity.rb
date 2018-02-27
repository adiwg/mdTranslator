# MdTranslator - minitest of
# reader / mdJson / module_entity

# History:
#  Stan Smith 2017-11-01 added entityReference and other new elements
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-07 refactored for mdJson 2.0
#  Stan Smith 2015-07-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entity'

class TestReaderMdJsonEntity < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Entity
   aIn = TestReaderMdJsonParent.getJson('entity.json')
   @@hIn = aIn['entity'][0]

   def test_entity_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'entity.json')
      assert_empty errors

   end

   def test_complete_entity_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'entityId', metadata[:entityId]
      assert_equal 'commonName', metadata[:entityName]
      assert_equal 'codeName', metadata[:entityCode]
      assert_equal 'alias0', metadata[:entityAlias][0]
      assert_equal 'alias1', metadata[:entityAlias][1]
      assert_equal 'definition', metadata[:entityDefinition]
      assert_equal 2, metadata[:entityReferences].length
      assert_equal 'entity reference title 1', metadata[:entityReferences][0][:title]
      assert_equal 'entity reference title 2', metadata[:entityReferences][1][:title]
      assert_equal 'primaryKeyAttributeCodeName0', metadata[:primaryKey][0]
      assert_equal 'primaryKeyAttributeCodeName1', metadata[:primaryKey][1]
      assert_empty metadata[:indexes]
      assert_empty metadata[:attributes]
      assert_empty metadata[:foreignKeys]
      assert_equal 'tab', metadata[:fieldSeparatorCharacter]
      assert_equal 4, metadata[:numberOfHeaderLines]
      assert_equal 'double', metadata[:quoteCharacter]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_entity_codeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['codeName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary entity code name is missing'

   end

   def test_missing_entity_codeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('codeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary entity code name is missing'

   end

   def test_empty_entity_definition

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['definition'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary entity definition is missing'

   end

   def test_missing_entity_definition

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('definition')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary entity definition is missing'

   end

   def test_empty_entity_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['entityId'] = ''
      hIn['commonName'] = ''
      hIn['alias'] = []
      hIn['entityReferences'] = []
      hIn['primaryKeyAttributeCodeName'] = []
      hIn['fieldSeparatorCharacter'] = ''
      hIn['numberOfHeaderLines'] = ''
      hIn['quoteCharacter'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:entityId]
      assert_nil metadata[:entityName]
      assert_empty metadata[:entityAlias]
      assert_empty metadata[:primaryKey]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_entity_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('entityId')
      hIn.delete('commonName')
      hIn.delete('alias')
      hIn.delete('entityReferences')
      hIn.delete('primaryKeyAttributeCodeName')
      hIn.delete('fieldSeparatorCharacter')
      hIn.delete('numberOfHeaderLines')
      hIn.delete('quoteCharacter')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:entityId]
      assert_nil metadata[:entityName]
      assert_empty metadata[:entityAlias]
      assert_empty metadata[:primaryKey]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_entity_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: data dictionary entity object is empty'

   end

end
