# MdTranslator - minitest of
# reader / mdJson / module_spatialResolution

# History:
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialResolution'

class TestReaderMdJsonSpatialResolution < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialResolution
   aIn = TestReaderMdJsonParent.getJson('spatialResolution.json')
   @@hIn = aIn['spatialResolution']

   # TODO reinstate after schema update
   # def test_spatialResolution_schema
   #
   #     ADIWG::MdjsonSchemas::Utils.load_schemas(false)
   #
   #     # test scaleFactor
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@hIn[0])
   #     assert_empty errors
   #
   #     # test measure
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@hIn[1])
   #     assert_empty errors
   #
   #     # test level of detail
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@hIn[2])
   #     assert_empty errors
   #
   #     # test coordinate resolution
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@hIn[3])
   #     assert_empty errors
   #
   #     # test bearing distance resolution
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@hIn[4])
   #     assert_empty errors
   #
   #     # test geographic resolution
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@hIn[5])
   #     assert_empty errors
   #
   # end

   def test_spatialResolution_scaleFactor

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 99999, metadata[:scaleFactor]
      assert_empty metadata[:measure]
      assert_nil metadata[:levelOfDetail]
      assert_empty metadata[:coordinateResolution]
      assert_empty metadata[:bearingDistanceResolution]
      assert_empty metadata[:geographicResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialResolution_measure

      hIn = Marshal::load(Marshal.dump(@@hIn[1]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:scaleFactor]
      refute_empty metadata[:measure]
      assert_nil metadata[:levelOfDetail]
      assert_empty metadata[:coordinateResolution]
      assert_empty metadata[:bearingDistanceResolution]
      assert_empty metadata[:geographicResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialResolution_levelOfDetail

      hIn = Marshal::load(Marshal.dump(@@hIn[2]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:scaleFactor]
      assert_empty metadata[:measure]
      assert_equal 'levelOfDetail', metadata[:levelOfDetail]
      assert_empty metadata[:coordinateResolution]
      assert_empty metadata[:bearingDistanceResolution]
      assert_empty metadata[:geographicResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialResolution_coordinateResolution

      hIn = Marshal::load(Marshal.dump(@@hIn[3]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:scaleFactor]
      assert_empty metadata[:measure]
      assert_nil metadata[:levelOfDetail]
      refute_empty metadata[:coordinateResolution]
      assert_empty metadata[:bearingDistanceResolution]
      assert_empty metadata[:geographicResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialResolution_bearingDistanceResolution

      hIn = Marshal::load(Marshal.dump(@@hIn[4]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:scaleFactor]
      assert_empty metadata[:measure]
      assert_nil metadata[:levelOfDetail]
      assert_empty metadata[:coordinateResolution]
      refute_empty metadata[:bearingDistanceResolution]
      assert_empty metadata[:geographicResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialResolution_geographicResolution

      hIn = Marshal::load(Marshal.dump(@@hIn[5]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:scaleFactor]
      assert_empty metadata[:measure]
      assert_nil metadata[:levelOfDetail]
      assert_empty metadata[:coordinateResolution]
      assert_empty metadata[:bearingDistanceResolution]
      refute_empty metadata[:geographicResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialResolution_empty_required

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hIn['scaleFactor'] = ''
      hIn['measure'] = {}
      hIn['levelOfDetail'] = ''
      hIn['coordinateResolution'] = {}
      hIn['bearingDistanceResolution'] = {}
      hIn['geographicResolution'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: spatial resolution did not have an object of supported type'

   end

   def test_spatialResolution_missing_required

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hIn['nonElement'] = ''
      hIn.delete('scaleFactor')
      hIn.delete('measure')
      hIn.delete('levelOfDetail')
      hIn.delete('coordinateResolution')
      hIn.delete('bearingDistanceResolution')
      hIn.delete('geographicResolution')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: spatial resolution did not have an object of supported type'

   end

   def test_empty_spatialResolution_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: spatial resolution object is empty'

   end

end
