# MdTranslator - minitest of
# reader / mdJson / module_spatialRepresentation

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialRepresentation'

class TestReaderMdJsonSpatialRepresentation < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialRepresentation
   aIn = TestReaderMdJsonParent.getJson('spatialRepresentation.json')
   @@hIn = aIn['spatialRepresentation']

   def test_spatialRepresentation_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test grid representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', @@hIn[0])
      assert_empty errors

      # test vector representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', @@hIn[1])
      assert_empty errors

      # test georectified representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', @@hIn[2])
      assert_empty errors

      # test grid georeferenceable
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', @@hIn[3])
      assert_empty errors

   end

   def test_spatialRepresentation_grid

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:gridRepresentation]
      assert_empty metadata[:vectorRepresentation]
      assert_empty metadata[:georectifiedRepresentation]
      assert_empty metadata[:georeferenceableRepresentation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialRepresentation_vector

      hIn = Marshal::load(Marshal.dump(@@hIn[1]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:gridRepresentation]
      refute_empty metadata[:vectorRepresentation]
      assert_empty metadata[:georectifiedRepresentation]
      assert_empty metadata[:georeferenceableRepresentation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialRepresentation_georectified

      hIn = Marshal::load(Marshal.dump(@@hIn[2]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:gridRepresentation]
      assert_empty metadata[:vectorRepresentation]
      refute_empty metadata[:georectifiedRepresentation]
      assert_empty metadata[:georeferenceableRepresentation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialRepresentation_georeferenceable

      hIn = Marshal::load(Marshal.dump(@@hIn[3]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:gridRepresentation]
      assert_empty metadata[:vectorRepresentation]
      assert_empty metadata[:georectifiedRepresentation]
      refute_empty metadata[:georeferenceableRepresentation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_spatialRepresentation_empty_required

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hIn['gridRepresentation'] = {}
      hIn['vectorRepresentation'] = {}
      hIn['georectifiedRepresentation'] = {}
      hIn['georeferenceableRepresentation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson spatial representation did not have an object of supported type'

   end

   def test_spatialRepresentation_missing_required

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hIn['nonElement'] = ''
      hIn.delete('gridRepresentation')
      hIn.delete('vectorRepresentation')
      hIn.delete('georectifiedRepresentation')
      hIn.delete('georeferenceableRepresentation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson spatial representation did not have an object of supported type'

   end

   def test_empty_spatialRepresentation_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson spatial representation object is empty'

   end

end
