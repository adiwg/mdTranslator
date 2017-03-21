# mdJson 2.0 writer tests - transfer option

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterTransferOption < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('transferOption.json')

   def test_schema_transferOption

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'transferOption.json')
      assert_empty errors

   end

   def test_complete_transferOption

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption']

      assert_equal expect, got

   end

end
