# MdTranslator - minitest of
# reader / sbJson / module_body

# History:
#   Stan Smith 2017-06-19 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_body'

class TestReaderSbJsonBody < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Body
   @@hIn = TestReaderSbJsonParent.getJson('body.json')

   def test_complete_body

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      expect = "### Title\n**BOLD**\n\n* Item 1\n* Item 2\n\nWhitespace paragraph 1\n\nWhitespace paragraph 2"
      assert_equal expect, metadata[:abstract]
      assert_equal 'mySummary', metadata[:shortAbstract]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_id

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['body'] = ''
      hIn['summary'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_nil metadata[:abstract]
      assert_nil metadata[:shortAbstract]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_id

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('body')
      hIn.delete('summary')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_nil metadata[:abstract]
      assert_nil metadata[:shortAbstract]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
