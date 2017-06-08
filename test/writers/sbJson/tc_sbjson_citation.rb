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

      expect = 'Person 001(principalInvestigator), Person 002(principalInvestigator), Organization 001(funder), Person 003(funder), Person 004(funder), Person 001(funder), 2017-05(creation), 2017-05-16(Publication), 2017-05-16T16:10:00-09:00(revision), myCitationTitle, http://ISO.uri/adiwg/0, http://ISO.uri/adiwg/1'
      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['citation']

      assert_equal expect, got

   end

end


