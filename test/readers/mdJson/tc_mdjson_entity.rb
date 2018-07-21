# MdTranslator - minitest of
# reader / mdJson / module_entity

# History:
#  Stan Smith 2018-06-18 refactored to use mdJson construction helpers
#  Stan Smith 2017-11-01 added entityReference and other new elements
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-07 refactored for mdJson 2.0
#  Stan Smith 2015-07-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entity'

class TestReaderMdJsonEntity < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Entity

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.entity
   mdHash[:entityReference] << TDClass.citation
   mdHash[:entityReference] << TDClass.citation
   mdHash[:primaryKeyAttributeCodeName] = ['key code one', 'key code two']
   mdHash[:index] << TDClass.index
   mdHash[:index] << TDClass.index
   hAttribute = TDClass.entityAttribute
   hAttribute[:attributeReference] = TDClass.citation_title
   mdHash[:attribute] << hAttribute
   mdHash[:attribute] << hAttribute
   mdHash[:foreignKey] << TDClass.foreignKey
   mdHash[:foreignKey] << TDClass.foreignKey

   @@mdHash = mdHash

   def test_entity_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'entity.json')
      assert_empty errors

   end

   def test_complete_entity_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'entity ID', metadata[:entityId]
      assert_equal 'entity common name', metadata[:entityName]
      assert_equal 'entity code name', metadata[:entityCode]
      assert_equal 'alias one', metadata[:entityAlias][0]
      assert_equal 'alias two', metadata[:entityAlias][1]
      assert_equal 'entity definition', metadata[:entityDefinition]
      assert_equal 2, metadata[:entityReferences].length
      assert_equal 'citation title', metadata[:entityReferences][0][:title]
      assert_equal 'citation title', metadata[:entityReferences][1][:title]
      assert_equal 'key code one', metadata[:primaryKey][0]
      assert_equal 'key code two', metadata[:primaryKey][1]
      assert_equal 2, metadata[:indexes].length
      assert_equal 2, metadata[:attributes].length
      assert_equal 2, metadata[:foreignKeys].length
      assert_equal 'tab', metadata[:fieldSeparatorCharacter]
      assert_equal 2, metadata[:numberOfHeaderLines]
      assert_equal 'double quote', metadata[:quoteCharacter]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_entity_codeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['codeName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary entity code name is missing'

   end

   def test_missing_entity_codeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('codeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary entity code name is missing'

   end

   def test_empty_entity_definition

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['definition'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity definition is missing: CONTEXT is entity code name entity code name'

   end

   def test_missing_entity_definition

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('definition')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity definition is missing: CONTEXT is entity code name entity code name'

   end

   def test_empty_entity_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: data dictionary entity object is empty'

   end

end
