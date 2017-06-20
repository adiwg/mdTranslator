# MdTranslator - minitest of
# reader / sbJson / module_rights

# History:
#   Stan Smith 2017-06-19 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_purpose'

class TestReaderSbJsonRights < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Rights
   @@hIn = TestReaderSbJsonParent.getJson('rights.json')

   def test_complete_rights

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'legal', metadata[:type]
      assert_equal 'These are my rights.', metadata[:legalConstraint][:otherCons][0]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_rights

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['rights'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_rights

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('rights')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
