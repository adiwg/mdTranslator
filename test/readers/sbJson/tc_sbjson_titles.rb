# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
#   Stan Smith 2017-06-13 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_sbJson'

class TestReaderSbJsonSbJson < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Title
   @@hIn = TestReaderSbJsonParent.getJson('titles.json')

   def test_complete_titles

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 'title', metadata[:title]
      assert_equal 2, metadata[:alternateTitles].length
      assert_equal 'alternate title 1', metadata[:alternateTitles][0]
      assert_equal 'alternate title 2', metadata[:alternateTitles][1]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_titles

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['title'] = ''
      hIn['alternateTitles'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_nil metadata[:title]
      assert_empty metadata[:alternateTitles]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_titles

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('title')
      hIn.delete('alternateTitles')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_nil metadata[:title]
      assert_empty metadata[:alternateTitles]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
