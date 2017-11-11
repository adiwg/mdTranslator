# sbJson 1 writer tests - id

# History:
#  Stan Smith 2017-05-13 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonId < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('id.json')

   def test_id_no_valid_namespace

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['id']

      assert_nil got

   end

   def test_id_namespace_in_metadata

      hJsonIn = JSON.parse(@@jsonIn)
      hJsonIn['metadata']['metadataInfo']['metadataIdentifier']['namespace'] = 'gov.sciencebase.catalog'
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['id']

      assert_equal 'myMetadataIdentifier', got

   end

   def test_id_namespace_in_citation

      hJsonIn = JSON.parse(@@jsonIn)
      hJsonIn['metadata']['resourceInfo']['citation']['identifier'][1]['namespace'] = 'gov.sciencebase.catalog'
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['id']

      assert_equal 'myCitationIdentifier1', got

   end

end
