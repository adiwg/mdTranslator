# mdJson 2.0 writer tests - spatial resolution

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterSpatialResolution < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('spatialResolution.json')

   def test_schema_spatialResolution

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['spatialResolution']

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test grid scaleFactor
      errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[0])
      assert_empty errors

      # test vector measure
      errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[1])
      assert_empty errors

      # test georectified levelOfDetail
      errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[2])
      assert_empty errors

   end

   def test_complete_spatialResolution

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['spatialResolution']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialResolution']

      assert_equal expect, got

   end

end
