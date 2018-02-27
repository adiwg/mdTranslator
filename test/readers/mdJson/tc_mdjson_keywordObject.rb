# MdTranslator - minitest of
# reader / mdJson / module_keywordObject

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-12-09 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_keywordObject'

class TestReaderMdJsonKeywordObject < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::KeywordObject
   aIn = TestReaderMdJsonParent.getJson('keywordObject.json')
   @@hIn = aIn['keywordObject'][0]

   def test_keywordObject_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'keyword.json', :fragment => 'keywordObject')
      assert_empty errors

   end

   def test_complete_keywordObject

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'keyword0', metadata[:keyword]
      assert_equal 'keywordId0', metadata[:keywordId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_keywordObject_empty_keyword

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['keyword'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson keyword object is missing keyword'

   end

   def test_keywordObject_missing_keyword

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('keyword')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson keyword object is missing keyword'

   end

   def test_keywordObject_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['keywordId'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'keyword0', metadata[:keyword]
      assert_nil metadata[:keywordId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_keywordObject_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('keywordId')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'keyword0', metadata[:keyword]
      assert_nil metadata[:keywordId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_keywordObject

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: keyword object is empty'

   end

end
