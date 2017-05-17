# mdJson 2.0 writer tests - spatial representation

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonSpatialRepresentation < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('spatialRepresentation.json')

   def test_schema_spatialRepresentation

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['spatialRepresentation']

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test grid representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', hTest[0])
      assert_empty errors

      # test vector representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', hTest[1])
      assert_empty errors

      # test georectified representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', hTest[2])
      assert_empty errors

      # test georeferenceable representation
      errors = JSON::Validator.fully_validate('spatialRepresentation.json', hTest[3])
      assert_empty errors

   end

   def test_complete_spatialRepresentation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['spatialRepresentation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialRepresentation']

      assert_equal expect, got

   end

end
