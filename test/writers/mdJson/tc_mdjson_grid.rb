# mdJson 2.0 writer tests - grid representation

# History:
#   Stan Smith 2017-03-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterGrid < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('grid.json')

   def test_schema_grid

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'gridRepresentation.json')
      assert_empty errors

   end

   def test_complete_grid

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
