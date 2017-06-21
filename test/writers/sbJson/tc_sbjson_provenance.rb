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
         'annotation' => 'generated using ADIwg mdTranslator ' + version,
      }

      assert_equal expect, got

   end

end


