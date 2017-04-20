# mdJson 2.0 writer tests - image description

# History:
#   Stan Smith 2017-03-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterImageDescription < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('image.json')

   def test_schema_image

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['coverageDescription'][0]['imageDescription']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'imageDescription.json')
      assert_empty errors

   end

   def test_complete_image

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
