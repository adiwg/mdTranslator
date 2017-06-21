# MdTranslator - minitest of
# reader / sbJson / module_purpose

# History:
#   Stan Smith 2017-06-19 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_purpose'

class TestReaderSbJsonPurpose < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Purpose
   @@hIn = TestReaderSbJsonParent.getJson('purpose.json')

   def test_complete_purpose

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 'This is my purpose.', metadata[:purpose]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_purpose

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['purpose'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_nil metadata[:purpose]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_purpose

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('purpose')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_nil metadata[:purpose]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
