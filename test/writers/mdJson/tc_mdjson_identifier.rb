# mdJson 2.0 writer tests - identifier

# History:
#   Stan Smith 2017-03-13 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterIdentifier < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('identifier.json')

   def test_schema_identifier

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['citation']['identifier'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'identifier.json')
      assert_empty errors

   end

   def test_complete_identifier

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['citation']['identifier']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['citation']['identifier']

      assert_equal expect, got

   end

end
