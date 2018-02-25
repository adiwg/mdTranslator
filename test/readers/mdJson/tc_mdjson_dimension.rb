# MdTranslator - minitest of
# reader / mdJson / module_dimension

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-18 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_dimension'

class TestReaderMdJsonDimension < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Dimension
   aIn = TestReaderMdJsonParent.getJson('dimension.json')
   @@hIn = aIn['dimension'][0]

   def test_dimension_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'gridRepresentation.json', :fragment => 'dimension')
      assert_empty errors

   end

   def test_complete_dimension_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'dimensionType', metadata[:dimensionType]
      assert_equal 9, metadata[:dimensionSize]
      refute_empty metadata[:resolution]
      assert_equal 'dimensionTitle', metadata[:dimensionTitle]
      assert_equal 'dimensionDescription', metadata[:dimensionDescription]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_dimension_empty_dimensionType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['dimensionType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson spatial representation dimension type is missing'

   end

   def test_dimension_missing_dimensionType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('dimensionType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson spatial representation dimension type is missing'

   end

   def test_dimension_empty_dimensionSize

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['dimensionSize'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson spatial representation dimension size is missing'

   end

   def test_dimension_missing_dimensionSize

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('dimensionSize')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson spatial representation dimension size is missing'

   end

   def test_dimension_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['resolution'] = {}
      hIn['dimensionTitle'] = ''
      hIn['dimensionDescription'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'dimensionType', metadata[:dimensionType]
      assert_equal 9, metadata[:dimensionSize]
      assert_empty metadata[:resolution]
      assert_nil metadata[:dimensionTitle]
      assert_nil metadata[:dimensionDescription]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_dimension_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('resolution')
      hIn.delete('dimensionTitle')
      hIn.delete('dimensionDescription')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'dimensionType', metadata[:dimensionType]
      assert_equal 9, metadata[:dimensionSize]
      assert_empty metadata[:resolution]
      assert_nil metadata[:dimensionTitle]
      assert_nil metadata[:dimensionDescription]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_additionalDocumentation_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson spatial representation dimension object is empty'

   end

end
