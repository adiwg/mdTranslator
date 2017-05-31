# sbJson 1 writer tests - browse categories

# History:
#  Stan Smith 2017-05-31 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSBrowseCategory < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('browseCategory.json')

   def test_browseCategories

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = ['Document', 'Collection', 'Project', 'Data', 'Image', 'Report', 'Physical Item']

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['browseCategories']

      assert_equal expect, got

   end

end


