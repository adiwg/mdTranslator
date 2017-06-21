# sbJson 1 writer tests - rights

# History:
#  Stan Smith 2017-05-22 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonRights < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('rights.json')

   def test_rights

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = 'copyright - exclusive right to the publication, production, or sale of the rights to a literary, dramatic, musical, or artistic work, or to the use of a commercial print or label, granted by law for a specified period of time to an author, composer, artist, distributor; '
      expect += 'traditionalKnowledge - information protected by American Indian or Alaska Native rights or culture; '
      expect += 'myOtherConstraint 1; '
      expect += 'myOtherConstraint 2; '
      expect += 'intellectualPropertyRights - rights to financial benefit from and control of distribution of non-tangible property that is a result of creativity'
      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['rights']

      assert_equal expect, got

   end

end


