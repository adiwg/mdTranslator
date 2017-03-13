# mdJson 2.0 writer tests - mdJson

# History:
#   Stan Smith 2017-03-10 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJson < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('mdJson.json')

   def test_schema_mdJson

      errors = TestWriterMdJsonParent.testSchema(@@jsonIn, 'schema.json')
      assert_empty errors

   end

   def test_complete_minimal_mdJson

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      got = JSON.parse(metadata[:writerOutput])

      assert_equal expect, got

   end

end
