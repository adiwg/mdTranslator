# mdJson 2.0 writer tests - medium

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMedium < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('medium.json')

   def test_schema_medium

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption'][0]['offlineOption'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'medium.json')
      assert_empty errors

   end

   def test_complete_medium

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption'][0]['offlineOption']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption'][0]['offlineOption']

      assert_equal expect, got

   end

end
