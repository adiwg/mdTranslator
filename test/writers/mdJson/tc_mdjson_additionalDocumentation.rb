# mdJson 2.0 writer tests - additional documentation

# History:
#   Stan Smith 2017-03-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonAdditionalDocumentation < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('additionalDocumentation.json')

   def test_schema_additionalDocumentation

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['additionalDocumentation'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'additionalDocumentation.json')
      assert_empty errors

   end

   def test_complete_additionalDocumentation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['additionalDocumentation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['additionalDocumentation']

      assert_equal expect, got

   end

end
