# mdJson 2.0 writer tests - spatial resolution

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonSpatialResolution < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('spatialResolution.json')

   # TODO reinstate after schema update
   # def test_schema_spatialResolution
   #
   #    hIn = JSON.parse(@@jsonIn)
   #    hTest = hIn['metadata']['resourceInfo']['spatialResolution']
   #
   #    ADIWG::MdjsonSchemas::Utils.load_schemas(false)
   #
   #    # test grid scaleFactor
   #    errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[0])
   #    assert_empty errors
   #
   #    # test vector measure
   #    errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[1])
   #    assert_empty errors
   #
   #    # test coordinate resolution
   #    errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[2])
   #    assert_empty errors
   #
   #    # test bearing distance resolution
   #    errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[3])
   #    assert_empty errors
   #
   #    # test geographic resolution
   #    errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[4])
   #    assert_empty errors
   #
   #    # test georectified levelOfDetail
   #    errors = JSON::Validator.fully_validate('spatialResolution.json', hTest[5])
   #    assert_empty errors
   #
   # end

   def test_complete_spatialResolution

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['spatialResolution']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialResolution']

      assert_equal expect, got

   end

end
