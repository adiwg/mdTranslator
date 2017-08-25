# MdTranslator - minitest of
# readers / fgdc / module_keyword

# History:
#   Stan Smith 2017-08-24 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcKeyword < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('keyword.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Keyword

   def test_keyword_complete

      xIn = @@xDoc.xpath('./metadata/idinfo/keywords')
      aKeywords = @@NameSpace.unpack(xIn, [], @@hResponseObj)

      refute_empty aKeywords
      assert_equal 6, aKeywords.length

      hKeyword = aKeywords[0]
      assert_equal 1, hKeyword[:keywords].length
      assert_equal 'theme', hKeyword[:keywordType]
      refute_empty hKeyword[:thesaurus]

      hThesaurus = hKeyword[:thesaurus]
      assert_equal 'ISO 19115', hThesaurus[:title]

      hKeywordObj = hKeyword[:keywords][0]
      assert_equal 'Biota', hKeywordObj[:keyword]
      assert_nil hKeywordObj[:keywordId]

      hKeyword = aKeywords[1]
      assert_equal 2, hKeyword[:keywords].length
      assert_equal 'theme', hKeyword[:keywordType]
      refute_empty hKeyword[:thesaurus]

      hKeyword = aKeywords[2]
      assert_equal 2, hKeyword[:keywords].length
      assert_equal 'place', hKeyword[:keywordType]
      refute_empty hKeyword[:thesaurus]

      hKeyword = aKeywords[3]
      assert_equal 1, hKeyword[:keywords].length
      assert_equal 'place', hKeyword[:keywordType]
      refute_empty hKeyword[:thesaurus]

      hKeyword = aKeywords[4]
      assert_equal 2, hKeyword[:keywords].length
      assert_equal 'stratum', hKeyword[:keywordType]
      refute_empty hKeyword[:thesaurus]

      hKeyword = aKeywords[5]
      assert_equal 2, hKeyword[:keywords].length
      assert_equal 'temporal', hKeyword[:keywordType]
      refute_empty hKeyword[:thesaurus]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
