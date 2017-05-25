# sbJson 1 writer tests - parent identifier

# History:
#  Stan Smith 2017-05-25 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonParentId < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('parentId.json')

   def test_rights

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])

      got = hJsonOut['parentId']
      expect = '1866dd77-d40c-4a0d-8589-cf6d0dec3ee4'

      assert_equal expect, got

   end

end


