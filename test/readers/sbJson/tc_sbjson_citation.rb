# MdTranslator - minitest of
# reader / sbJson / module_citation

# History:
#   Stan Smith 2017-06-19 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_citation'

class TestReaderSbJsonCitation < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Citation
   @@hIn = TestReaderSbJsonParent.getJson('citation.json')

   def test_complete_citation

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 'names, dates, and links', metadata[:otherDetails][0]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_citation

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['citation'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty metadata[:otherDetails]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_citation

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('citation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty metadata[:otherDetails]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
