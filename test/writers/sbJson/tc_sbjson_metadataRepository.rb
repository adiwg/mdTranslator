# sbJson 1 writer tests - metadata repository

# History:
#  Stan Smith 2017-06-06 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonMetadataRepository < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('metadataRepository.json')

   def test_metadataRepository

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = {
         'repository' => 'data.gov',
         'title' => 'Arctic LCC Data.gov',
         'identifier' => '6f991cdb-6bf5-4f1d-a05b-4b8345455150',
         'metadataStandard' => 'FGDC'
      }

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['metadataRepository']

      assert_equal expect, got

   end

end


