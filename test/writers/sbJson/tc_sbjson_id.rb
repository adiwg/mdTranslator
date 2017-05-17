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

   def test_id_metadata_identifier

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['id']

      assert_equal 'myMetadataIdentifier', got

   end

   def test_id_metadata_citation

      hJsonIn = JSON.parse(@@jsonIn)
      hJsonIn['metadata']['metadataInfo'].delete('metadataIdentifier')
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['id']

      assert_equal 'myCitationIdentifier0', got

   end

   def test_id_default

      hJsonIn = JSON.parse(@@jsonIn)
      hJsonIn['metadata']['metadataInfo'].delete('metadataIdentifier')
      hJsonIn['metadata']['resourceInfo']['citation'].delete('identifier')
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['id']

      refute_nil got

   end

end
