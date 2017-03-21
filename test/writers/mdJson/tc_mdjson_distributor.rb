# mdJson 2.0 writer tests - distributor

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterDistributor < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('distributor.json')

   def test_schema_distributor

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceDistribution'][0]['distributor'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'distributor.json')
      assert_empty errors

   end

   def test_complete_distributor

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceDistribution'][0]['distributor']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceDistribution'][0]['distributor']

      assert_equal expect, got

   end

end
