# mdJson 2.0 writer tests - entity

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterEntity < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('entity.json')

   def test_schema_entity

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['dataDictionary'][0]['entity'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'entity.json')
      assert_empty errors

   end

   def test_complete_entity

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['dataDictionary'][0]['entity']
      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary'][0]['entity']

      assert_equal expect, got

   end

end
