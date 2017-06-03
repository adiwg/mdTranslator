# sbJson 1 writer tests - project

# History:
#  Stan Smith 2017-06-02 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonProject < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('project.json')

   def test_projectFacet

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = {
         'className' => 'gov.sciencebase.catalog.item.facet.ProjectFacet',
         'projectStatus' => 'In Progress',
         'parts' => [
            {
               'type' => 'Short Project Description',
               'value' => 'My Short Abstract'
            }
         ]
      }
      
      hJsonOut = JSON.parse(metadata[:writerOutput])
      aGot = hJsonOut['facets']
      got = {}
      aGot.each do |hGot|
         if hGot['className'] == 'gov.sciencebase.catalog.item.facet.ProjectFacet'
            got = hGot
         end
      end

      assert_equal expect, got

   end

end


