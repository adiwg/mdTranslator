# mdJson 2.0 writer tests - dimension

# History:
#   Stan Smith 2017-03-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterDimension < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('dimension.json')

   def test_schema_dimension

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'gridRepresentation.json', :fragment=>'dimension')
      assert_empty errors

   end

   def test_complete_dimension

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension']

      assert_equal expect, got

   end

end
