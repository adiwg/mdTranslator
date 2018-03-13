# MdTranslator - minitest of
# reader / mdJson / module_coordinateResolution

# History:
#   Stan Smith 2017-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_coordinateResolution'

class TestReaderMdJsonCoordinateResolution < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::CoordinateResolution
   aIn = TestReaderMdJsonParent.getJson('coordinateResolution.json')
   @@hIn = aIn['spatialResolution'][0]['coordinateResolution']

   # TODO reinstate after schema update
   # def test_coordinateResolution_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'measure.json')
   #     assert_empty errors
   #
   # end

   def test_complete_coordinateResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 9.9, metadata[:abscissaResolutionX]
      assert_equal 99.9, metadata[:ordinateResolutionY]
      assert_equal 'coordinate resolution UOM', metadata[:unitOfMeasure]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_coordinateResolution_empty_abscissa

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['abscissaResolutionX'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: coordinate spatial resolution abscissa resolution is missing'

   end

   def test_complete_coordinateResolution_missing_abscissa

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('abscissaResolutionX')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: coordinate spatial resolution abscissa resolution is missing'

   end

   def test_complete_coordinateResolution_empty_ordinate

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['ordinateResolutionY'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: coordinate spatial resolution ordinate resolution is missing'

   end

   def test_complete_coordinateResolution_missing_ordinate

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('ordinateResolutionY')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: coordinate spatial resolution ordinate resolution is missing'

   end

   def test_complete_coordinateResolution_empty_unitOfMeasure

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['unitOfMeasure'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: coordinate spatial resolution units are missing'

   end

   def test_complete_coordinateResolution_missing_unitOfMeasure

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('unitOfMeasure')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: coordinate spatial resolution units are missing'

   end

   def test_empty_coordinateResolution_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: spatial resolution coordinate resolution object is empty'

   end

end
