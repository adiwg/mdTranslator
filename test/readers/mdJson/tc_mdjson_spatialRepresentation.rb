# MdTranslator - minitest of
# reader / mdJson / module_spatialRepresentation

# History:
#  Stan Smith 2018-06-25 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialRepresentation'

class TestReaderMdJsonSpatialRepresentation < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialRepresentation

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_spatialRepresentation_full

   @@mdHash = mdHash

   def test_spatialRepresentation_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test grid representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', @@mdHash[0])
      assert_empty errors

      # test vector representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', @@mdHash[1])
      assert_empty errors

      # test georectified representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', @@mdHash[2])
      assert_empty errors

      # test grid georeferenceable
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', @@mdHash[3])
      assert_empty errors

   end

   def test_spatialRepresentation_grid

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:gridRepresentation]
      assert_empty metadata[:vectorRepresentation]
      assert_empty metadata[:georectifiedRepresentation]
      assert_empty metadata[:georeferenceableRepresentation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialRepresentation_vector

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[1]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:gridRepresentation]
      refute_empty metadata[:vectorRepresentation]
      assert_empty metadata[:georectifiedRepresentation]
      assert_empty metadata[:georeferenceableRepresentation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialRepresentation_georectified

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[2]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:gridRepresentation]
      assert_empty metadata[:vectorRepresentation]
      refute_empty metadata[:georectifiedRepresentation]
      assert_empty metadata[:georeferenceableRepresentation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialRepresentation_georeferenceable

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[3]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:gridRepresentation]
      assert_empty metadata[:vectorRepresentation]
      assert_empty metadata[:georectifiedRepresentation]
      refute_empty metadata[:georeferenceableRepresentation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialRepresentation_empty_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['gridRepresentation'] = {}
      hIn['vectorRepresentation'] = {}
      hIn['georectifiedRepresentation'] = {}
      hIn['georeferenceableRepresentation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: spatial representation did not have an object of supported type: CONTEXT is testing'

   end

   def test_spatialRepresentation_missing_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('gridRepresentation')
      hIn.delete('vectorRepresentation')
      hIn.delete('georectifiedRepresentation')
      hIn.delete('georeferenceableRepresentation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: spatial representation did not have an object of supported type: CONTEXT is testing'

   end

   def test_empty_spatialRepresentation_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: spatial representation object is empty: CONTEXT is testing'

   end

end
