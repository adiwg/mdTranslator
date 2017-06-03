# sbJson 1 writer tests - publication

# History:
#  Stan Smith 2017-06-03 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonPublication < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('publication.json')

   def test_publication

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = {
         'className' => 'gov.sciencebase.catalog.item.facet.CitationFacet',
         'citationType' => 'sciencePaper',
         'journal' => 'Journal Name',
         'edition' => 'Journal Issue Number',
         'language' => 'eng'
      }

      hJsonOut = JSON.parse(metadata[:writerOutput])
      aGot = hJsonOut['facets']
      got = {}
      aGot.each do |hGot|
         if hGot['className'] == 'gov.sciencebase.catalog.item.facet.CitationFacet'
            got = hGot
         end
      end

      assert_equal expect, got

   end

end


