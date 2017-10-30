# MdTranslator - minitest of
# readers / fgdc / module_entity

# History:
#   Stan Smith 2017-09-06 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcEntity < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('entityAttribute.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::EntityAttribute

   def test_entity_complete

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
      assert_empty hEntity0[:primaryKey]
      assert_empty hEntity0[:indexes]
      assert_equal 5, hEntity0[:attributes].length
      assert_empty hEntity0[:foreignKeys]

      hEntity2 = hDictionary[:entities][2]
      refute_empty hEntity2
      refute_nil hEntity2[:entityId]
      assert_nil hEntity2[:entityName]
      assert_equal 'overview', hEntity2[:entityCode]
      assert_empty hEntity2[:entityAlias]
      assert_equal 'entity and attribute overview 1', hEntity2[:entityDefinition]
      assert_empty hEntity2[:primaryKey]
      assert_empty hEntity2[:indexes]
      assert_empty hEntity2[:attributes]
      assert_empty hEntity2[:foreignKeys]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
