# mdJson 2.0 writer tests - releasability

# History:
#   Stan Smith 2017-03-17 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterReleasability < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('releasability.json')

   def test_schema_releasability

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['constraint'][0]['releasability']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'releasability.json')
      assert_empty errors

   end

   def test_complete_releasability

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['constraint']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['constraint']

      assert_equal expect, got

   end

end
