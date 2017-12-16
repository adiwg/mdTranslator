# mdJson 2.0 writer tests - source

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonSource < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('source.json')

   # TODO reinstate after schema update
   # def test_schema_source
   #
   #    hIn = JSON.parse(@@jsonIn)
   #    hTest = hIn['metadata']['resourceLineage'][0]['source'][0]
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'lineage.json', :fragment=>'source')
   #    assert_empty errors
   #
   # end

   def test_complete_source

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceLineage'][0]['source']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceLineage'][0]['source']

      assert_equal expect, got

   end

end
