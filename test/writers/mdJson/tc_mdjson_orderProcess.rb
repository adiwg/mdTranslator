# mdJson 2.0 writer tests - order process

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterOrderProcess < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('orderProcess.json')

   def test_schema_orderProcess

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceDistribution'][0]['distributor'][0]['orderProcess'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'orderProcess.json')
      assert_empty errors

   end

   def test_complete_orderProcess

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceDistribution'][0]['distributor'][0]['orderProcess']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceDistribution'][0]['distributor'][0]['orderProcess']

      assert_equal expect, got

   end

end
