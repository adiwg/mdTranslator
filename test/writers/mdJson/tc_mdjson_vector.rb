# mdJson 2.0 writer tests - vector representation

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonVector < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('vector.json')

   def test_schema_vector

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['spatialRepresentation'][0]['vectorRepresentation']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'vectorRepresentation.json')
      assert_empty errors

   end

   def test_complete_vector

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
