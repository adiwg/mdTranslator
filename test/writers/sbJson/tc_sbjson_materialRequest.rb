# sbJson 1 writer tests - material request instructions

# History:
#  Stan Smith 2017-05-25 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonMaterialRequest < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('materialRequest.json')

   def test_rights

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])

      got = hJsonOut['materialRequestInstructions']
      expect = 'myName(role1 - myInstructions0); myOrganization(role2 - myInstructions2); myOtherOrganization(role2 - myInstructions2); myOtherOrganization(role3)'

      assert_equal expect, got

   end

end


