# mdJson 2.0 writer tests - coverage description

# History:
#   Stan Smith 2017-03-16 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterCoverageDescription < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('coverage.json')

   def test_schema_coverage

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['coverageDescription'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'coverageDescription.json')
      assert_empty errors

   end

   def test_complete_coverage

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['coverageDescription'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['coverageDescription'][0]

      assert_equal expect, got

   end

end
