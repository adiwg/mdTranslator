# MdTranslator - minitest of
# reader / mdJson / module_georectifiedRepresentation

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_georectifiedRepresentation'

class TestReaderMdJsonGeorectifiedRepresentation < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeorectifiedRepresentation

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.georectified
   TDClass.add_dimension(mdHash[:gridRepresentation])

   @@mdHash = mdHash

   def test_geoRecRep_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'georectifiedRepresentation.json')
      assert_empty errors

   end

   def test_complete_geoRecRep_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:gridRepresentation]
      refute metadata[:checkPointAvailable]
      assert_equal 'check point description', metadata[:checkPointDescription]
      assert_equal 2, metadata[:cornerPoints].length
      assert_equal 2, metadata[:centerPoint].length
      assert_equal 'upperRight', metadata[:pointInPixel]
      assert_equal 'transformation dimension description', metadata[:transformationDimensionDescription]
      assert_equal 'transformation dimension mapping', metadata[:transformationDimensionMapping]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geoRecRep_empty_grid

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['gridRepresentation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georectified representation grid representation is missing: CONTEXT is testing'

   end

   def test_geoRecRep_missing_grid

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('gridRepresentation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georectified representation grid representation is missing: CONTEXT is testing'

   end

   def test_geoRecRep_empty_cornerPoint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['cornerPoints'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georectified representation must have either 2 or 4 corner points: CONTEXT is testing'

   end

   def test_geoRecRep_missing_cornerPoint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('cornerPoints')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georectified representation must have either 2 or 4 corner points: CONTEXT is testing'

   end

   def test_geoRecRep_invalid_centerPoint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['centerPoint'] = [0.0]
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georectified representation center point must be single 2D coordinate: CONTEXT is testing'

   end

   def test_geoRecRep_invalid_cornerPoint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['cornerPoints'] = [[0.0, 0.0]]
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georectified representation must have either 2 or 4 corner points: CONTEXT is testing'

   end

   def test_geoRecRep_empty_pointInPxiel

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['pointInPixel'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georectified representation point-in-pixel is missing: CONTEXT is testing'

   end

   def test_geoRecRep_missing_pointInPxiel

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('pointInPixel')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georectified representation point-in-pixel is missing: CONTEXT is testing'

   end

   def test_geoRecRep_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['checkPointDescription'] = ''
      hIn['transformationDimensionDescription'] = ''
      hIn['transformationDimensionMapping'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:gridRepresentation]
      refute metadata[:checkPointAvailable]
      assert_nil metadata[:checkPointDescription]
      assert_equal 2, metadata[:cornerPoints].length
      refute_empty metadata[:centerPoint]
      assert_equal 'upperRight', metadata[:pointInPixel]
      assert_nil metadata[:transformationDimensionDescription]
      assert_nil metadata[:transformationDimensionMapping]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geoRecRep_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('checkPointDescription')
      hIn.delete('transformationDimensionDescription')
      hIn.delete('transformationDimensionMapping')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:gridRepresentation]
      refute metadata[:checkPointAvailable]
      assert_nil metadata[:checkPointDescription]
      assert_equal 2, metadata[:cornerPoints].length
      refute_empty metadata[:centerPoint]
      assert_equal 'upperRight', metadata[:pointInPixel]
      assert_nil metadata[:transformationDimensionDescription]
      assert_nil metadata[:transformationDimensionMapping]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_geoRecRep_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: georectified representation object is empty: CONTEXT is testing'

   end

end
