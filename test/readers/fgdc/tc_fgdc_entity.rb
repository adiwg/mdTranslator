# MdTranslator - minitest of
# readers / fgdc / module_entity

# History:
#   Stan Smith 2017-09-06 original script

require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcEntity < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('entityAttribute.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::EntityAttribute

   def test_entity_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)

      xIn = @@xDoc.xpath('./metadata/eainfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDictionary = @@NameSpace.unpack(xIn, hResponse)

      refute_empty hDictionary
      assert_equal 4, hDictionary[:entities].length

      hEntity0 = hDictionary[:entities][0]
      refute_empty hEntity0
      refute_nil hEntity0[:entityId]
      assert_nil hEntity0[:entityName]
      assert_equal 'entity 1 label', hEntity0[:entityCode]
      assert_empty hEntity0[:entityAlias]
      assert_equal 'entity 1 definition', hEntity0[:entityDefinition]
      assert_equal 1, hEntity0[:entityReferences].length
      assert_equal 'entity 1 definition source', hEntity0[:entityReferences][0][:title]
      assert_empty hEntity0[:primaryKey]
      assert_empty hEntity0[:indexes]
      assert_equal 5, hEntity0[:attributes].length
      assert_empty hEntity0[:foreignKeys]
      assert_nil hEntity0[:fieldSeparatorCharacter]
      assert_nil hEntity0[:numberOfHeaderLines]
      assert_nil hEntity0[:quoteCharacter]

      hEntity2 = hDictionary[:entities][2]
      refute_empty hEntity2
      refute_nil hEntity2[:entityId]
      assert_equal 'Entity Overview', hEntity2[:entityName]
      assert_equal 'overview', hEntity2[:entityCode]
      assert_empty hEntity2[:entityAlias]
      assert_equal 'entity and attribute overview 1', hEntity2[:entityDefinition]
      assert_equal 2, hEntity2[:entityReferences].length
      assert_equal 'entity and attribute 1 detail citation 1', hEntity2[:entityReferences][0][:title]
      assert_equal 'entity and attribute 1 detail citation 2', hEntity2[:entityReferences][1][:title]
      assert_empty hEntity2[:primaryKey]
      assert_empty hEntity2[:indexes]
      assert_empty hEntity2[:attributes]
      assert_empty hEntity2[:foreignKeys]
      assert_nil hEntity2[:fieldSeparatorCharacter]
      assert_nil hEntity2[:numberOfHeaderLines]
      assert_nil hEntity2[:quoteCharacter]

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: entity type definition source is missing'

   end

end
