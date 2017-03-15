# mdJson 2.0 writer tests - spatial reference system

# History:
#   Stan Smith 2017-03-14 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterSpatialReference < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('spatialReference.json')

   def test_schema_spatialReference

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['spatialReferenceSystem'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'spatialReference.json')
      assert_empty errors

   end

   def test_complete_spatialReference

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['spatialReferenceSystem']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialReferenceSystem']

      assert_equal expect, got

   end

end
