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

      TestReaderFGDCParent.set_xDoc(@@xDoc)

      xIn = @@xDoc.xpath('./metadata/eainfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDictionary = @@NameSpace.unpack(xIn, hResponse)

      refute_empty hDictionary
      assert_equal 4, hDictionary[:entities].length

      hEntity0 = hDictionary[:entities][0]
      assert_equal 5, hEntity0[:attributes].length

      hAttribute0 = hEntity0[:attributes][0]
      refute_empty hAttribute0
      assert_equal 'attribute 1 label', hAttribute0[:attributeName]
      assert_equal 'attribute 1 label', hAttribute0[:attributeCode]
      assert_empty hAttribute0[:attributeAlias]
      assert_equal 'attribute 1 definition', hAttribute0[:attributeDefinition]
      refute_empty hAttribute0[:attributeReference]
      assert_equal 'attribute 1 definition source', hAttribute0[:attributeReference][:title]
      assert_nil hAttribute0[:dataType]
      refute hAttribute0[:allowNull]
      refute hAttribute0[:allowMany]
      assert_nil hAttribute0[:unitOfMeasure]
      assert_nil hAttribute0[:measureResolution]
      refute hAttribute0[:isCaseSensitive]
      assert_nil hAttribute0[:fieldWidth]
      assert_nil hAttribute0[:missingValue]
      assert_equal hDictionary[:domains][0][:domainId], hAttribute0[:domainId]
      assert_nil hAttribute0[:minValue]
      assert_nil hAttribute0[:maxValue]
      assert_empty hAttribute0[:rangeOfValues]
      assert_equal 2, hAttribute0[:timePeriodOfValues].length
      assert_equal 'attribute date range', hAttribute0[:timePeriodOfValues][0][:description]
      assert_kind_of DateTime, hAttribute0[:timePeriodOfValues][0][:startDateTime][:dateTime]
      assert_equal 'YMDhmsZ', hAttribute0[:timePeriodOfValues][0][:startDateTime][:dateResolution]
      assert_kind_of DateTime, hAttribute0[:timePeriodOfValues][0][:endDateTime][:dateTime]
      assert_equal 'YMDhmsZ', hAttribute0[:timePeriodOfValues][0][:endDateTime][:dateResolution]

      hAttribute1 = hEntity0[:attributes][1]
      refute_empty hAttribute1
      assert_equal 'attribute 2 label', hAttribute1[:attributeName]
      assert_equal 'attribute 2 label', hAttribute1[:attributeCode]
      assert_equal 'attribute 2 definition', hAttribute1[:attributeDefinition]
      refute_empty hAttribute1[:attributeReference]
      assert_equal 'attribute 2 definition source', hAttribute1[:attributeReference][:title]
      assert_nil hAttribute1[:dataType]
      refute hAttribute1[:allowNull]
      refute hAttribute1[:allowMany]
      assert_equal 'units', hAttribute1[:unitOfMeasure]
      assert_equal 2.0, hAttribute1[:measureResolution]
      refute hAttribute1[:isCaseSensitive]
      assert_nil hAttribute1[:fieldWidth]
      assert_nil hAttribute1[:missingValue]
      assert_nil hAttribute1[:domainId]
      assert_equal 0.0, hAttribute1[:minValue]
      assert_equal 40.0, hAttribute1[:maxValue]
      assert_equal 2, hAttribute1[:rangeOfValues].length
      assert_equal 0.0, hAttribute1[:rangeOfValues][0][:minRangeValue]
      assert_equal 9.0, hAttribute1[:rangeOfValues][0][:maxRangeValue]
      assert_equal 20.0, hAttribute1[:rangeOfValues][1][:minRangeValue]
      assert_equal 40.0, hAttribute1[:rangeOfValues][1][:maxRangeValue]
      assert_empty hAttribute1[:timePeriodOfValues]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
