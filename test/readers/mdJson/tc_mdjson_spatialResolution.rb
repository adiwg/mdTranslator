# MdTranslator - minitest of
# reader / mdJson / module_spatialResolution

# History:
#  Stan Smith 2018-06-25 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialResolution'

class TestReaderMdJsonSpatialResolution < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialResolution

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_spatialResolution_full

   @@mdHash = mdHash

   # TODO reinstate after schema update
   def test_spatialResolution_schema

       ADIWG::MdjsonSchemas::Utils.load_schemas(false)

       # test scaleFactor
       errors = JSON::Validator.fully_validate('spatialResolution.json', @@mdHash[0])
       assert_empty errors

       # test measure
       errors = JSON::Validator.fully_validate('spatialResolution.json', @@mdHash[1])
       assert_empty errors

       # test level of detail
       errors = JSON::Validator.fully_validate('spatialResolution.json', @@mdHash[2])
       assert_empty errors

   #     # test coordinate resolution
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@mdHash[3])
   #     assert_empty errors
   #
   #     # test bearing distance resolution
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@mdHash[4])
   #     assert_empty errors
   #
   #     # test geographic resolution
   #     errors = JSON::Validator.fully_validate('spatialResolution.json', @@mdHash[5])
   #     assert_empty errors

   end

   def test_spatialResolution_scaleFactor

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 9999, metadata[:scaleFactor]
      assert_empty metadata[:measure]
      assert_nil metadata[:levelOfDetail]
      assert_empty metadata[:coordinateResolution]
      assert_empty metadata[:bearingDistanceResolution]
      assert_empty metadata[:geographicResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialResolution_measure

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[1]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[2]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:scaleFactor]
      assert_empty metadata[:measure]
      assert_equal 'level of detail', metadata[:levelOfDetail]
      assert_empty metadata[:coordinateResolution]
      assert_empty metadata[:bearingDistanceResolution]
      assert_empty metadata[:geographicResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialResolution_coordinateResolution

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[3]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[4]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[5]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['scaleFactor'] = ''
      hIn['measure'] = {}
      hIn['levelOfDetail'] = ''
      hIn['coordinateResolution'] = {}
      hIn['bearingDistanceResolution'] = {}
      hIn['geographicResolution'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: spatial resolution did not have an object of supported type: CONTEXT is testing'

   end

   def test_spatialResolution_missing_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('scaleFactor')
      hIn.delete('measure')
      hIn.delete('levelOfDetail')
      hIn.delete('coordinateResolution')
      hIn.delete('bearingDistanceResolution')
      hIn.delete('geographicResolution')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: spatial resolution did not have an object of supported type: CONTEXT is testing'

   end

   def test_empty_spatialResolution_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: spatial resolution object is empty: CONTEXT is testing'

   end

end
