# MdTranslator - minitest of
# reader / mdJson / module_series

# History:
#  Stan Smith 2017-11-01 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_valueRange'

class TestReaderMdJsonValueRange < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ValueRange
   aIn = TestReaderMdJsonParent.getJson('valueRange.json')
   @@hIn = aIn['valueRange'][0]

   def test_valueRange_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'entityAttribute.json', :fragment => 'valueRange')
      assert_empty errors

   end

   def test_complete_valueRange_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal '0', metadata[:minRangeValue]
      assert_equal '9', metadata[:maxRangeValue]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_valueRange_empty_minRange

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['minRangeValue'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_valueRange_missing_minRange

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('minRangeValue')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_valueRange_empty_maxRange

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['maxRangeValue'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_valueRange_missing_maxRange

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('maxRangeValue')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_valueRange_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
