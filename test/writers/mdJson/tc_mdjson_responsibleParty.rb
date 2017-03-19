# mdJson 2.0 writer tests - responsible party

# History:
#   Stan Smith 2017-03-18 original script

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterResponsibleParty < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('responsibleParty.json')

   def test_schema_responsibleParty

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['metadataInfo']['metadataContact'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'responsibility.json')
      assert_empty errors

   end

   def test_complete_responsibleParty

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['metadataInfo']['metadataContact']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['metadataContact']

      assert_equal expect, got

   end

end
