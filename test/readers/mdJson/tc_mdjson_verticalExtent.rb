# MdTranslator - minitest of
# reader / mdJson / module_verticalExtent

# History:
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_verticalExtent'

class TestReaderMdJsonVerticalExtent < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::VerticalExtent
   aIn = TestReaderMdJsonParent.getJson('verticalExtent.json')
   @@hIn = aIn['verticalExtent'][0]

   def test_vertical_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'verticalExtent.json')
      assert_empty errors

   end

   def test_complete_vertical_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'description', metadata[:description]
      assert_equal 9.9, metadata[:minValue]
      assert_equal 9.9, metadata[:maxValue]
      refute_empty metadata[:crsId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_vertical_empty_minValue

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['minValue'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson vertical extent minimum value is missing'

   end

   def test_vertical_missing_minValue

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('minValue')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson vertical extent minimum value is missing'

   end

   def test_vertical_empty_maxValue

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['maxValue'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson vertical extent maximum value is missing'

   end

   def test_vertical_missing_maxValue

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('maxValue')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson vertical extent maximum value is missing'

   end

   def test_vertical_empty_crs

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['crsId'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson vertical extent CRS identifier is missing'

   end

   def test_vertical_missing_crs

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('crsId')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson vertical extent CRS identifier is missing'

   end

   def test_vertical_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['description'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:description]
      assert_equal 9.9, metadata[:minValue]
      assert_equal 9.9, metadata[:maxValue]
      refute_empty metadata[:crsId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_vertical_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('description')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:description]
      assert_equal 9.9, metadata[:minValue]
      assert_equal 9.9, metadata[:maxValue]
      refute_empty metadata[:crsId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_vertical_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson vertical extent object is empty'

   end

end
