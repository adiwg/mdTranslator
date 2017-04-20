# mdJson 2.0 writer tests - funding

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterFunding < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('funding.json')

   def test_schema_funding

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['funding'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'funding.json')
      assert_empty errors

   end

   def test_complete_funding

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['funding']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['funding']

      assert_equal expect, got

   end

end
