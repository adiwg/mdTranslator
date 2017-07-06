# MdTranslator - minitest of
# reader / sbJson / module_tag

# History:
#   Stan Smith 2017-06-23 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_tag'

class TestReaderSbJsonTag < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Tag
   @@hIn = TestReaderSbJsonParent.getJson('tag.json')

   def test_complete_tag

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResInfo, hResponse)

      # total keyword sets
      assert_equal 11, metadata[:keywords].length

      # test resource types
      assert_equal 3, metadata[:resourceTypes].length
      assert_nil metadata[:resourceTypes][0][:name]
      assert_equal 'project', metadata[:resourceTypes][0][:type]

      # test tag type=string; scheme{missing}
      hSet = metadata[:keywords][0]
      assert_equal 2, hSet[:keywords].length
      assert_equal 'USGS Thesaurus', hSet[:keywordType]
      assert_empty hSet[:thesaurus]
      assert_equal 'Sitka Spruce', hSet[:keywords][0][:keyword]

      # test tag type{missing}; scheme{missing}
      hSet = metadata[:keywords][1]
      assert_equal 10, hSet[:keywords].length
      assert_nil hSet[:keywordType]
      assert_empty hSet[:thesaurus]
      assert_equal 'Popcorn', hSet[:keywords][0][:keyword]

      # test tag type='isoTopicCategory'; scheme{missing}
      hSet = metadata[:keywords][2]
      assert_equal 6, hSet[:keywords].length
      assert_equal 'isoTopicCategory', hSet[:keywordType]
      assert_empty hSet[:thesaurus]
      assert_equal 'farming', hSet[:keywords][0][:keyword]

      # test tag type=string; scheme=uri
      hSet = metadata[:keywords][3]
      assert_equal 2, hSet[:keywords].length
      assert_equal 'USGS Thesaurus', hSet[:keywordType]
      refute_empty hSet[:thesaurus]
      hThesaurus = hSet[:thesaurus]
      assert_equal 'Keyword Thesaurus', hThesaurus[:title]
      assert_equal 1, hThesaurus[:onlineResources].length
      refute_nil hThesaurus[:onlineResources][0][:olResURI]
      assert_equal 'ecosystems', hSet[:keywords][0][:keyword]

      # test tag type{missing}; scheme=uri
      hSet = metadata[:keywords][4]
      assert_equal 2, hSet[:keywords].length
      assert_equal 'USGS Thesaurus', hSet[:keywordType]
      refute_empty hSet[:thesaurus]
      hThesaurus = hSet[:thesaurus]
      assert_equal 'Keyword Thesaurus', hThesaurus[:title]
      assert_empty hThesaurus[:alternateTitles]
      assert_equal 1, hThesaurus[:onlineResources].length
      refute_nil hThesaurus[:onlineResources][0][:olResURI]
      assert_equal 'climate', hSet[:keywords][0][:keyword]

      # test tag type=string; scheme=string
      hSet = metadata[:keywords][5]
      assert_equal 2, hSet[:keywords].length
      assert_equal 'USGS Thesaurus', hSet[:keywordType]
      refute_empty hSet[:thesaurus]
      hThesaurus = hSet[:thesaurus]
      assert_equal 'Keyword Thesaurus', hThesaurus[:title]
      assert_empty hThesaurus[:onlineResources]
      assert_equal 1, hThesaurus[:alternateTitles].length
      assert_equal 'Science Catalog', hThesaurus[:alternateTitles][0]
      assert_equal 'astronomy', hSet[:keywords][0][:keyword]

      # test tag type=differentString; scheme=string
      hSet = metadata[:keywords][6]
      assert_equal 2, hSet[:keywords].length
      assert_equal 'USGS Thesaurus', hSet[:keywordType]
      refute_empty hSet[:thesaurus]
      hThesaurus = hSet[:thesaurus]
      assert_equal 'Keyword Thesaurus', hThesaurus[:title]
      assert_empty hThesaurus[:onlineResources]
      assert_equal 1, hThesaurus[:alternateTitles].length
      assert_equal 'LCC Catalog', hThesaurus[:alternateTitles][0]
      assert_equal 'caribou', hSet[:keywords][0][:keyword]

      # test tag type{missing}; scheme=URI
      hSet = metadata[:keywords][7]
      assert_equal 3, hSet[:keywords].length
      assert_nil hSet[:keywordType]
      refute_empty hSet[:thesaurus]
      hThesaurus = hSet[:thesaurus]
      assert_equal 'Keyword Thesaurus', hThesaurus[:title]
      assert_empty hThesaurus[:alternateTitles]
      assert_equal 1, hThesaurus[:onlineResources].length
      refute_nil hThesaurus[:onlineResources][0][:olResURI]
      assert_equal 'Larry', hSet[:keywords][0][:keyword]

      # test tag type{missing}; scheme=string
      hSet = metadata[:keywords][8]
      assert_equal 2, hSet[:keywords].length
      assert_nil hSet[:keywordType]
      refute_empty hSet[:thesaurus]
      hThesaurus = hSet[:thesaurus]
      assert_equal 'Keyword Thesaurus', hThesaurus[:title]
      assert_empty hThesaurus[:onlineResources]
      assert_equal 1, hThesaurus[:alternateTitles].length
      assert_equal 'National Phenology Network', hThesaurus[:alternateTitles][0]
      assert_equal 'lilac', hSet[:keywords][0][:keyword]

      # test tag type{missing}; scheme=differentURI
      hSet = metadata[:keywords][9]
      assert_equal 2, hSet[:keywords].length
      assert_nil hSet[:keywordType]
      refute_empty hSet[:thesaurus]
      hThesaurus = hSet[:thesaurus]
      assert_equal 'Keyword Thesaurus', hThesaurus[:title]
      assert_empty hThesaurus[:alternateTitles]
      assert_equal 1, hThesaurus[:onlineResources].length
      refute_nil hThesaurus[:onlineResources][0][:olResURI]
      assert_equal 'ptarmigan', hSet[:keywords][0][:keyword]

      # test tag type{missing}; scheme=differentString
      hSet = metadata[:keywords][10]
      assert_equal 2, hSet[:keywords].length
      assert_nil hSet[:keywordType]
      refute_empty hSet[:thesaurus]
      hThesaurus = hSet[:thesaurus]
      assert_equal 'Keyword Thesaurus', hThesaurus[:title]
      assert_empty hThesaurus[:onlineResources]
      assert_equal 1, hThesaurus[:alternateTitles].length
      assert_equal 'USGS ASC', hThesaurus[:alternateTitles][0]
      assert_equal 'volcano', hSet[:keywords][0][:keyword]

      # test execution
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
