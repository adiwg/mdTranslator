# mdJson 2.0 writer tests - entity foreign key

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonEntityForeignKey < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('entityForeignKey.json')

   def test_schema_foreignKey

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['dataDictionary'][0]['entity'][0]['foreignKey'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'entity.json', :fragment=>'foreignKey')
      assert_empty errors

   end

   def test_complete_foreignKey

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['dataDictionary'][0]['entity'][0]['foreignKey']
      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary'][0]['entity'][0]['foreignKey']

      assert_equal expect, got

   end

end
