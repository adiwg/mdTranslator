# mdJson 2.0 writer tests - allocation

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonAllocation < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('allocation.json')

   def test_schema_allocation

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['funding'][0]['allocation'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'funding.json', fragment: 'allocation')
      assert_empty errors

   end

   def test_complete_allocation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['funding'][0]['allocation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['funding'][0]['allocation']

      assert_equal expect, got

   end

end
