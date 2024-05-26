# sbJson 1 writer tests - citation

# History:
#  Stan Smith 2017-05-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonCitation < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('citation.json')

   def test_citation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = 'Person 001, myCitationTitle'
      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['citation']

      assert_equal expect, got

   end

end
