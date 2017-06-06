# sbJson 1 writer tests - provenance

# History:
#  Stan Smith 2017-05-23 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonProvenance < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('provenance.json')

   def test_provenance

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['provenance']
      version = ADIWG::Mdtranslator::VERSION
      expect = {
         'dataSource' => 'generated using ADIwg mdTranslator ' + version,
         'dateCreated' => '2017-02-16T15:12:47',
         'lastUpdated' => '2017-05-22'
      }

      assert_equal expect, got

   end

end


