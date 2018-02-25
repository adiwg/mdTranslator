# MdTranslator - minitest of
# reader / mdJson / module_georectifiedRepresentation

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_georectifiedRepresentation'

class TestReaderMdJsonGeorectifiedRepresentation < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeorectifiedRepresentation
   aIn = TestReaderMdJsonParent.getJson('georectified.json')
   @@hIn = aIn['georectifiedRepresentation'][0]

   def test_geoRecRep_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'georectifiedRepresentation.json')
      assert_empty errors

   end

   def test_complete_geoRecRep_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:gridRepresentation]
      assert metadata[:checkPointAvailable]
      assert_equal 'checkPointDescription', metadata[:checkPointDescription]
      assert_equal 4, metadata[:cornerPoints].length
      assert_equal 2, metadata[:centerPoint].length
      assert_equal 'pointInPixel', metadata[:pointInPixel]
      assert_equal 'transformationDimensionDescription', metadata[:transformationDimensionDescription]
      assert_equal 'transformationDimensionMapping', metadata[:transformationDimensionMapping]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geoRecRep_empty_grid

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['gridRepresentation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation grid representation is missing'

   end

   def test_geoRecRep_missing_grid

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('gridRepresentation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation grid representation is missing'

   end

   def test_geoRecRep_empty_cornerPoint

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['cornerPoints'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation must have either 2 or 4 corner points'

   end

   def test_geoRecRep_missing_cornerPoint

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('cornerPoints')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation must have either 2 or 4 corner points'

   end

   def test_geoRecRep_invalid_centerPoint

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['centerPoint'] = [0.0]
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation center point must be single 2D coordinate'

   end

   def test_geoRecRep_missing_centerPoint

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('centerPoint')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation center point is missing'

   end

   def test_geoRecRep_invalid_cornerPoint

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['cornerPoints'] = [[0.0, 0.0]]
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation must have either 2 or 4 corner points'

   end

   def test_geoRecRep_empty_pointInPxiel

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['pointInPixel'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation point-in-pixel is missing'

   end

   def test_geoRecRep_missing_pointInPxiel

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('pointInPixel')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson georectified spatial representation point-in-pixel is missing'

   end

   def test_geoRecRep_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['checkPointDescription'] = ''
      hIn['transformationDimensionDescription'] = ''
      hIn['transformationDimensionMapping'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:gridRepresentation]
      assert metadata[:checkPointAvailable]
      assert_nil metadata[:checkPointDescription]
      assert_equal 4, metadata[:cornerPoints].length
      refute_empty metadata[:centerPoint]
      assert_equal 'pointInPixel', metadata[:pointInPixel]
      assert_nil metadata[:transformationDimensionDescription]
      assert_nil metadata[:transformationDimensionMapping]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geoRecRep_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('checkPointDescription')
      hIn.delete('transformationDimensionDescription')
      hIn.delete('transformationDimensionMapping')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:gridRepresentation]
      assert metadata[:checkPointAvailable]
      assert_nil metadata[:checkPointDescription]
      assert_equal 4, metadata[:cornerPoints].length
      refute_empty metadata[:centerPoint]
      assert_equal 'pointInPixel', metadata[:pointInPixel]
      assert_nil metadata[:transformationDimensionDescription]
      assert_nil metadata[:transformationDimensionMapping]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_geoRecRep_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson georectified spatial representation object is empty'

   end

end
