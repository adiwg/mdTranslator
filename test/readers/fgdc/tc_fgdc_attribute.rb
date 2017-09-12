# MdTranslator - minitest of
# readers / fgdc / module_attribute

# History:
#   Stan Smith 2017-09-06 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcAttribute < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('entityAttribute.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::EntityAttribute

   def test_attribute_complete

      xIn = @@xDoc.xpath('./metadata/eainfo')
      hDictionary = @@NameSpace.unpack(xIn, @@hResponseObj)

      refute_empty hDictionary
      assert_equal 4, hDictionary[:entities].length

      hEntity0 = hDictionary[:entities][0]
      assert_equal 4, hEntity0[:attributes].length

      hAttribute0 = hEntity0[:attributes][0]
      refute_empty hAttribute0
      assert_equal 'attribute 1 label', hAttribute0[:attributeName]
      assert_equal 'attribute 1 label', hAttribute0[:attributeCode]
      assert_empty hAttribute0[:attributeAlias]
      assert_equal 'attribute 1 definition', hAttribute0[:attributeDefinition]
      assert_nil hAttribute0[:dataType]
      refute hAttribute0[:allowNull]
      refute hAttribute0[:allowMany]
      assert_nil hAttribute0[:unitOfMeasure]
      assert_equal hDictionary[:domains][0][:domainId], hAttribute0[:domainId]
      assert_nil hAttribute0[:minValue]
      assert_nil hAttribute0[:maxValue]

      hAttribute1 = hEntity0[:attributes][1]
      refute_empty hAttribute1
      assert_equal 'attribute 2 label', hAttribute1[:attributeName]
      assert_equal 'attribute 2 label', hAttribute1[:attributeCode]
      assert_equal 'attribute 2 definition', hAttribute1[:attributeDefinition]
      assert_equal 'grade', hAttribute1[:unitOfMeasure]
      assert_nil hAttribute1[:domainId]
      assert_equal 'A', hAttribute1[:minValue]
      assert_equal 'F', hAttribute1[:maxValue]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
