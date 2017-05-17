# mdJson 2.0 writer tests - measure

# History:
#   Stan Smith 2017-03-13 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonMeasure < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('measure.json')

   def test_schema_measure

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'measure.json')
      assert_empty errors

   end

   def test_complete_measure

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']

      assert_equal expect, got

   end

end
