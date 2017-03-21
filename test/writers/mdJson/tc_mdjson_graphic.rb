# mdJson 2.0 writer tests - graphic overview

# History:
#   Stan Smith 2017-03-17 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterGraphicOverview < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('graphic.json')

   def test_schema_graphic

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['graphicOverview'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'graphic.json')
      assert_empty errors

   end

   def test_complete_graphic

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['graphicOverview']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['graphicOverview']

      assert_equal expect, got

   end

end
