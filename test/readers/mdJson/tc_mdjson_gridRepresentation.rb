# MdTranslator - minitest of
# reader / mdJson / module_gridRepresentation

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_gridRepresentation'

class TestReaderMdJsonGridRepresentation < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GridRepresentation
   aIn = TestReaderMdJsonParent.getJson('grid.json')
   @@hIn = aIn['gridRepresentation'][0]

   def test_gridRep_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'gridRepresentation.json')
      assert_empty errors

   end

   def test_complete_gridRep_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 9, metadata[:numberOfDimensions]
      assert_equal 2, metadata[:dimension].length
      assert_equal 'cellGeometry', metadata[:cellGeometry]
      assert metadata[:transformationParameterAvailable]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_gridRep_empty_numberOfDimensions

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['numberOfDimensions'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: grid representation number-of-dimensions is missing'

   end

   def test_gridRep_missing_numberOfDimensions

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('numberOfDimensions')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: grid representation number-of-dimensions is missing'

   end

   def test_gridRep_empty_dimensions

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['dimension'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: grid representation dimensions are missing'

   end

   def test_gridRep_missing_dimensions

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('dimension')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: grid representation dimensions are missing'

   end

   def test_gridRep_empty_cellGeometry

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['cellGeometry'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: grid representation cell geometry is missing'

   end

   def test_gridRep_missing_cellGeometry

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('cellGeometry')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: grid representation cell geometry is missing'

   end

   def test_empty_gridRep_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: grid representation object is empty'

   end

end
