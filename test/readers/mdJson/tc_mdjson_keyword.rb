# MdTranslator - minitest of
# reader / mdJson / module_keyword

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_keyword'

class TestReaderMdJsonKeyword < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Keyword
   aIn = TestReaderMdJsonParent.getJson('keyword.json')
   @@hIn = aIn['keyword'][0]

   def test_keyword_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'keyword.json')
      assert_empty errors

   end

   def test_complete_keyword_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata[:keywords].length
      assert_equal 'keywordType', metadata[:keywordType]
      refute_empty metadata[:thesaurus]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_keyword_empty_keyword

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['keyword'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson keyword keyword list is missing'

   end

   def test_keyword_missing_keyword

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('keyword')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson keyword keyword list is missing'

   end

   def test_keyword_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['keywordType'] = ''
      hIn['thesaurus'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:keywords]
      assert_nil metadata[:keywordType]
      assert_empty metadata[:thesaurus]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_keyword_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('keywordType')
      hIn.delete('thesaurus')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:keywords]
      assert_nil metadata[:keywordType]
      assert_empty metadata[:thesaurus]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_keyword_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson keyword object is empty'

   end

end
