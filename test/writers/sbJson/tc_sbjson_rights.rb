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

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['rights']
      expect = 'myRightsConstraint 0; myRightsConstraint 1; myRightsConstraint 2; myRightsConstraint 3'

      assert_equal expect, got

   end

end


