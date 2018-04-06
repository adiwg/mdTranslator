# mdJson 2.0 writer tests - resource info

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonResourceInfo < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('resourceInfo.json')

   # TODO reinstate after schema update
   # def test_schema_resourceInfo
   #
   #    hIn = JSON.parse(@@jsonIn)
   #    hTest = hIn['metadata']['resourceInfo']
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'resourceInfo.json')
   #    assert_empty errors
   #
   # end

   def test_complete_resourceInfo

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'none', writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']

      # delete deprecated element from source mdJson so it will match output from writer
      expect.delete('topicCategory')

      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']

      assert_equal expect, got

   end

end
