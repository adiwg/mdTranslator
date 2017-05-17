# mdJson 2.0 writer tests - distribution

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonDistributionInfo < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('distribution.json')

   def test_schema_distribution

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceDistribution'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'distribution.json')
      assert_empty errors

   end

   def test_complete_distribution

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceDistribution']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceDistribution']

      assert_equal expect, got

   end

end
