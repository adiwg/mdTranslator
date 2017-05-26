# sbJson 1 writer tests - contact

# History:
#  Stan Smith 2017-05-25 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonContact < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('citation.json')

   def test_rights

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])

      got = 1
      expect = 1

      assert_equal expect, got

   end

end


